RSpec.describe HifBaselineConverter::Loader do
  include_context 'shared file'
  it 'loads xlsx' do
    expect(spreadsheet.xlsx).to be_a Roo::Excelx
  end
end
