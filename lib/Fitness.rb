# Module modeling Fitness
# Fitness is the ability for a member
# of a population to "survive;"
# => in this context, fitness determines how close to
# => a solution one of the members is

module Fitness

	@solutionGene = nil
	@solutionString = nil
	@maxFitness = nil
	@geneLength =nil

	#set desired solution, as both bytes and binary string (it'll save some calculations later)
	#as instance variables. Since fitness is a product of solution, this sets maxFitness also
	#all 'genes' will be converted back to solution string for fitness comparison
	def self.setSolution(solution=[])
		if !solution.empty?
			@solutionGene = solution
			@solutionString = @solutionGene.join
			@maxFitness = @solutionString.length
			@geneLength = @maxFitness/8
		end
	end

	def self.solutionGene
		return @solutionGene
	end

	def self.solutionString
		return @solutionString
	end

	#maximum fitness possible for solution.
	def self.maxFitness
		return @maxFitness
	end	

	def self.geneLength
		return @geneLength
	end	

	def self.getFitness(geneticString='')
		#only give fitness if solution string is given and if it's the same length as solution
		if !geneticString.empty? && geneticString.length == @solutionString.length
			solutionArray = @solutionString.split(//)
			candidateArray = geneticString.split(//)
			fitnessCount = 0
			i = 0
			while i < solutionArray.length do	
				if solutionArray[i] == candidateArray[i]
					fitnessCount+=1
				end
				i+=1
			end
			return fitnessCount
		else 
			return 0
		end	
	end

end