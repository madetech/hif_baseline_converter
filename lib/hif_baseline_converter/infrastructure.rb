module HifBaselineConverter
  INFRASTRUCTURE_KEY_REGS =
    {
      'BIDReference' => 'No. of HIF funded Infrastructure',
    }


  class Infrastructure < Loader

    def initialize(file:)
      super
      @row_start = 31
      @row_end = 72
    end

    def convert
      # row 3 - row 29
      # match the rows that fall under the Summary section
      rownum = 0
      summaries =
        @xlsx.each_with_object({}) do |row, obj|
          next if (rownum += 1) < @row_start || rownum > @row_end
          if row.any?
            json_key = row_names(row)
            puts json_key
            obj[json_key] = row_value(row)
          end
        end

      summaries
    end

    def row_names(row)
      INFRASTRUCTURE_KEY_REGS.detect{|json, name| row_name(row) =~ /#{name.downcase}/}.first
    end
  end
end
