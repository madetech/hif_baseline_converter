module HifBaselineConverter
  SUMMARY_KEY_REGS =
    {
      'BIDReference' => 'reference',
      'projectName' => 'Project Name',
      'leadAuthority' => 'Authority',
      'projectDescription' => 'Project description',
      'projectType' => 'Greenfield', # TODO: this appears to be unused ATM
      'polygonsUrl' => 'Polygons', # TODO: this appears to be unused ATM
      'noOfHousingSites' => 'No. of housing sites',
      'totalArea' => 'area',
      'hifFundingAmount' => 'Funding',
      'descriptionOfInfrastructure' => 'Infrastructure',
      'descriptionOfWiderProjectDeliverables' => 'Wider',
      'sitePlan' => 'Site Plan', # TODO: this appears to be unused ATM
      'urls' => 'Comma seporated urls' # TODO: this appears to be unused ATM
    }.freeze

  class Summary < Loader
    def initialize(file:)
      super
      @title = :summary
      @row_start = 4; @row_end = 28
    end

    def row_names(row)
      SUMMARY_KEY_REGS.detect { |_json, name| row_name(row) =~ /#{name.downcase}/ }.first
    end
  end
end
