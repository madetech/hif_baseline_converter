RSpec.describe HifBaselineConverter::SOneFiveOne do
  include_context 'shared file'
  it 'parses outputs actual section' do
    puts spreadsheet.convert.to_json
    expect(spreadsheet.convert).to match_json_schema('s_one_five_one')
  end
end
