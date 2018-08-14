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
      @row_start = 4 ; @row_end = 28
    end

    def row_names(row)
      SUMMARY_KEY_REGS.detect{|json, name| row_name(row) =~ /#{name.downcase}/}.first
    end
  end
end
