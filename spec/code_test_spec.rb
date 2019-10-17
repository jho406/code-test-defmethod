require 'rspec'
require_relative '../lib/code_test'
require 'byebug'

RSpec.describe do
  context 'import_sample_files' do
    it 'imports comma.txt' do
      comma_records = [
        {last_name: 'Abercrombie', first_name: 'Neil', sex: :male, color: 'Tan', dob: Date.new(1943, 2, 13)},
        {last_name: 'Bishop', first_name: 'Timothy', sex: :male, color: 'Yellow', dob: Date.new(1967, 4, 23)},
        {last_name: 'Kelly', first_name: 'Sue', sex: :female, color: 'Pink', dob: Date.new(1959, 7, 12)}
      ]

      pipe_records = [
        {last_name: 'Smith', first_name: 'Steve', initial: 'D', sex: :male, color: 'Red', dob: Date.new(1985, 3, 3)},
        {last_name: 'Bonk', first_name: 'Radek', initial: 'S', sex: :male, color: 'Green', dob: Date.new(1975, 6, 3)},
        {last_name: 'Bouillon', first_name: 'Francis', initial: 'G', sex: :male, color: 'Blue', dob: Date.new(1975, 6, 3)}
      ]

      space_records = [
        {last_name: 'Kournikova', first_name: 'Anna', initial: 'F', sex: :female, color: 'Red', dob: Date.new(1975, 6, 3)},
        {last_name: 'Hingis', first_name: 'Martina', initial: 'M', sex: :female, color: 'Green', dob: Date.new(1979, 4, 2)},
        {last_name: 'Seles', first_name: 'Monica', initial: 'H', sex: :female, color: 'Black', dob: Date.new(1973, 12, 2)}
      ]

      result = CodeTest.import_sample_files
      expect(result).to eql(comma_records + pipe_records + space_records)
    end
  end
end
