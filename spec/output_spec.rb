require 'rspec'
require_relative '../lib/code_test'
require 'byebug'

RSpec.describe 'CodeTest::Output' do
  context '.view' do
    it 'shows just the title if passed no records' do
      records = []
      output = CodeTest::Output.view(records)
      expect(output).to eql <<~OUTPUT
      My Records:
      OUTPUT
    end
  end
end

