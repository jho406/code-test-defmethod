require 'date'

module Transfomer
  extend self

  def transform_comma(records = [])
    return [] if records.empty?

    records.map do |record|
      new_record = {}
      record.each_pair do |k, v|
        if k == :sex
          v = v.downcase.to_sym
        end

        if k == :dob
          v = Date.strptime(v, '%m/%d/%Y')
        end

        new_record[k] = v
      end

      new_record
    end
  end

  def transform_pipe(records = [])
    return [] if records.empty?

    records.map do |record|
      new_record = {}
      record.each_pair do |k, v|
        if k == :sex
          v = v.downcase.to_sym
        end

        if k == :dob
          v = Date.strptime(v, '%m-%d-%Y')
        end

        new_record[k] = v
      end

      new_record
    end
  end
end
