module TumblrApiV2
  module ApikeyApi
    def info(blog_url)
      get_on_path(blog_url, '/info')
    end

    def posts(blog_url)
      get_on_path(blog_url, '/posts')
    end

    private

    def get_on_path(blog_url, path)
      raise TumblrError unless has_apikey_access?

      blog_domain = filter_blog_domain(blog_url)
      get_blog_api("/#{blog_domain}#{path}", query: apikey_option)
    end

    def filter_blog_domain(blog_url)
      blog_url.gsub(/^https?:\/\//, '').chomp('/')
    end
  end
end
