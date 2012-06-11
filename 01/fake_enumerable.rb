module FakeEnumerable
  def map
    salida = []
    each { |i| salida << yield(i) }
    salida
  end
  alias :collect :map

  
  
end
