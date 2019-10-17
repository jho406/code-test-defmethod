require 'code_test/parser'
require 'code_test/transformer'

module CodeTest
  extend self

  def import_sample_files
    files_and_headers = [
      ['comma.txt', [:last_name, :first_name, :sex, :color, :dob], ','],
      ['pipe.txt',  [:last_name, :first_name, :initial, :sex, :color, :dob], '|'],
      ['space.txt', [:last_name, :first_name, :initial, :sex, :dob, :color], ' '],
    ]

    all_records = files_and_headers.flat_map do |v|
      file_name, headers, delimiter = v

      current_path = File.dirname(__FILE__)
      comma_file = '../input_files/comma.txt'
      full_path = File.join(current_path, '../input_files', file_name)

      Parser.parse_from_file(full_path, headers: headers, delimiter: delimiter)
    end

    Transfomer.transform_records(all_records)
  end
end
