class HifBaselineConverter::Railtie < Rails::Railtie
  rake_tasks do
    load 'tasks/convert_baseline.rake'
  end
end
