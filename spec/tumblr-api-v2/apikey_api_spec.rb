require 'spec_helper'

describe TumblrApiV2::ApikeyApi do
  use_vcr_cassette

  it "without a consumer key should raise an exception" do
    expect do
      TumblrApiV2::Client.new.info('http://fgiusti-test-data.tumblr.com/')
    end.to raise_error(TumblrApiV2::TumblrError)
  end
  
  describe "with a valid consumer key" do
    before(:each) do
      @client = TumblrApiV2::Client.new(CONSUMER_KEY)
    end

    describe "#info" do
      it "should get blog's info" do
        info = @client.info('http://fgiusti-test-data.tumblr.com/')
        info['response']['blog']['title'].should  == 'Cool blog.'
      end
    end

    describe "#posts" do
      it "should get blog's posts" do
        info = @client.posts('http://fgiusti-test-data.tumblr.com/')
        info['response']['posts'].last['post_url'].should  == 'http://fgiusti-test-data.tumblr.com/post/6140355204/thats-a-test-post'
      end
    end
  end
end
