module HifBaselineConverter
  SUMMARY_KEY_REGS =
    {
      'BIDReference' => 'reference',
      'projectName' => 'Project Name',
      'leadAuthority' => 'Authority',
      "projectDescription" => "Project description",
      "projectType" => "Greenfield", # this appears to be unused ATM
      "polygonsUrl" => "Polygons", # this appears to be unused ATM
      "noOfHousingSites" => 'No. of housing sites',
      "totalArea" => 'area',
      "hifFundingAmount" => "Funding",
      "descriptionOfInfrastructure" => "Infrastructure",
      "descriptionOfWiderProjectDeliverables" => "Wider",
      "sitePlan" => "Site Plan", # this appears to be unused ATM
      "urls" => "Comma seporated urls" # this appears to be unused ATM
    }

  class Summary < Loader

    def initialize(file:)
      super
    end

    def convert
      # row 3 - row 29
      # match the rows that fall under the Summary section
      rownum = 0; row_start = 4 ; row_end = 28
      summaries =
        @xlsx.each_with_object({}) do |row, obj|
          next if (rownum += 1) < row_start || rownum > row_end
          # obj[row_name] = row_value(row)
          if row.any?
            json_key = row_names(row)
            # puts json_key
            obj[json_key] = row_value(row)
          end
        end

      summaries
    end

    def row_names(row)
      SUMMARY_KEY_REGS.detect{|json, name| row_name(row) =~ /#{name.downcase}/}.first
    end
  end
end
