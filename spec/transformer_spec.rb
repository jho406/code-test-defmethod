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

    it 'transforms the sex to a lowercase symbol of a single role' do
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
  end
end

