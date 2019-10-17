require 'rspec'
require_relative '../lib/code_test'
require 'byebug'

RSpec.describe 'Transformer' do
  context '.transform_values' do
    it 'returns a blank hash when passed an empty hash' do
      records = []
      results = CodeTest::Transfomer.transform_values(records)
      expect(results).to eql([])
    end

    it 'yields through each key and value in one row, and uses the result as the new value' do
      values = [
        {foo: 'bar'},
      ]

      new_values = CodeTest::Transfomer.transform_values(values) do |k, v|
        v + ' world'
      end

      expect(new_values).to eql [
        {foo: 'bar world'},
      ]
    end

    it 'yields through each key and value in all rows, and uses the result as the new value' do
      values = [
        {foo: 'bar'},
        {foo: 'bax'},
      ]

      new_values = CodeTest::Transfomer.transform_values(values) do |k, v|
        v + ' world'
      end

      expect(new_values).to eql [
        {foo: 'bar world'},
        {foo: 'bax world'}
      ]
    end
  end

  context '.transform_date' do
    it 'Raises invalid sex if sex is not valid' do
      date = '000000'
      expect {
        CodeTest::Transfomer.transform_date(date)
      }.to raise_error(CodeTest::Transfomer::InvalidDateValue)
    end

    it 'parses a date' do
      date = '01 01 2010'
      expect(
        CodeTest::Transfomer.transform_date(date)
      ).to eql(Date.new(2010, 1, 1))
    end

    it 'parses a date ignoring any delimiter' do
      date = '01-01|2010'
      expect(
        CodeTest::Transfomer.transform_date(date)
      ).to eql(Date.new(2010, 1, 1))
    end
  end

  context '.transform_sex' do
    it 'Raises invalid sex if sex is not valid' do
      sex = 'MMMMMMinvalid'
      expect {
        CodeTest::Transfomer.transform_sex(sex)
      }.to raise_error(CodeTest::Transfomer::InvalidSexValue)
    end

    it 'transforms the values of "Male" or "M" to a symbol' do
      sex = 'Male'
      result = CodeTest::Transfomer.transform_sex(sex)
      expect(result).to eql :male

      sex = 'M'
      result = CodeTest::Transfomer.transform_sex(sex)
      expect(result).to eql :male
    end

    it 'transforms the values of "Female" or "F" to a symbol' do
      sex = 'Female'
      result = CodeTest::Transfomer.transform_sex(sex)
      expect(result).to eql :female

      sex = 'F'
      result = CodeTest::Transfomer.transform_sex(sex)
      expect(result).to eql :female
    end
  end
end

