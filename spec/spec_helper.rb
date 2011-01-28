require 'rspec'
require 'stacked'
require 'webmock'

Dir["spec/support/**/*.rb"].each { |f| require f }

# Uncomment only for debugging as we only ever want to test against the real API.
# At least, until it becomes stable.
# FakeWeb.allow_net_connect = false

RSpec.configure do |c|
  c.before(:all) do
    Stacked::Client.configure do |config|
      config.api_key = "FAKE"
    end
  end
end
