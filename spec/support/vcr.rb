require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join("spec", "vcr_cassettes")
  c.hook_into :webmock
end