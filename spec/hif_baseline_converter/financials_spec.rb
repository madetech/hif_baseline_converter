RSpec.describe HifBaselineConverter::Financials do
  include_context 'shared file'
  it 'parses Financials' do
    puts spreadsheet.convert.to_json
    expect(spreadsheet.convert).to match_json_schema('financials')
  end
end
