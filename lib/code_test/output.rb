module CodeTest
  module Output
    extend self

    def view(records=[], title='My Records:')
      <<~OUTPUT
      #{title}
      No records
      OUTPUT
    end
  end
end
