RSpec.describe HifBaselineConverter::OutputsActual do
  include_context 'shared file'
  it 'parses outputs actual section' do
    puts spreadsheet.convert.to_json
    expect(spreadsheet.convert).to match_json_schema('outputs_actual')
  end
end
