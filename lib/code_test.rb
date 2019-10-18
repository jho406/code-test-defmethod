require 'code_test/input'
require 'code_test/transformer'
require 'code_test/output'

module CodeTest
  extend self

  FILES_HEADERS_AND_DELIMITERS = [
    ['comma.txt', [:last_name, :first_name, :sex, :color, :dob], ','],
    ['pipe.txt',  [:last_name, :first_name, :initial, :sex, :color, :dob], '|'],
    ['space.txt', [:last_name, :first_name, :initial, :sex, :dob, :color], ' '],
  ]

  def run
    records = import_input
    output_1 = Output.show_by_gender_sex_asc_then_last_name_asc(records)
    output_2 = Output.show_by_dob_asc_then_last_name_asc(records)
    output_3 = Output.show_by_last_name_dsc(records)

    puts [output_1, output_2, output_3].join("\n")
  end

  def import_input
    all_records = FILES_HEADERS_AND_DELIMITERS.flat_map do |opts|
      file_name, headers, delimiter = opts

      current_path = File.dirname(__FILE__)
      full_path = File.join(current_path, '../input_files', file_name)

      Input.parse_from_file(full_path, headers, delimiter)
    end

    transform_records(all_records)
  end

  def transform_records(records = [])
    Transformer.transform_each_value(records) do |key, value|
      value = value.strip

      case key
      when :sex
        Transformer.transform_sex(value)
      when :dob
        Transformer.transform_date(value)
      else
        value
      end
    end
  end
end
