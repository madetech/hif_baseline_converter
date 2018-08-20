module HifBaselineConverter
  class Financials < Loader
    def initialize(file:)
      super
      @title = :financials
      @row_start = 74; @row_end = 94
    end

    def convert
      [
        baseline_installment_periods.merge(
          costs: funding_stack,
          baselineCashFlow: { }, # TODO: TDB note: files to be sent with this sheet
          recovery: recovery
          )
      ]
    end

    def recovery
      sheet_ary = @xlsx.to_a[89..91]
      {
        aimToRecover: sheet_ary[0][2],
        expectedAmountToRemove: sheet_ary[1][2],
        methodOfRecovery: sheet_ary[2][2]
      }
    end

    def funding_stack
      infra_start_row = 80
      data_start = 80
      data_end = 84
      sheet_ary = @xlsx.to_a[data_start..data_end]
      infra_nums = sheet_ary[0].compact
      column_start = 4 # column d

      raise '"No "Cost of Infrastructure" defined ' unless infra_nums.size > 1

      infra_num = infra_nums.size - 1
      infrastructures = []

      infra_num.times do |num|
        col_num = column_start + num
        concerned_columns = @xlsx.column(col_num).to_a[data_start..data_end]
        descriptions = @xlsx.column('b').to_a[data_start..data_end]
        infrastructures << build_costs(concerned_columns, descriptions)
      end
      infrastructures
    end

    def build_costs(concerned_columns, descriptions = nil)
      concerned_columns.each_with_index do |a,i|
        puts "#{a}, #{i}, #{descriptions[i] if descriptions}" if $debug
      end

      # buld the hash structure and map with the positions in the array
      {
        costOfInfrastructure:         concerned_columns[0].to_s,
        fundingStack: {
          totallyFundedThroughHIF:    concerned_columns[1],
          descriptionOfFundingStack:  concerned_columns[2],
          totalPublic:                concerned_columns[3],
          totalPrivate:               concerned_columns[4]
        }
      }
    end

    def baseline_installment_periods
      base_start  = 76
      base_end    = 77

      baseline_dates = @xlsx.row(76).compact
      num_of_base_lines = baseline_dates.size

      funding_profile =
        num_of_base_lines.times.map do |col|
          col_num = 2 + col
          [@xlsx.row(base_start)[col_num], @xlsx.row(base_end)[col_num]]
        end
      # build a multi ray of dates, values [[date, value],[date,value]]
      filled_funding_profiles = funding_profile.select { |profile| profile unless profile.last.nil? }

      raise 'No "HIF Funding Profile - Baseline" defined ' unless filled_funding_profiles.any?

      period = "#{filled_funding_profiles.first.first.year}/#{filled_funding_profiles.last.first.year}"
      instalments =
        filled_funding_profiles.map do |profile|
          { dateOfInstalment: profile.first, instalmentAmount: profile.last }
        end

      { instalments: instalments, period: period }
    end
  end
end

__END__
"financial": [
      {
        "period": "2019/2020",
        "instalments": [
          {
            "dateOfInstalment": "2020-01-01",
            "instalmentAmount": "1000",
            "baselineInstalments": [
              {
                "baselineInstalmentYear": "4000",
                "baselineInstalmentQ1": "1000",
                "baselineInstalmentQ2": "1000",
                "baselineInstalmentQ3": "1000",
                "baselineInstalmentQ4": "1000",
                "baselineInstalmentTotal": "1000"
              }
            ]
          }
        ],
        "costs": [
          {
            "costOfInfrastructure": "1000",
            "fundingStack": {
              "totallyFundedThroughHIF": true,
              "descriptionOfFundingStack": "Stack",
              "totalPublic": "2000",
              "totalPrivate": "2000"
            }
          }
        ],
        "baselineCashFlow": {
          "summaryOfRequirement": "uri"
        },
        "recovery": {
          "aimToRecover": true,
          "expectedAmountToRemove": 10,
          "methodOfRecovery": "Recovery method"
        }
      }
    ],
