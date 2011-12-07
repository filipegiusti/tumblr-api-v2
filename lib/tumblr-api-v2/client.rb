require "tumblr-api-v2/apikey_api"
require "httparty"

module TumblrApiV2
  class TumblrError < StandardError; end

  class Client
    include ApikeyApi

    include HTTParty
    base_uri 'http://api.tumblr.com/v2'

    attr_reader :consumer_key

    def initialize(consumer_key = nil)
      @consumer_key = consumer_key
    end

    private

    def get_blog_api(path, options = {})
      self.class.get("/blog#{path}", options)
    end

    def apikey_option
      { api_key: @consumer_key }
    end

    def has_apikey_access?
      not @consumer_key.nil?
    end
  end
end
