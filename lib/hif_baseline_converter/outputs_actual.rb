module HifBaselineConverter
  class OutputsActual < Loader
    def initialize(file:)
      super
    end

    def convert
      data_start = 109
      data_end = 112
      sheet_ary = @xlsx.to_a[data_start..data_end]
      user_data = drop_column_names(sheet_ary)
      user_data = reshape_data(user_data).map {|data_point| sanitize_input(data_point) }
      user_data = remove_empty_data_points(user_data)

      { siteOutputs: user_data.map { |data_point| parse_data_point(data_point) } }
      end

      private

      def remove_empty_data_points(data_points)
        # [['', '', ''], [1,2, '']] -> [[1,2,'']]
        data_points.delete_if { |data_point| data_point.count('') == 3 }
      end

      def reshape_data(data)
        # [[1,2], [3,4], [5,6]] -> [[1,3,5], [2,4,6]]
        data.first.map.with_index { |val,i| [data[0][i], data[1][i], data[2][i]] }
      end

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

      def sanitize_input(input)
        input.map { |value| value.nil? ? '' : "#{value}"}
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
