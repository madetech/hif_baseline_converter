namespace :he do
  desc 'Parse the whole HIF spreadsheet'
  task :parse_hif_sheet, [:sheet_path] do |t, args|
    sheet_path = args[:sheet_path]
    raise ArgumentError.new('Path to HIF file is required') if sheet_path.nil?
    raise StandardError.new('Specified path is not a file') unless File.file?(sheet_path)
    puts HifBaselineConverter::Converter.new(file_path: sheet_path).convert_to_pretty_json
  end
end
