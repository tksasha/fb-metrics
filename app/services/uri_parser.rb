class URIParser
  DEFAULT_SCHEME = 'http'

  SCHEMES = %r(^(http|https|//))

  def initialize uri
    uri = "#{ DEFAULT_SCHEME }://#{ uri }" unless uri =~ SCHEMES

    @uri = URI.parse uri
  end

  def parse
    URI::Generic.build scheme: scheme, host: host
  end

  private
  def host
    @uri.host || @uri.path
  end

  def scheme
    @uri.scheme || DEFAULT_SCHEME
  end

  class << self
    def parse *args
      new(*args).parse
    end
  end
end
