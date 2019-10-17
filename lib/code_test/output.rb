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
  end
end
