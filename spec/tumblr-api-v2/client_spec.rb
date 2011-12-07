require 'spec_helper'

describe TumblrApiV2::Client do
  it "should instance a Client" do
    TumblrApiV2::Client.new.should be_a(TumblrApiV2::Client)
  end

  it "should instance a Client with a consumer key" do
    c = TumblrApiV2::Client.new('fake-consumer-key')
    c.consumer_key.should == 'fake-consumer-key'
  end
end

