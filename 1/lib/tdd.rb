module Bowling
	class PointsCalculator
		PINS_SUM = 10
		attr_reader :scores

		def initialize(scores)
			@scores = scores
			validate_input
		end

		def result
			strike_indexes = []
			c_scores = []

			scores.each_with_index do |frame, index|
				current_score = frame.inject(:+)

				index.downto(index-2).each do |i|
					if strike_indexes.include?(i)
						c_scores[i] += current_score
					end
				end

				c_scores[index] = current_score
				strike_indexes << index if frame[0] == 10
			end
			c_scores.inject(:+)
		end
		private

		def validate_input
			scores.each do |frame|
				raise Exception if frame.inject(:+) > PINS_SUM
			end
		end
	end
end