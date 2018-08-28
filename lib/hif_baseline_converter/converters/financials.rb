module HifBaselineConverter
  class Financials < Loader
    def initialize(file:)
      super
      @title = :financial
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
        aimToRecover: to_bool(sheet_ary[0][2]),
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
          totallyFundedThroughHIF:    to_bool(concerned_columns[1]),
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

      installments = filled_funding_profiles.group_by{|ppp| ppp.first.year}

      allinstalments =
        installments.map do |p_year, quarters|

          baselineInstalments = {}
          quarters.each_with_index do |(q, val),i|
            baselineInstalments["baselineInstalmentQ#{i+1}".to_sym] = val
            raise 'too many quarters' if i > 3
          end
          dateOfInstalment = Date.new(p_year).to_s
          pay_quarters = baselineInstalments.values
          baselineInstalmentYear = pay_quarters.sum
          baselineInstalmentTotal = baselineInstalmentYear / pay_quarters.size
          instalmentAmount = baselineInstalmentTotal
                  {
                    "dateOfInstalment": dateOfInstalment,
                    "instalmentAmount": instalmentAmount.to_s,
                    "baselineInstalments": [
                      {
                        "baselineInstalmentYear": baselineInstalmentYear.to_s,
                        "baselineInstalmentTotal": baselineInstalmentTotal.to_s
                      }.merge(baselineInstalments)
                    ]
                  }
        end
      {
        period: period,
        instalments: allinstalments
      }
    end

    private

    def to_bool(str)
      str == 'YES'
    end
  end
end
