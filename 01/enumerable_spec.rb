require 'turn'
# Test formatting config
Turn.config do |c|
 #c.format  = :outline # outline, progress, dotted, pretty, marshall, cue
 #c.trace   = true
 #c.natural = true
end
# En of test formatting config
require "minitest/autorun"
require_relative "./fake_enumerable"

class EnumerateMe
  include FakeEnumerable
  #include Enumerable

  def initialize
    @data = []
  end

  def <<(obj)
    @data << obj
  end

  def each
    @data.each { |obj| yield obj }
  end

  def data
    @data.clone
  end


end

describe EnumerateMe do
  before do
    @it = EnumerateMe.new
  end

  describe "#all?" do
    before do
      @it << 3 << 6 << 9
    end
    
    it "returns true if there's not nil or false" do
      @it.all?.must_equal(true)
    end

    it "returns false if there is a false value" do
      @it << false
      @it.all?.must_equal(false)
    end

    it "returns false if there is a false value" do
      @it << nil
      @it.all?.must_equal(false)
    end

    it "returns true if all the items meet the condition" do
      @it.all? { |i| (i%3)==0 }.must_equal(true)
    end

    it "returns false if one of the items doesn't meet the condition" do
      @it.all? { |i| (i%2)==1 }.must_equal(false)
    end
  end

  # describe "#any?" do
  #   it "returns false if there's not any non false value'" do
  #     @it << false << nil
  #     @it.any?.must_equal(false)
  #   end
  #  
  #   it "returns true if there's at least one non false value'" do
  #     @it << :non_false
  #     @it.any?.must_equal(true)
  #   end
  # end
  #  
  # describe "#chunk" do
  #   it "chunks the items" do
  #     @it << 1 << 3 << 5 << 2 << 4 << 6 << 8 << 7 << 5 << 6
  #     @it.chunk { |i| i%2==0 }.
  #       map { |a| a }.
  #       must_equal(
  #                  [[false, [1, 3, 5]],
  #                   [true, [2, 4, 6, 8]],
  #                   [false, [7, 5]],
  #                   [true, [6]]]
  #                  )
  #   end
  # end
  #  
  describe "#collect and #map" do
    before do
      @it << 1 << 2 << 3
    end
    
    it "returns an array with the elements" do
      @it.map { |i| i }.must_equal([1,2,3])
    end
   
    it "returns an array with the elements multiplies by 2" do
      @it.map { |i| i*2 }.must_equal([2,4,6])
    end
   
    it "returns an array" do
      @it.collect { |i| i }.must_equal([1,2,3])
    end
   
    it "returns an array with the elements multiplies by 2" do
      @it.collect { |i| i*2 }.must_equal([2,4,6])
    end
  end
  #  
  # describe "#collect_concat and flat_map" do
  #   it "returns a flattened array using collect_concat" do
  #     @it << 1 << [2,3] << 4
  #     @it.collect_concat { |o| o }.must_equal([1,2,3,4])
  #   end
  #  
  #   it "returns a flattened array using flat_map" do
  #     @it << 1 << [2,3] << 4
  #     @it.flat_map { |o| o }.must_equal([1,2,3,4])
  #   end
  #  
  #   it "returns a flattened array of each entry multiplied by 2 using collect_concat" do
  #     @it << 1 << [2,3] << 4
  #     @it.collect_concat { |o| o*2 }.must_equal([2, 2, 3, 2, 3, 8])
  #   end
  #  
  #   it "returns a flattened array of each entry multiplied by 2 using flat_map" do
  #     @it << 1 << [2,3] << 4
  #     @it.flat_map { |o| o*2 }.must_equal([2, 2, 3, 2, 3, 8])
  #   end
  # end
  #  
  # describe "#count" do
  #   before do
  #     @it << 1 << 2 << 4 << 2
  #   end
  #  
  #   it "counts all the items" do
  #     @it.count.must_equal(4)
  #   end
  #  
  #   it "counts all the items that equals the parameter" do
  #     @it.count(2).must_equal(2)
  #   end
  #  
  #   it "counts all items that match a criteria" do
  #     @it.count { |i| i%2==0 }.must_equal(3)
  #   end
  # end
  #  
  # describe "#cycle" do
  #   before do
  #     @it << 1 << 2 << 3
  #   end
  #  
  #   # it "cycles to infinity" do
  #   #   @it.cycle { |x| x }
  #   #   #usar un mock!!!!!!!!!!!!!!!!!!!!!!!!
  #   # end
  #  
  # end
  #  
  # describe "#detect and #find" do
  #   before do
  #     @it << [1,1] << [2,1] << [3,1] << [4,1] << [5,1] << [2,2]
  #   end
  #   
  #   it "finds the first occurrence with detect" do
  #     result = @it.detect { |i| i[0]==2 }
  #     result.must_equal([2,1])
  #   end
  #  
  #   it "finds the first occurrence with find" do
  #     result = @it.find { |i| i[0]==2 }
  #     result.must_equal([2,1])
  #   end
  #  
  #   it "returns nil if it doesn't find the item with detect" do
  #     @it.detect { |i| i[0]==8 }.must_be_nil
  #   end
  #  
  #   it "returns nil if it doesn't find the item with find" do
  #     @it.find { |i| i[0]==8 }.must_be_nil
  #   end
  #  
  #   it "returns :not_there if it doesn't find the item with detect" do
  #     @it.detect(->{:not_there}) { |i| i[0]==8 }.must_equal(:not_there)
  #   end
  #  
  #   it "returns :not_there if it doesn't find the item with find" do
  #     @it.find(->{:not_there}) { |i| i[0]==8 }.must_equal(:not_there)
  #   end
  # end
  #  
  # describe "#find_all and #select" do
  #   before do
  #     @it << 1 << 2 << 3 << 4 << 5 << 6 << 7 << 8 << 9 << 10 << 11 << 12
  #   end
  #  
  #   it "returns an array whith the even numbers with find_all" do
  #     @it.find_all { |i| i%2==0 }.must_equal([2, 4, 6, 8, 10, 12])
  #   end
  #  
  #   it "returns an array whith the even numbers with select" do
  #     @it.select { |i| i%2==0 }.must_equal([2, 4, 6, 8, 10, 12])
  #   end
  #  
  #   it "returns an empty array if it doesn't find anithing whith find_all" do
  #     @it.find_all { |i| i%2==3 }.must_equal([])
  #   end
  #  
  #   it "returns an empty array if it doesn't find anithing whith select" do
  #     @it.select { |i| i%2==3 }.must_equal([])
  #   end
  #  
  #  
  # end



  
end
