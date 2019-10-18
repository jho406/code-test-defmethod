module CodeTest
  module Input
    extend self

    def parse(str, headers, delimiter = ',')
      str = str.strip
      return [] if str.empty?

      result = str.split("\n").map do |line|
        line.split(delimiter)
      end

      result.map do |column|
        record = {}
        headers.each_with_index do |header, index|
          record[header] = column[index]
        end
        record
      end
    end

    def parse_from_file(path, headers, delimiter = ',')
      contents = File.read(path)
      parse(contents, headers, delimiter)
    end
  end
end
