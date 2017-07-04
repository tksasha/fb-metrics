class URIParser
  DEFAULT_SCHEME = 'http'

  SCHEMES = %r(^(http|https|//))

  def initialize uri
    uri = "#{ DEFAULT_SCHEME }://#{ uri }" unless uri =~ SCHEMES

    @uri = URI.parse uri
  end

  def hostname
    @uri.hostname || @uri.path
  end

  def scheme
    @uri.scheme || DEFAULT_SCHEME
  end

  def scheme_and_host
    "#{ scheme }://#{ hostname }"
  end
end
