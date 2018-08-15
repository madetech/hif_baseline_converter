module HifBaselineConverter
  class SOneFiveOne < Loader
    def initialize(file:)
      super
    end

    def convert
      data_start = 95
      data_end = 96
      sheet_ary = @xlsx.to_a[data_start..data_end]

      funding_end_data = sheet_ary[0][1].iso8601
      project_longstop_date = sheet_ary[1][1].iso8601

      {
        s151FundingEndDate: funding_end_data,
        s151ProjectLongstopDate: project_longstop_date
      }
      end

    end
    # {
    #    "type":"object",
    #    "title":"Section 151",
    #    "properties":{
    #       "s151FundingEndDate":{
    #          "type":"string",
    #          "format":"date",
    #          "title":"HIF Funding End Date"
    #       },
    #       "s151ProjectLongstopDate":{
    #          "type":"string",
    #          "format":"date",
    #          "title":"Project Longstop date"
    #       }
    #    }
    # }
end
