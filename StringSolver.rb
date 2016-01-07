module StringSolver

	require './lib/GeneticAlgorithm.rb'
	require './SolutionConverter.rb'
	require 'base64'

	def self.solve(goal='',popSize=0,args={})
		if popSize==0
			popSize=100
		end
		if goal == ''
			puts "Enter Desired Goal:"
			goal = gets.chomp
		end
		if goal.is_a?(String) && goal != ''
			goal = SolutionConverter.convertToBytes(goal.upcase)
			solutionMember = evolve(GeneticAlgorithm.new(popSize,goal,args))
			puts SolutionConverter.convertToString(solutionMember.genes)
		end
	end

	def self.evolve(algorithm)
			algorithm.evolve()
	end
end

StringSolver::solve('test',0,{:elitism=>true, :mutationRate=>0.02, :data=>:word})
gets;