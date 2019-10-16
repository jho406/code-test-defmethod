module Parser
  extend self

  def parse_csv(str)
    str = str.strip
    return [] if str.empty?

    str.split("\n").map do |line|
      line_no_space = line.gsub(' ', '')
      line_no_space.split(',')
    end
  end
end
