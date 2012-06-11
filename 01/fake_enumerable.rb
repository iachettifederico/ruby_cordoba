module FakeEnumerable
  def map
    out = []
    each { |i| out << yield(i) }
    out
  end
  alias :collect :map

  def all?
    
    each { |o| return false unless o }
    true
  end

  
  
end
