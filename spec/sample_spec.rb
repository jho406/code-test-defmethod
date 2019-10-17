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
end


