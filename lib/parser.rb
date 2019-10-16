module Parser
  extend self

  def parse(str, headers: nil, delimiter: ',')
    str = str.strip
    return [] if str.empty?

    result = str.split("\n").map do |line|
      line.split(delimiter)
    end

    return result if !headers.respond_to? :each

    result.map do |column|
      record = {}
      headers.each_with_index do |header, index|
        record[header] = column[index]
      end
      record
    end
  end

  def parse_from_file(path, options = {})
    contents = File.read(path)
    parse(contents, options)
  end
end
