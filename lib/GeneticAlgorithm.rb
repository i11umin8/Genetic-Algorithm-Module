class GeneticAlgorithm
	
	require_relative "./PopulationHandler"

	@PopulationHandler = nil
	#create an instance of the algorithm
	#popSize: members in starting population.
	#solution: byte array representing soution
	#args: additional 
	def initialize(popSize=0,solution=[],args= {})
		if popSize==0
			popSize=100
		end
		if !solution.empty? && solution.is_a?(Array)
			@PopulationHandler = PopulationHandler.new(popSize,solution,args)
			puts "Population Handler created"
			puts "Population Size: #{popSize}"
			puts  
		end
	end

	def evolve()
		if @PopulationHandler	!= nil
			puts "Start Evolution Now"
			max = @PopulationHandler.getMaximumFitness	
			puts "Max fitness: #{max}"
			puts 
			generation = 0
			while @PopulationHandler.getFittest.fitness < max
					generation+=1	
				  puts "Generation #{generation}:"
				  puts 
				  @PopulationHandler.evolvePopulation()
				  fittest = @PopulationHandler.getFittest
					puts "Highest fitness: #{fittest.fitness}"
					puts "Number of Mutations: #{@PopulationHandler.getNumberOfMutations}"
					puts
					if fittest.fitness == max 
						puts 'Solution Found:'
						return fittest
						break
					end
			end
		end
	end

end