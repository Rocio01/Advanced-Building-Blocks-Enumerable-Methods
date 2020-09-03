require_relative '../enumerables.rb'

describe Enumerable do
  base_arr = [43, 5, 78, 10, 62]
  let(:str_arr) { %w[beer joke night mic comedy]}
  let(:range) { (4..16) }

  context '#my_each' do
    it 'returns inputed array' do
      expect((base_arr.my_each).to_a).to eql(base_arr)
    end
  end

  context '#my_each_with_index' do
    it 'returns inputed array with indeces' do
      expect((base_arr.my_each_with_index).to_a).to eql(base_arr)
    end
  end

  context '#my_select' do
    it 'returns elements in array matching condition' do
      expect(range.my_select { |x| x % 4 == 0}).to eql([4, 8, 12, 16])
    end
    it 'returns string array matching condition' do
      expect(str_arr.my_select { |x| x.length > 3 }).to eql(%w[beer joke night comedy])
    end
  end

  context '#my_all?' do
    it 'returns true if all elements match condition' do
      expect(str_arr.my_all? { |x| x.is_a? String}).to eql(true)
    end
    it 'returns false if all elements do not match condition' do
      expect(range.my_all? { |x| x > 5 }).to eql(false)
    end
    it 'returns false if all elements do not match condition' do
      expect(base_arr.my_all? { |x| x % 2 == 0 }).to eql(false)
    end
  end

end