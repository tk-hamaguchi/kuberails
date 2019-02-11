# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = {
    record:            :once,
    match_requests_on: %i[method host path]
  }
end

RSpec.configure do |c|
  c.around(:context) do |context|
    VCR.use_cassette('default') do
      context.run
    end
  end
end
