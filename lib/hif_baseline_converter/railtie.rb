class HifBaselineConverter::Railtie < Rails::Railtie
  rake_tasks do
    load 'tasks/convert_baseline.rake'
    load 'tasks/parse_hif_sheet.rake'
  end
end
