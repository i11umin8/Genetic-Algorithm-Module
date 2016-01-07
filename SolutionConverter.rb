class SolutionConverter
	#converts the desired string into byte array
	def self.convertToBytes(goal)
		if goal.is_a?(String) && goal != ''
			solution = []
			goal = goal.split(//).collect{|x| x.unpack("B*")}
			goal.each { |x|
				solution.push(x.to_s.chomp('"]').slice(2,8))
			}
			return solution
		end
	end

	def self.convertToString(bytes)
		solution = ''
		bytes.each do |byte|
			adder=0
			power = 7
			byte.each_char do |bit|
				adder += bit.to_i * (2**power)
				power -= 1
			end
			solution += adder.chr.downcase
		end
	  return solution
	end

end
