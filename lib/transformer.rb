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
          transform_sex(v)
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
        transform_sex(v)
      when :dob
        Date.strptime(v, '%m-%d-%Y')
      else
        v
      end
    end
  end

  def transform_space(records = [])
    transform_values(records) do |k, v|
      case k
      when :sex
        transform_sex(v)
      when :dob
        Date.strptime(v, '%m-%d-%Y')
      else
        v
      end
    end
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
      raise InvalidValue
    end
  end

  class InvalidValue < StandardError
  end
end
