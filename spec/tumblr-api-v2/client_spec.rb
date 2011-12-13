require 'spec_helper'

describe TumblrApiV2::Client do
  use_vcr_cassette

  it "should instance a Client" do
    TumblrApiV2::Client.new.should be_a(TumblrApiV2::Client)
  end

  it "should instance a Client with a consumer key" do
    c = TumblrApiV2::Client.new('fake-consumer-key')
    c.consumer_key.should == 'fake-consumer-key'
  end
  
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

    describe "#avatar" do
      it "should get blog's avatar" do
        avatar = TumblrApiV2::Client.new.avatar('http://fgiusti-test-data.tumblr.com/')
        avatar.headers['content-type'].should  == 'image/png'
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

