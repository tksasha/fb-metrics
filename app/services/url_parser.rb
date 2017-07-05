class URLParser
  DEFAULT_SCHEME = 'http'

  SCHEMES = %r(^(http|https|//))

  def initialize url
    @url = url
  end

  def parse
    @url = "#{ DEFAULT_SCHEME }://#{ @url }" unless @url =~ SCHEMES

    @url = URI.parse @url

    @url.scheme = DEFAULT_SCHEME unless @url.scheme

    @url
  end

  class << self
    def parse *args
      new(*args).parse
    end
  end
end
