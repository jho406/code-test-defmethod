module CodeTest
  module Sample
    extend self

    def transform_records(records = [])
      Transfomer.transform_values(records) do |k, v|
        v = v.strip

        case k
        when :sex
          Transfomer.transform_sex(v)
        when :dob
          Transfomer.transform_date(v)
        else
          v
        end
      end
    end
  end
end
