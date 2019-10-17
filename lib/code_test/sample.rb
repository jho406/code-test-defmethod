module CodeTest
  module Sample
    extend self

    FILES_HEADERS_AND_DELIMITERS = [
      ['comma.txt', [:last_name, :first_name, :sex, :color, :dob], ','],
      ['pipe.txt',  [:last_name, :first_name, :initial, :sex, :color, :dob], '|'],
      ['space.txt', [:last_name, :first_name, :initial, :sex, :dob, :color], ' '],
    ]

    def import
      all_records = FILES_HEADERS_AND_DELIMITERS.flat_map do |v|
        file_name, headers, delimiter = v

        current_path = File.dirname(__FILE__)
        comma_file = '../input_files/comma.txt'
        full_path = File.join(current_path, '../input_files', file_name)

        Parser.parse_from_file(full_path, headers: headers, delimiter: delimiter)
      end

      transform_records(all_records)
    end

    def transform_records(records = [])
      Transfomer.transform_values(records) do |k, v|
        v = v.strip

        case k
        when :sex
          Transfomer.transform_sex(v)
        when :dob
          Transfomer.transform_date(v)
        else
          v
        end
      end
    end
  end
end