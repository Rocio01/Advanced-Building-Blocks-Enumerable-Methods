require_relative '../enumerables.rb'

describe Enumerables do
    base_arr = [43, 5, 78, 10, 62]
    let(:str_arr) { %w[beer joke night mic comedy]}
    let(:range) { (4..16) }

    describe '#my_each' do
        it 'returns inputed array' do
            expect(base_arr.my_each { |x| x}).to eql(base_arr)
        end
    end

    describe '#my_each_with_index' do
        it 'returns inputed array with indexes'
        expect(base_arr.my_each_with_index { |x, y| }).to eql(base_arr)
        end
    end

    describe '#my_select' do
        it 'returns elements in array matching condition' do
            expect(range.my_select { |x| x % 4 == 0}).to eql([4, 8, 12, 16])
        end
    end

end