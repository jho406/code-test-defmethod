require 'code_test/parser'
require 'code_test/transformer'

module CodeTest
  extend self

  def import_sample_files
    headers = [:first_name, :last_name, :sex, :color, :dob]
    current_path = File.dirname(__FILE__)
    comma_file = '../input_files/comma.txt'
    full_path = File.join(current_path, comma_file)

    records = Parser.parse_from_file(full_path, headers: headers, delimiter: ',')
    Transfomer.transform_records(records)
  end
end
