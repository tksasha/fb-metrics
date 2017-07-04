class URIParser
  DEFAULT_SCHEME = 'http'

  SCHEMES = %r(^(http|https|//))

  def initialize uri
    @uri = uri
  end

  def parse
    @uri = "#{ DEFAULT_SCHEME }://#{ @uri }" unless @uri =~ SCHEMES

    @uri = URI.parse @uri

    @uri.scheme = DEFAULT_SCHEME unless @uri.scheme

    @uri
  end

  class << self
    def parse *args
      new(*args).parse
    end
  end
end
