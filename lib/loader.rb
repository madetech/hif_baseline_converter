require 'pry'
require 'json'

require_relative 'hif_baseline_converter/railtie' if defined?(Rails)
require_relative 'hif_baseline_converter/loader'
require_relative 'hif_baseline_converter/helpers/converter_helpers'

require_relative 'hif_baseline_converter/converters/summary'
require_relative 'hif_baseline_converter/converters/infrastructure'
require_relative 'hif_baseline_converter/converters/financials'
require_relative 'hif_baseline_converter/converters/outputs_actual'
require_relative 'hif_baseline_converter/converters/s_one_five_one'
require_relative 'hif_baseline_converter/converters/outputs_forecast'

require_relative 'hif_baseline_converter/converter'

$debug = false
module HifBaselineConverter
end
