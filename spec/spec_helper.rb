require 'rubygems'
require 'bundler/setup'

require 'tumblr-api-v2'

# VCR configuration
require 'vcr'

apikeys = YAML.load_file("spec/apikeys.yml")
CONSUMER_KEY = apikeys['consumer-key']

VCR.configure do |c|
  c.hook_into :fakeweb
  c.cassette_library_dir = 'spec/cassettes'
  c.default_cassette_options = { :record => :new_episodes }
#  c.default_cassette_options = { :record => :none }
  c.filter_sensitive_data('<CONSUMER-KEY>') { CONSUMER_KEY }
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end
