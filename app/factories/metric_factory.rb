require 'open-uri'

class MetricFactory
  delegate :scheme, :host, to: :uri

  def initialize params={}
    @uri = params[:uri]

    @depth = params[:depth]
  end

  def create
    puts links
  end

  private
  def uri
    URIParser.parse @uri
  end

  def html
    Nokogiri::HTML(open "#{ scheme }://#{ host }")
  end

  def links
    html.css('a').map do |link|
      href = URI.parse link.attr 'href'

      case
      #
      # like `/companies.html`
      #
      when href.host.nil? && href.scheme.nil?
        href
      #
      # like `mailto:mail@tksasha.me`
      #
      when href.host.nil? && href.scheme.present? && href.scheme =~ URIParser::SCHEMES
        href
      #
      # like `http://www.tksasha.me/companies.html`
      #
      # where `www.tksasha.me` is the same host
      #
      when href.host == host && href.scheme.present? && href.scheme =~ URIParser::SCHEMES
        href
      end
    end.compact
  end

  class << self
    def create *args
      new(*args).create
    end
  end
end
