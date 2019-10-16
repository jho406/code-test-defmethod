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
        sex: 'Male'
      }]

      results = Transfomer.transform_pipe(records)
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
end

