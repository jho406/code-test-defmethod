require 'rspec'
require_relative '../lib/code_test'
require 'byebug'

RSpec.describe 'Sample' do
  context '.transform_records' do
    it 'strips the ends of all values' do
      records = [{
        foo: ' Kelly ',
      }]

      results = CodeTest::Sample.transform_records(records)
      expect(results).to eql([{
        foo: 'Kelly',
      }])
    end

    it 'returns first_name and last_name untouched' do
      records = [{
        first_name: 'Kelly',
        last_name: 'Sue',
      }]

      results = CodeTest::Sample.transform_records(records)
      expect(results).to eql([{
        first_name: 'Kelly',
        last_name: 'Sue'
      }])
    end

    it 'transforms the sex to a lowercase symbol' do
      records = [
        {sex: 'Male'},
        {sex: 'Female'}
      ]

      results = CodeTest::Sample.transform_records(records)
      expect(results).to eql([
        {sex: :male},
        {sex: :female}
      ])
    end

    it 'transforms the dob to a date' do
      records = [
        {dob: '2/13/1943'},
        {dob: '4/23/1967'}
      ]

      results = CodeTest::Sample.transform_records(records)
      expect(results).to eql([
        {dob: Date.new(1943, 2, 13)},
        {dob: Date.new(1967, 4, 23)}
      ])
    end
  end

  context '.import' do
    it 'imports comma.txt, pipe.txt, and space.txt' do
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

      result = CodeTest::Sample.import
      expect(result).to eql(comma_records + pipe_records + space_records)
    end
  end

  context 'view_by_last_name_dsc' do
    it 'shows no records if records is empty' do
      records = []
      output = CodeTest::Sample.view_by_last_name_dsc(records)
      expect(output).to eql <<~OUTPUT
      Output 3:
      No records
      OUTPUT
    end

    it 'show a list of records sorted by lastname in dsc order' do
      records = [
        {last_name: 'Abc', first_name: 'Zoo', sex: 'Male', color: 'Tan', dob: Date.new(1943, 2, 13)},
        {last_name: 'Def', first_name: 'Xoo', sex: 'Male', color: 'Gan', dob: Date.new(1943, 2, 13)},
        {last_name: 'Ghi', first_name: 'Voo', sex: 'Male', color: 'Tan', dob: Date.new(1943, 2, 13)}
      ]
      output = CodeTest::Sample.view_by_last_name_dsc(records)
      expect(output).to eql <<~OUTPUT
      Output 3:
      Ghi Voo Male 2/13/1943 Tan
      Def Xoo Male 2/13/1943 Gan
      Abc Zoo Male 2/13/1943 Tan
      OUTPUT
    end
  end

end


