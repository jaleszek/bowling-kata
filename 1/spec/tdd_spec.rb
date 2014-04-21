require 'spec_helper'

describe Bowling::PointsCalculator do
	subject{ described_class }
		 	
	context 'weakest score' do
		it 'equals 0' do
			assert_final_result([[0,0], [0,0], [0,0], [0,0]], 0)
		end
	end

	context 'without strikes' do
		it 'returns sum of specific tries' do
			assert_final_result([[0,9], [1,6]], 16)
		end
	end

	context 'invalid input' do
		context 'invalid number of pins' do
			it 'raises exception' do
				expect{ subject.new([[5,6], [8,3]]).result}.to raise_error
			end
		end
	end

	context 'with one strike' do
		it 'doubles points for second attempt' do
			assert_final_result([[10], [3,0]], 16)
			assert_final_result([[1,9], [1,8]], 19)
		end

		it 'doubles points from second and third attempt' do
			assert_final_result([[10], [3,0], [3,0]], (10 + 3 + 3) + 3 + 3)
		end
	end

	context 'with 2 continuous strikes' do
		it 'doubles points for second, third, fourth' do
			assert_final_result([[10], [10], [2,3], [1,5]], (10+10+5) + (10 + 5 + 6) + 5 + 6)
		end
	end
end

def assert_final_result(attempts, expected_score)
	expect(described_class.new(attempts).result).to eq(expected_score)
end