require 'rspec'
require 'stacked'
require 'webmock'

puts "REQUIRING EVERYTHING"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |f| p f; require f }

# Uncomment only for debugging as we only ever want to test against the real API.
# At least, until it becomes stable.
# FakeWeb.allow_net_connect = false

RSpec.configure do |c|
  c.include(WebMock::API)
  c.before(:all) do
    Stacked::Client.configure do |config|
      config.api_key = "FAKE"
    end
  end
end
