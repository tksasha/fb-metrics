require 'open-uri'

class MetricFactory
  delegate :scheme, :host, to: :uri

  def initialize params={}
    @uri = params[:uri]

    @depth = params[:depth]
  end

  def create
    links.map do |link|
      page = site.pages.find_or_create_by url: link.to_s

      shares_count = Shares.count link.to_s

      if metric = page.metric
        metric.update shares_count: shares_count
      else
        page.create_metric shares_count: shares_count
      end
    end
  end

  private
  def uri
    URIParser.parse @uri
  end

  def html
    Nokogiri::HTML(open uri.to_s)
  end

  def links
    html.css('a').map do |link|
      href = URI.parse link.attr 'href'

      case
      #
      # like `/companies.html`
      #
      when href.host.nil? && href.scheme.nil?
        href.scheme = scheme

        href.host = host

        href
      #
      # avoid links like `mailto:mail@tksasha.me`
      #
      when href.host.nil? && href.scheme.present? && href.scheme =~ URIParser::SCHEMES
        href
      #
      # like `http://www.tksasha.me/companies.html`
      #
      # where `www.tksasha.me` is the same host
      #
      when href.host == host && href.scheme.present? && href.scheme =~ URIParser::SCHEMES
        href.path = '/' if href.path.empty?

        href
      end
    end.compact
  end

  def site
    @site ||= Site.find_or_create_by url: host
  end

  class << self
    def create *args
      new(*args).create
    end
  end
end
