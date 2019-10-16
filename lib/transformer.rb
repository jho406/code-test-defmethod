require 'date'

module Transfomer
  extend self

  def transform_values(records = [])
    return [] if records.empty?

    records.map do |record|
      new_record = {}
      record.each_pair do |k, v|
        new_record[k] = yield k, v
      end

      new_record
    end
  end

  def transform_comma(records = [])
    transform_values(records) do |k, v|
      case k
        when :sex
          v.downcase.to_sym
        when :dob
          Date.strptime(v, '%m/%d/%Y')
        else
          v
      end
    end
  end

  def transform_pipe(records = [])
    transform_values(records) do |k, v|
      case k
      when :sex
        if v.downcase == 'm'
          :male
        else
          :female
        end
      when :dob
        Date.strptime(v, '%m-%d-%Y')
      else
        v
      end
    end
  end
end
