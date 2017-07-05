require 'open-uri'

class MetricFactory
  attr_accessor :depth

  delegate :scheme, :host, to: :url

  def initialize params={}
    @url = params[:url]

    @depth = params[:depth].to_i
  end

  def create
    return if depth.zero?

    self.depth -= 1

    links.map do |link|
      Rails.logger.info link.to_s

      page = site.pages.find_or_create_by url: link.to_s

      shares_count = Shares.count link.to_s

      if metric = page.metric
        metric.update shares_count: shares_count
      else
        page.create_metric shares_count: shares_count
      end

      MetricFactory.create url: link.to_s, depth: depth
    end
  end

  private
  def url
    URLParser.parse @url
  end

  def html
    Nokogiri::HTML(open url.to_s)
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
      when href.host.nil? && href.scheme.present? && href.scheme =~ URLParser::SCHEMES
        href
      #
      # like `http://www.tksasha.me/companies.html`
      #
      # where `www.tksasha.me` is the same host
      #
      when href.host == host && href.scheme.present? && href.scheme =~ URLParser::SCHEMES
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
