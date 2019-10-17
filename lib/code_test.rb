require 'code_test/parser'
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
    output_1 = show_by_gender_sex_asc_then_last_asc(records)
    output_2 = show_by_dob_asc_then_last_name_asc(records)
    output_3 = show_by_last_name_dsc(records)

    puts [output_1, output_2, output_3].join("\n")
  end

  def show_by_gender_sex_asc_then_last_asc(records=[])
    #Output 1 - sorted by gender (females before males) then by last name ascending
    sorted_records = records.sort_by do |record|
      [record[:sex], record[:last_name]]
    end

    Output.view(sorted_records, 'Output 1:')
  end

  def show_by_dob_asc_then_last_name_asc(records=[])
    #Output 2 - sorted by birth date, ascending then by last name ascending
    sorted_records = records.sort_by do |record|
      [record[:dob], record[:last_name]]
    end

    Output.view(sorted_records, 'Output 2:')
  end

  def show_by_last_name_dsc(records=[])
    #Output 3 - sorted by last name, descending
    sorted_records = records.sort do |top, bottom|
      bottom[:last_name] <=> top[:last_name]
    end

    Output.view(sorted_records, 'Output 3:')
  end

  def import_input
    all_records = FILES_HEADERS_AND_DELIMITERS.flat_map do |opts|
      file_name, headers, delimiter = opts

      current_path = File.dirname(__FILE__)
      full_path = File.join(current_path, '../input_files', file_name)

      Parser.parse_from_file(full_path, headers: headers, delimiter: delimiter)
    end

    transform_records(all_records)
  end

  def transform_records(records = [])
    Transfomer.transform_each_value(records) do |key, value|
      value = value.strip

      case key
      when :sex
        Transfomer.transform_sex(value)
      when :dob
        Transfomer.transform_date(value)
      else
        value
      end
    end
  end
end
