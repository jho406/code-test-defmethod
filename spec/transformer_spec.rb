require 'rspec'
require_relative '../lib/transformer'
require 'byebug'

RSpec.describe 'Transformer' do
  context '.transform_comma' do
    it 'returns a blank hash when passed an empty hash' do
      records = []
      results = Transfomer.transform_comma(records)
      expect(results).to eql([])
    end

    it 'returns first_name and last_name untouched' do
      records = [{
        first_name: 'Kelly',
        last_name: 'Sue',
      }]

      results = Transfomer.transform_comma(records)
      expect(results).to eql([{
        first_name: 'Kelly',
        last_name: 'Sue'
      }])
    end

    it 'transforms the sex to a lowercase symbol of a single rows' do
      records = [{
        sex: 'Male'
      }]

      results = Transfomer.transform_comma(records)
      expect(results).to eql([{
        sex: :male
      }])
    end

    it 'transforms the sex to a lowercase symbol of multiple rows' do
      records = [{
        sex: 'Male'
      },
      {
        sex: 'Female'
      }]

      results = Transfomer.transform_comma(records)
      expect(results[0]).to eql({
        sex: :male
      })

      expect(results[1]).to eql({
        sex: :female
      })
    end

    it 'transforms the dob to a date' do
      records = [
        {dob: '2/13/1943'},
        {dob: '4/23/1967'}
      ]

      results = Transfomer.transform_comma(records)
      expect(results).to eql([
        {dob: Date.new(1943, 2, 13)},
        {dob: Date.new(1967, 4, 23)}
      ])
    end
  end

  context '.transform_pipe' do
    it 'returns a blank hash when passed an empty hash' do
      records = []
      results = Transfomer.transform_pipe(records)
      expect(results).to eql([])
    end

    it 'returns first_name and last_name untouched' do
      records = [{
        first_name: 'Kelly',
        last_name: 'Sue',
      }]

      results = Transfomer.transform_pipe(records)
      expect(results).to eql([{
        first_name: 'Kelly',
        last_name: 'Sue'
      }])
    end

    it 'transforms the sex to a lowercase symbol of a single rows' do
      records = [{
        sex: 'M'
      }]

      results = Transfomer.transform_pipe(records)
      expect(results).to eql([{
        sex: :male
      }])
    end

    it 'transforms the sex to a lowercase symbol of multiple rows' do
      records = [{
        sex: 'M'
      },
      {
        sex: 'F'
      }]

      results = Transfomer.transform_pipe(records)
      expect(results[0]).to eql({
        sex: :male
      })

      expect(results[1]).to eql({
        sex: :female
      })
    end

    it 'transforms the dob to a date' do
      records = [
        {dob: '2-13-1943'},
        {dob: '4-23-1967'}
      ]

      results = Transfomer.transform_pipe(records)
      expect(results).to eql([
        {dob: Date.new(1943, 2, 13)},
        {dob: Date.new(1967, 4, 23)}
      ])
    end
  end

  context '.transform_sex' do
    it 'Raises invalid sex if sex is not valid' do
      sex = 'MMMMMMinvalid'
      expect {
        Transfomer.transform_sex(sex)
      }.to raise_error(Transfomer::InvalidValue)
    end

    it 'transforms the values of "Male" or "M" to a symbol' do
      sex = 'Male'
      result = Transfomer.transform_sex(sex)
      expect(result).to eql :male

      sex = 'M'
      result = Transfomer.transform_sex(sex)
      expect(result).to eql :male
    end

    it 'transforms the values of "Female" or "F" to a symbol' do
      sex = 'Female'
      result = Transfomer.transform_sex(sex)
      expect(result).to eql :female

      sex = 'F'
      result = Transfomer.transform_sex(sex)
      expect(result).to eql :female
    end
  end
end

