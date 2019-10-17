require 'date'

module CodeTest
  module Transfomer
    extend self

    def transform_each_value(records = [])
      return [] if records.empty?

      records.map do |record|
        new_record = {}
        record.each_pair do |key, value|
          new_record[key] = yield key, value
        end

        new_record
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
        'Male'
      when 'female'
        'Female'
      when 'm'
        'Male'
      when 'f'
        'Female'
      else
        raise InvalidSexValue
      end
    end

    class InvalidDateValue < StandardError
    end

    class InvalidSexValue < StandardError
    end
  end
end
