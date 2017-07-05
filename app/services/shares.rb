require 'open-uri'

class Shares
  URL = 'https://graph.facebook.com?ids='

  def initialize url
    @url = url
  end

  def count
    json[@url]['share']['share_count']
  end

  private
  def json
    JSON.parse open("#{ URL }#{ @url }&access_token=#{ facebook_access_token }").read
  end

  def facebook_access_token
    ENV['FACEBOOK_ACCESS_TOKEN']
  end

  class << self
    def count *args
      new(*args).count
    end
  end
end
