module FakeEnumerable
  def map
    out = []
    each { |i| out << yield(i) }
    out
  end
  alias :collect :map

  
  
end
