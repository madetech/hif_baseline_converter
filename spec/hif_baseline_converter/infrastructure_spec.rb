RSpec.describe HifBaselineConverter::Infrastructure do
  include_context "shared file"
  it 'parses Infrastructure' do
    puts spreadsheet.convert.to_json
    expect(spreadsheet.convert).to match_json_schema("infrastructure")
  end
end
