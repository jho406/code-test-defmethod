require 'rspec'
require_relative '../lib/code_test'

RSpec.describe 'CodeTest' do
  context '.transform_records' do
    it 'strips the ends of all values' do
      records = [{
        foo: ' Kelly '
      }]

      results = CodeTest.transform_records(records)
      expect(results).to eql([{
        foo: 'Kelly'
      }])
    end

    it 'returns first_name and last_name untouched' do
      records = [{
        first_name: 'Kelly',
        last_name: 'Sue'
      }]

      results = CodeTest.transform_records(records)
      expect(results).to eql([{
        first_name: 'Kelly',
        last_name: 'Sue'
      }])
    end

    it 'tranforms to ensure sex is capitalized and fully worded' do
      records = [
        {sex: 'Male'},
        {sex: 'F'}
      ]

      results = CodeTest.transform_records(records)
      expect(results).to eql([
        {sex: 'Male'},
        {sex: 'Female'}
      ])
    end

    it 'transforms the dob to a date' do
      records = [
        {dob: '2/13/1943'},
        {dob: '4/23/1967'}
      ]

      results = CodeTest.transform_records(records)
      expect(results).to eql([
        {dob: Date.new(1943, 2, 13)},
        {dob: Date.new(1967, 4, 23)}
      ])
    end
  end

  context '.import_input' do
    it 'imports comma.txt, pipe.txt, and space.txt' do
      comma_records = [
        {last_name: 'Abercrombie', first_name: 'Neil', sex: 'Male', color: 'Tan', dob: Date.new(1943, 2, 13)},
        {last_name: 'Bishop', first_name: 'Timothy', sex: 'Male', color: 'Yellow', dob: Date.new(1967, 4, 23)},
        {last_name: 'Kelly', first_name: 'Sue', sex: 'Female', color: 'Pink', dob: Date.new(1959, 7, 12)}
      ]

      pipe_records = [
        {last_name: 'Smith', first_name: 'Steve', initial: 'D', sex: 'Male', color: 'Red', dob: Date.new(1985, 3, 3)},
        {last_name: 'Bonk', first_name: 'Radek', initial: 'S', sex: 'Male', color: 'Green', dob: Date.new(1975, 6, 3)},
        {last_name: 'Bouillon', first_name: 'Francis', initial: 'G', sex: 'Male', color: 'Blue', dob: Date.new(1975, 6, 3)}
      ]

      space_records = [
        {last_name: 'Kournikova', first_name: 'Anna', initial: 'F', sex: 'Female', color: 'Red', dob: Date.new(1975, 6, 3)},
        {last_name: 'Hingis', first_name: 'Martina', initial: 'M', sex: 'Female', color: 'Green', dob: Date.new(1979, 4, 2)},
        {last_name: 'Seles', first_name: 'Monica', initial: 'H', sex: 'Female', color: 'Black', dob: Date.new(1973, 12, 2)}
      ]

      result = CodeTest.import_input
      expect(result).to eql(comma_records + pipe_records + space_records)
    end
  end


  context '.run' do
    it 'shows the correct output from the code test' do
      target_output = <<~OUTPUT
      Output 1:
      Hingis Martina Female 4/2/1979 Green
      Kelly Sue Female 7/12/1959 Pink
      Kournikova Anna Female 6/3/1975 Red
      Seles Monica Female 12/2/1973 Black
      Abercrombie Neil Male 2/13/1943 Tan
      Bishop Timothy Male 4/23/1967 Yellow
      Bonk Radek Male 6/3/1975 Green
      Bouillon Francis Male 6/3/1975 Blue
      Smith Steve Male 3/3/1985 Red

      Output 2:
      Abercrombie Neil Male 2/13/1943 Tan
      Kelly Sue Female 7/12/1959 Pink
      Bishop Timothy Male 4/23/1967 Yellow
      Seles Monica Female 12/2/1973 Black
      Bonk Radek Male 6/3/1975 Green
      Bouillon Francis Male 6/3/1975 Blue
      Kournikova Anna Female 6/3/1975 Red
      Hingis Martina Female 4/2/1979 Green
      Smith Steve Male 3/3/1985 Red

      Output 3:
      Smith Steve Male 3/3/1985 Red
      Seles Monica Female 12/2/1973 Black
      Kournikova Anna Female 6/3/1975 Red
      Kelly Sue Female 7/12/1959 Pink
      Hingis Martina Female 4/2/1979 Green
      Bouillon Francis Male 6/3/1975 Blue
      Bonk Radek Male 6/3/1975 Green
      Bishop Timothy Male 4/23/1967 Yellow
      Abercrombie Neil Male 2/13/1943 Tan
      OUTPUT

      expect{
        CodeTest.run
      }.to output(target_output).to_stdout
    end
  end
end


