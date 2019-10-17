require 'rspec'
require_relative '../lib/code_test'
require 'byebug'

RSpec.describe do
  context 'import_sample_files' do
    it 'imports comma.txt' do
      comma_records = [
        {first_name: 'Abercrombie', last_name: 'Neil', sex: :male, color: 'Tan', dob: Date.new(1943, 2, 13)},
        {first_name: 'Bishop', last_name: 'Timothy', sex: :male, color: 'Yellow', dob: Date.new(1967, 4, 23)},
        {first_name: 'Kelly', last_name: 'Sue', sex: :female, color: 'Pink', dob: Date.new(1959, 7, 12)}
      ]

      result = CodeTest.import_sample_files
      expect(result).to eql comma_records
    end
  end
end
