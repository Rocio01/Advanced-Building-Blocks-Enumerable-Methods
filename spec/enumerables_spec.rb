require_relative '../enumerables.rb'

describe Enumerable do
  base_arr = [43, 5, 78, 10, 62]
  let(:str_arr) { %w[beer joke night mic comedy] }
  let(:range) { (4..16) }

  context '#my_each' do
    it 'returns inputed array' do
      expect(base_arr.my_each.to_a).to eql(base_arr)
    end
  end

  context '#my_each_with_index' do
    it 'returns inputed array with indeces' do
      expect(base_arr.my_each_with_index.to_a).to eql(base_arr)
    end
  end

  context '#my_select' do
    it 'returns elements in array matching condition' do
      expect(range.my_select { |x| x % 4 == 0 }).to eql([4, 8, 12, 16])
    end
    it 'returns string array matching condition' do
      expect(str_arr.my_select { |x| x.length > 3 }).to eql(%w[beer joke night comedy])
    end
  end

  context '#my_all?' do
    it 'returns true if all elements match condition' do
      expect(str_arr.my_all? { |x| x.is_a? String }).to eql(true)
    end
    it 'returns false if all elements do not match condition' do
      expect(range.my_all? { |x| x > 5 }).to eql(false)
    end
    it 'returns false if all elements do not match condition' do
      expect(base_arr.my_all?(&:even?)).to eql(false)
    end
  end

  context '#my_any?' do
    it 'return true if one element match condition' do
      expect(str_arr.my_any? { |x| x == 'beer' }).to eql(true)
    end

    it 'return false if any element match condition' do
      expect(base_arr.my_any? { |x| x == 1 }).to eql(false)
    end

    it 'return false if any element match condition' do
      expect(range.my_any? { |x| x == 1 }).to eql(false)
    end
  end

  context '#my_none?' do
    it 'returns false if any elements match condition' do
      expect(str_arr.my_none? { |x| x.is_a? String }).to eql(false)
    end
    it 'returns true if any elements do not match condition' do
      expect(range.my_none? { |x| x > 20 }).to eql(true)
    end
    it 'returns false if any elements  match condition' do
      expect(base_arr.my_none?(&:even?)).to eql(false)
    end
  end

  context '#my_count' do
    it 'returns the number of items in enum through enumeration.' do
      expect(str_arr.my_count).to eql(5)
    end

    it 'If a block is given, it counts the number of elements yielding a true value.' do
      expect(range.my_count { |x| x % 4 == 0 }).to eql(4)
    end

    it 'returns the number of items in enum through enumeration.' do
      expect(base_arr.my_count(10)).to eql(1)
    end
  end

  context '#my_map' do
    it 'If a block given returns the result of the block' do
      expect(base_arr.my_map { |x| x * 2 }).to eql([86, 10, 156, 20, 124])
    end
    it 'if no block given returns enum' do
      expect(range.my_map).to be_an Enumerator
    end
  end

  context '#my_inject' do
    it 'Combines all elements of enum by applying a binary operation, specified by a symbol' do
      expect(base_arr.my_inject(:+)).to eql(198)
    end
    it 'Combines all elements of enum by applying a binary operation, specified by a block' do
      expect(range.my_inject(2) { |x, y| x + y }).to eql(132)
    end
    it 'Returns longest word in array' do
      expect(str_arr.my_inject { |x, y| x.length > y.length ? x : y }).to eql('comedy')
    end
  end

  context '#multiply_els' do
    it 'Returns multiplication of arguments passed' do
      expect(base_arr.multiply_els).to eql(10_397_400)
    end
  end
end
