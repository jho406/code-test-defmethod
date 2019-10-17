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

    it 'shows a single formatted record with a formatted dob' do
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

  context '.show_by_last_name_dsc' do
    it 'shows no records if records is empty' do
      records = []
      output = CodeTest::Output.show_by_last_name_dsc(records)
      expect(output).to eql <<~OUTPUT
      Output 3:
      No records
      OUTPUT
    end

    it 'show a list of records sorted by lastname in dsc order' do
      records = [
        {last_name: 'Abc', first_name: 'Zoo', sex: 'Male', color: 'Tan', dob: Date.new(1943, 2, 13)},
        {last_name: 'Def', first_name: 'Xoo', sex: 'Male', color: 'Gan', dob: Date.new(1943, 2, 13)},
        {last_name: 'Ghi', first_name: 'Voo', sex: 'Male', color: 'Tan', dob: Date.new(1943, 2, 13)}
      ]
      output = CodeTest::Output.show_by_last_name_dsc(records)
      expect(output).to eql <<~OUTPUT
      Output 3:
      Ghi Voo Male 2/13/1943 Tan
      Def Xoo Male 2/13/1943 Gan
      Abc Zoo Male 2/13/1943 Tan
      OUTPUT
    end
  end

  context '.show_by_dob_asc_then_last_name_asc' do
    it 'shows no records if records is empty' do
      records = []
      output = CodeTest::Output.show_by_dob_asc_then_last_name_asc(records)
      expect(output).to eql <<~OUTPUT
      Output 2:
      No records
      OUTPUT
    end

    it 'show a list of records sorted by lastname in dsc order' do
      records = [
        {last_name: 'Bbc', first_name: 'Joe', sex: 'Male', color: 'Tan', dob: Date.new(1943, 3, 13)},
        {last_name: 'Abc', first_name: 'Joe', sex: 'Male', color: 'Tan', dob: Date.new(1943, 3, 13)},
        {last_name: 'Def', first_name: 'Joe', sex: 'Male', color: 'Gan', dob: Date.new(1943, 2, 13)},
        {last_name: 'Aef', first_name: 'Joe', sex: 'Male', color: 'Gan', dob: Date.new(1943, 2, 13)},
        {last_name: 'Ahi', first_name: 'Joe', sex: 'Male', color: 'Tan', dob: Date.new(1943, 1, 13)},
        {last_name: 'Zhi', first_name: 'Joe', sex: 'Male', color: 'Tan', dob: Date.new(1943, 1, 13)}
      ]
      output = CodeTest::Output.show_by_dob_asc_then_last_name_asc(records)
      expect(output).to eql <<~OUTPUT
      Output 2:
      Ahi Joe Male 1/13/1943 Tan
      Zhi Joe Male 1/13/1943 Tan
      Aef Joe Male 2/13/1943 Gan
      Def Joe Male 2/13/1943 Gan
      Abc Joe Male 3/13/1943 Tan
      Bbc Joe Male 3/13/1943 Tan
      OUTPUT
    end
  end

  context '.show_by_gender_sex_asc_then_last_asc' do
    it 'shows no records if records is empty' do
      records = []
      output = CodeTest::Output.show_by_gender_sex_asc_then_last_asc(records)
      expect(output).to eql <<~OUTPUT
      Output 1:
      No records
      OUTPUT
    end

    it 'show a list of records sorted by lastname in dsc order' do
      records = [
        {last_name: 'Zbc', first_name: 'Jil', sex: 'Female', color: 'Tan', dob: Date.new(1943, 1, 13)},
        {last_name: 'Abc', first_name: 'Joe', sex: 'Male', color: 'Tan', dob: Date.new(1943, 1, 13)},
        {last_name: 'Vef', first_name: 'Jil', sex: 'Female', color: 'Gan', dob: Date.new(1943, 1, 13)},
        {last_name: 'Def', first_name: 'Joe', sex: 'Male', color: 'Gan', dob: Date.new(1943, 1, 13)},
        {last_name: 'Ahi', first_name: 'Jil', sex: 'Female', color: 'Tan', dob: Date.new(1943, 1, 13)},
        {last_name: 'Zhi', first_name: 'Joe', sex: 'Male', color: 'Tan', dob: Date.new(1943, 1, 13)}
      ]
      output = CodeTest::Output.show_by_gender_sex_asc_then_last_asc(records)
      expect(output).to eql <<~OUTPUT
      Output 1:
      Ahi Jil Female 1/13/1943 Tan
      Vef Jil Female 1/13/1943 Gan
      Zbc Jil Female 1/13/1943 Tan
      Abc Joe Male 1/13/1943 Tan
      Def Joe Male 1/13/1943 Gan
      Zhi Joe Male 1/13/1943 Tan
      OUTPUT
    end
  end
end


