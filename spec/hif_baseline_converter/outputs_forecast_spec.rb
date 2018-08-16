RSpec.describe HifBaselineConverter::OutputsForecast do
  include_context 'shared file'
  it 'parses outputs actual section' do
    puts spreadsheet.convert.to_json
    expect(spreadsheet.convert).to match_json_schema('outputs_forecast')
  end
end
