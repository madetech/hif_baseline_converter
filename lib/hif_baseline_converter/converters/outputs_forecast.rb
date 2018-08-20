module HifBaselineConverter
  class OutputsForecast < Loader
    include HifBaselineConverter::ConverterHelpers

    def initialize(file:)
      super
      @title = :outputsForecast
    end

    def convert
      data_start = 100
      data_end = 105
      sheet_ary = @xlsx.to_a[data_start..data_end]
      forecastingData = sheet_ary.drop(3)

      {
        totalUnits: sheet_ary[0][2],
        disposalStrategy: sheet_ary[1][2],
        housingForecast: generateForecasts(forecastingData)
      }
      end

      private

      def generateForecasts(forecasting_data)
        forecasting_data = reshape_data(forecasting_data).drop(2)
        forecasting_data = remove_nil_data_points(forecasting_data, 3)
        forecasting_data.map do |data_point|
          {
            date: standardize_date(data_point[0]),
            target: data_point[1].iso8601,
            housingCompletions: data_point[2].iso8601
          }
        end
      end

      def standardize_date(date)
        date_mappings = {
          '18/19' => '2018/2019',
          '19/20' => '2019/2020',
          '20/21' => '2020/2021',
          '21/22' => '2021/2022',
          '2022-25' => '2022/2025',
          '2025-30' => '2025/2030',
          '30-35' => '2030/2035',
          'Future' => 'Future'
        }
        date_mappings[date]
      end

    end
    # {
    #    "type":"object",
    #    "title":"Outputs - Forecast",
    #    "properties":{
    #       "totalUnits":{
    #          "type":"integer",
    #          "title":"Total Units"
    #       },
    #       "disposalStrategy":{
    #          "type":"string",
    #          "title":"Disposal Strategy / Critical Path"
    #       },
    #       "housingForecast":{
    #          "type":"array",
    #          "title":"Housing Forecast",
    #          "items":{
    #             "type":"object",
    #             "properties":{
    #                "date":{
    #                   "type":"string",
    #                   "title":"Date"
    #                },
    #                "target":{
    #                   "type":"string",
    #                   "format":"date",
    #                   "title":"Housing Starts"
    #                },
    #                "housingCompletions":{
    #                   "type":"string",
    #                   "format":"date",
    #                   "title":"Housing Completions"
    #                }
    #             }
    #          }
    #       }
    #    }
    # }
end
