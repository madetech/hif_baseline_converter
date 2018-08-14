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


