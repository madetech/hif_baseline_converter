module HifBaselineConverter
  module ConverterHelpers
    def remove_nil_data_points(data_points, data_point_length)
      # [[nil, nil], [1,2]] -> [[1,2]]
      data_points.delete_if { |data_point| data_point.count(nil) == data_point_length }
    end

    def remove_empty_data_points(data_points, data_point_length)
      # [['', '', ''], [1,2, '']] -> [[1,2,'']]
      data_points.delete_if { |data_point| data_point.count('') == data_point_length }
    end

    def reshape_data(data)
      # [[1,2], [3,4], [5,6]] -> [[1,3,5], [2,4,6]]
      data.first.map.with_index { |val,i| [data[0][i], data[1][i], data[2][i]] }
    end

    def sanitize_input(input)
      input.map { |value| value.nil? ? '' : "#{value}"}
    end
  end
end
