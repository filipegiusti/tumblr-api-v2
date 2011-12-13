require "httparty"

module TumblrApiV2
  class TumblrError < StandardError; end

  class Client
    include HTTParty
    base_uri 'http://api.tumblr.com/v2'

    attr_reader :consumer_key
    
    METHODS = {
      apikey: {
        info:  '/info',
        posts: '/posts'
      }
    }

    METHODS.each do |access, methods|
      methods.each do |method, path|
        define_method method do |*args|
          raise ArgumentError if args.size > 2 || args.size == 0
          blog_url, options = *args
          options ||= {}
          get_on_path(blog_url, path, options)
        end
      end
    end

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

    def get_on_path(blog_url, path, options = {})
      raise TumblrError unless has_apikey_access?

      blog_domain = filter_blog_domain(blog_url)
      get_blog_api("/#{blog_domain}#{path}", query: options.merge(apikey_option))
    end

    def filter_blog_domain(blog_url)
      blog_url.gsub(/^https?:\/\//, '').chomp('/')
    end
  end
end
