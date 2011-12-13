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
      },
      none: {
        avatar: '/avatar'
      }
    }

    METHODS.each do |access, methods|
      methods.each do |method, path|
        define_method method do |*args|
          raise ArgumentError if args.size > 2 || args.size == 0
          raise TumblrError unless send("has_#{access}_access?")

          blog_url, options = *args
          options ||= {}
          
          default_options = send("#{access}_options")
          blog_domain = filter_blog_domain(blog_url)
          get_blog_api("/#{blog_domain}#{path}", query: options.merge(default_options) )
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

    def apikey_options
      { api_key: @consumer_key }
    end

    def none_options
      { }
    end

    def has_apikey_access?
      not @consumer_key.nil?
    end

    def has_none_access?
      true
    end

    def filter_blog_domain(blog_url)
      blog_url.gsub(/^https?:\/\//, '').chomp('/')
    end
  end
end
