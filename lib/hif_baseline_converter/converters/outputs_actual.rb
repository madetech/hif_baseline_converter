module HifBaselineConverter
  class OutputsActual < Loader
    include HifBaselineConverter::ConverterHelpers

    def initialize(file:)
      super
      @title = :outputs_actual
    end

    def convert
      data_start = 109
      data_end = 112
      sheet_ary = @xlsx.to_a[data_start..data_end]
      user_data = drop_column_names(sheet_ary)
      user_data = reshape_data(user_data).map {|data_point| sanitize_input(data_point) }
      user_data = remove_empty_data_points(user_data, 3)

      { siteOutputs: user_data.map { |data_point| parse_data_point(data_point) } }
      end

      private

      def drop_column_names(sheet_ary)
        sheet_ary.map { |cols| cols.drop(1) }
      end

      def parse_data_point(cols)
        siteName = cols[0]
        siteLocalAuthority = cols[1]
        siteNumberOfUnits = cols[2]
        {
          siteName: siteName,
          siteLocalAuthority: siteLocalAuthority,
          siteNumberOfUnits: siteNumberOfUnits
        }
      end
    end
    # {
    #    "type":"object",
    #    "title":"Outputs - Actual",
    #    "properties":{
    #       "siteOutputs":{
    #          "type":"array",
    #          "title":"Site Outputs",
    #          "items":{
    #             "type":"object",
    #             "properties":{
    #                "siteName":{
    #                   "type":"string",
    #                   "title":"Name of site"
    #                },
    #                "siteLocalAuthority":{
    #                   "type":"string",
    #                   "title":"Local Authority"
    #                },
    #                "siteNumberOfUnits":{
    #                   "type":"string",
    #                   "title":"Number of Units"
    #                }
    #             }
    #          }
    #       }
    #    }
    # }
end
