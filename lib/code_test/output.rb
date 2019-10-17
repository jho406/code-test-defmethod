module CodeTest
  module Output
    extend self

    def view(records=[], title='My Records:')
      body = records.map do |line|
        last_name = line[:last_name]
        first_name = line[:first_name]
        sex = line[:sex]
        dob = line[:dob].strftime('%-m/%-d/%Y')
        color = line[:color]

        "#{last_name} #{first_name} #{sex} #{dob} #{color}"
      end

      body_str = if body.empty?
                   'No records'
                 else
                   body.join("\n")
                 end

      <<~OUTPUT
      #{title}
      #{body_str}
      OUTPUT
    end

    def show_by_gender_sex_asc_then_last_name_asc(records=[])
      #Output 1 - sorted by gender (females before males) then by last name ascending
      sorted_records = records.sort_by do |record|
        [record[:sex], record[:last_name]]
      end

      view(sorted_records, 'Output 1:')
    end

    def show_by_dob_asc_then_last_name_asc(records=[])
      #Output 2 - sorted by birth date, ascending then by last name ascending
      sorted_records = records.sort_by do |record|
        [record[:dob], record[:last_name]]
      end

      view(sorted_records, 'Output 2:')
    end

    def show_by_last_name_dsc(records=[])
      #Output 3 - sorted by last name, descending
      sorted_records = records.sort do |top, bottom|
        bottom[:last_name] <=> top[:last_name]
      end

      view(sorted_records, 'Output 3:')
    end
  end
end
