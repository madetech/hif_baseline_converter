RSpec.describe HifBaselineConverter::Summary do
  include_context "shared file"
  it 'parses summary' do
    # puts spreadsheet.convert.to_json
    expect(spreadsheet.convert).to match_json_schema("summary")
  end
end
