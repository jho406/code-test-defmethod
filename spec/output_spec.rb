require 'rspec'
require_relative '../lib/code_test'
require 'byebug'

RSpec.describe 'CodeTest::Output' do
  context '.view' do
    it 'shows just the title and "No records" if passed no records' do
      records = []
      output = CodeTest::Output.view(records)
      expect(output).to eql <<~OUTPUT
      My Records:
      No records
      OUTPUT
    end
  end
end

