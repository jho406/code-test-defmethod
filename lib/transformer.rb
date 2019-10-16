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

  def transform_records(records = [])
    transform_values(records) do |k, v|
      v = v.strip

      case k
      when :sex
        transform_sex(v)
      when :dob
        transform_date(v)
      else
        v
      end
    end
  end

  def transform_date(value)
    # From requirements:
    # Dates are represented in American format (month, day, year).
    # So we are guarnteed that order of m d y
    value = value.gsub(/\D/, '-')
    Date.strptime(value, '%m-%d-%Y')
  rescue ArgumentError
    raise InvalidDateValue
  end

  def transform_sex(value)
    value = value.downcase
    case value
    when 'male'
      :male
    when 'female'
      :female
    when 'm'
      :male
    when 'f'
      :female
    else
      raise InvalidSexValue
    end
  end

  class InvalidDateValue < StandardError
  end

  class InvalidSexValue < StandardError
  end
end
