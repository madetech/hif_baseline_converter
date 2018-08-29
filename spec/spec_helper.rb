require 'bundler/setup'
require 'hif_baseline_converter'
require 'json_matchers/rspec'

JsonMatchers.schema_root = 'spec/support/schemas'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context 'shared file', shared_context: :metadata do
  let(:baseline_file) { "#{__dir__}/support/HIF Baseline.xlsx" }
  let(:spreadsheet) {described_class.new(file: baseline_file) }
end

RSpec.configure do |rspec|
  rspec.include_context 'shared file', include_shared: true
end
