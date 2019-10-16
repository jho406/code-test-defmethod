module Parser
  extend self

  def parse(str, headers = nil, delimiter = ',')
    str = str.strip
    return [] if str.empty?

    result = str.split("\n").map do |line|
      line_no_space = line.gsub(' ', '')
      line_no_space.split(delimiter)
    end

    return result if headers.nil?

    result.map do |column|
      record = {}
      headers.each_with_index do |header, index|
        record[header] = column[index]
      end
      record
    end
  end
end
