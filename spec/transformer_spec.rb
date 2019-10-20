require 'rspec'
require_relative '../lib/code_test'

RSpec.describe 'Transformer' do
  context '.transform_each_value' do
    it 'returns a blank array when passed an empty array' do
      records = []
      results = CodeTest::Transformer.transform_each_value(records)
      expect(results).to eql([])
    end

    it 'yields through each key and value in one row, and uses the result as the new value' do
      values = [
        {foo: 'bar'}
      ]

      new_values = CodeTest::Transformer.transform_each_value(values) do |key, value|
        "The key is #{key} and the value is #{value}"
      end

      expect(new_values).to eql [
        {foo: 'The key is foo and the value is bar'}
      ]
    end

    it 'yields through each key and value in all rows, and uses the result as the new value' do
      values = [
        {foo: 'bar 1'},
        {foo: 'bar 2'}
      ]

      new_values = CodeTest::Transformer.transform_each_value(values) do |key, value|
        "The key is #{key} and the value is #{value}"
      end

      expect(new_values).to eql [
        {foo: 'The key is foo and the value is bar 1'},
        {foo: 'The key is foo and the value is bar 2'}
      ]
    end
  end

  context '.transform_date' do
    it 'raises invalid date if date is not valid' do
      date = '000000'
      expect {
        CodeTest::Transformer.transform_date(date)
      }.to raise_error(CodeTest::Transformer::InvalidDateValueError, 'invalid date: 000000')
    end

    it 'parses a date' do
      date = '01 01 2010'
      expect(
        CodeTest::Transformer.transform_date(date)
      ).to eql(Date.new(2010, 1, 1))
    end

    it 'parses a date ignoring any delimiter' do
      date = '01-01|2010'
      expect(
        CodeTest::Transformer.transform_date(date)
      ).to eql(Date.new(2010, 1, 1))
    end
  end

  context '.transform_sex' do
    it 'raises invalid sex if sex is not valid' do
      sex = 'MMMMMMinvalid'
      expect {
        CodeTest::Transformer.transform_sex(sex)
      }.to raise_error(CodeTest::Transformer::InvalidSexValueError, 'invalid sex: MMMMMMinvalid')
    end

    it 'transforms the values of "Male" or "M" to a fully worded word' do
      sex = 'Male'
      result = CodeTest::Transformer.transform_sex(sex)
      expect(result).to eql 'Male'

      sex = 'M'
      result = CodeTest::Transformer.transform_sex(sex)
      expect(result).to eql 'Male'
    end

    it 'transforms the values of "Female" or "F" to a fully worded word' do
      sex = 'Female'
      result = CodeTest::Transformer.transform_sex(sex)
      expect(result).to eql 'Female'

      sex = 'F'
      result = CodeTest::Transformer.transform_sex(sex)
      expect(result).to eql 'Female'
    end
  end
end

