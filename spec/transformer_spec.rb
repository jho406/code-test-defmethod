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
        first_name: 'Kelly',
        sex: 'Male'
      }]

      results = Transfomer.transform_comma(records)
      expect(results).to eql([{
        first_name: 'Kelly',
        sex: :male
      }])
    end

    it 'transforms the sex to a lowercase symbol of multple rows' do
      records = [{
        first_name: 'John',
        sex: 'Male'
      },
      {
        first_name: 'Kelly',
        sex: 'Female'
      }]

      results = Transfomer.transform_comma(records)
      expect(results[0]).to eql({
        first_name: 'John',
        sex: :male
      })

      expect(results[1]).to eql({
        first_name: 'Kelly',
        sex: :female
      })
    end
  end
end

