module Parser
  extend self

  def parse_csv(str)
    str = str.strip
    return [] if str.empty?

    [line.gsub(' ', '').split(',')]
  end
end
