module HifBaselineConverter
  class Converter
    def initialize(file_path:)
      @file_path = file_path
      @converters = [
        Summary,
        Financials,
        Infrastructure,
        OutputsActual,
        OutputsForecast,
        SOneFiveOne
      ]
    end

    def use_converters_with_title
      {
        type: 'hif',
        baselineData:
          converters.map { |c| c.new(file:file_path) }.map(&:convert_with_title).reduce(&:merge)
      }
    end

    def convert_to_pretty_json
      JSON.pretty_generate(use_converters_with_title)
    end

    private

    attr_reader :file_path, :converters
  end
end
