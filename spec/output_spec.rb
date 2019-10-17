require 'rspec'
require_relative '../lib/code_test'

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

    it 'shows a different title' do
      records = []
      output = CodeTest::Output.view(records, 'Foobar records:')
      expect(output).to eql <<~OUTPUT
      Foobar records:
      No records
      OUTPUT
    end

    it 'shows a single formatted record' do
      records = [
        {last_name: 'Smith', first_name: 'John', sex: 'Male', dob: Date.new(2014, 1, 20), color: 'Tan'}
      ]
      output = CodeTest::Output.view(records)
      expect(output).to eql <<~OUTPUT
      My Records:
      Smith John Male 1/20/2014 Tan
      OUTPUT
    end

    it 'shows a long list of formatted records and custom title' do
      records = [
        {last_name: 'Smith', first_name: 'John', sex: 'Male', dob: Date.new(2014, 1, 20), color: 'Tan'},
        {last_name: 'Smith', first_name: 'John', sex: 'Male', dob: Date.new(2014, 1, 20), color: 'Blue'}
      ]
      output = CodeTest::Output.view(records, "Output 100:")
      expect(output).to eql <<~OUTPUT
      Output 100:
      Smith John Male 1/20/2014 Tan
      Smith John Male 1/20/2014 Blue
      OUTPUT
    end
  end
end


