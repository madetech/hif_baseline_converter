require 'roo'
require 'pry'
# require 'active_support'
# require 'active_support/core_ext'

module HifBaselineConverter
  class Loader
    attr_reader :xlsx
    def initialize(file:)
      @xlsx = Roo::Excelx.new(file)
    end

    def convert
      # row 3 - row 29
      # match the rows that fall under the Summary section
      @xlsx.to_a[@row_start..@row_end].each_with_object({}) do |row, obj|
        if row.any?
          json_key = row_names(row)
          # puts json_key
          obj[json_key] = row_value(row)
        end
      end
    end

    def row_name(row)
      row.compact
         .first
         .downcase
    end

    def row_value(row)
      row[1..-1].compact.last
    end
  end
end


