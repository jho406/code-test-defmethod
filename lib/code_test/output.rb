module CodeTest
  module Output
    extend self

    def view(records=[], title='My Records:')
      <<~OUTPUT
      #{title}
      OUTPUT
    end
  end
end
