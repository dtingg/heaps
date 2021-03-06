class HeapNode
  attr_reader :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end

class MinHeap
  def initialize
    @store = []
  end

  # This method adds a HeapNode instance to the heap
  # Time Complexity: O(log n)
  # Space Complexity: O(1)
  def add(key, value = key)
    newNode = HeapNode.new(key, value)
    @store << newNode

    length = @store.length
    heap_up(length - 1)
  end

  # This method removes and returns an element from the heap
  #   maintaining the heap structure
  # Time Complexity: O(log n)
  # Space Complexity: O(1)
  def remove()
    if @store.empty?
      return nil
    end

    length = @store.length
    swap(0, length - 1)

    removed_node = @store.pop
    heap_down(0)
    
    return removed_node.value
  end

  # Used for Testing
  def to_s
    return "[]" if @store.empty?

    output = "["
    (@store.length - 1).times do |index|
      output += @store[index].value + ", "
    end

    output += @store.last.value + "]"
      
    return output
  end

  # This method returns true if the heap is empty
  # Time complexity: O(1)
  # Space complexity: O(1)
  def empty?
    return @store.empty?
  end

  private

  # This helper method takes an index and
  #  moves it up the heap, if it is less than it's parent node.
  #  It could be **very** helpful for the add method.
  # Time complexity: O(log n)
  # Space complexity: O(1)
  def heap_up(index)
    parent_index = (index - 1 ) / 2

    if @store[parent_index].key > @store[index].key
      swap(parent_index, index)

      while parent_index > 0 
        return heap_up(parent_index)
      end
    end
  end

  # This helper method takes an index and 
  #  moves it up the heap if it's smaller
  #  than it's parent node.
  # Time complexity: O(log n)
  # Space complexity: O(1)
  def heap_down(index)
    left_child_index = (index * 2) + 1
    right_child_index = (index * 2) + 2

    return if @store[left_child_index].nil? && @store[right_child_index].nil?

    if @store[left_child_index].nil?
      smallest_child_index = right_child_index
    elsif @store[right_child_index].nil?
      smallest_child_index = left_child_index
    elsif @store[left_child_index].key < @store[right_child_index].key
      smallest_child_index = left_child_index
    else
      smallest_child_index = right_child_index
    end
      
    if @store[index].key > @store[smallest_child_index].key
      swap(index, smallest_child_index)
    else
      return
    end

    return heap_down(smallest_child_index)  
  end

  # If you want a swap method... you're welcome
  def swap(index_1, index_2)
    temp = @store[index_1]
    @store[index_1] = @store[index_2]
    @store[index_2] = temp
  end
end
