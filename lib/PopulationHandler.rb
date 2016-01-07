#class that implements,creates and evolves populations
require_relative 'Fitness'
class PopulationHandler
	
	require_relative './Population'
	extend Fitness

	@@elitism = nil
	@@mutationRate = nil
	@mutationNum = 0
	#number of mutations in generation
	@population = []
	# constructor
	# popSize: members in population
	# solution: array of bytes representing solution
	#arg: additional parameters, such as string, word, ect. 
	# => This is useful, because depending on what type of data we're searching for, we can narrow down the gene length
	def initialize(popSize=0,solution,args)	
		#set desired 
		@@elitism = args[:elitism]
		@@mutationRate = args[:mutationRate]
		Fitness::setSolution(solution)
		@mutationNum	= 0
		@population = Population.new(popSize,true,{:data =>args[:data]},Fitness)
	end

	def evolvePopulation
		@population = evolve(@population)
	end

	def getFittest
		return @population.getFittest
	end

	def getMaximumFitness
		return Fitness::maxFitness
	end

  def getNumberOfMutations
  	return @mutationNum
  end

	private 

	def evolve(population)
		#puts 'PopulationHandler: Start Evolution'

		maxFitness = Fitness::maxFitness
		newPop = Population.new(population.getSize,false)
		#algorithm:
		if @@elitism
			# class warfare all up in here
			# => we can:
			# => Force everyone except the fittest x% to compete, assuring their dominance
			# => (Hunger Games strategy)
			# => Wow, I'm getting bummed out just thinking of it.
			# => Hopefully mutation can level the playing field for the little guy
			eliteOffset = 0
			alpha = population.getFittest	
			newPop.addMember(alpha)
			eliteOffset	+= 1		
			currentCount = newPop.getMemberCount

			while currentCount < newPop.getSize()
			  x = compete(population)
			  y = compete(population)
			  z = breed(x,y)
				newPop.addMember(z)
				currentCount+=1
			end
			mutationNum =0
			while eliteOffset	< newPop.getSize()
				if rand() <= @@mutationRate
					newPop.mutateMember(eliteOffset)
					mutationNum += 1
				end
				eliteOffset	+=1
			end
			@mutationNum = mutationNum
			return newPop	
		else
			#implement later
		end
	end

	#crossover
	#heh, genetics joke below
	def breed(xx,xy)
		#x,y are parent genes
		x = xx.genes
		y = xy.genes
		geneLength = Fitness::geneLength	
		#offspring
		z = Array.new(geneLength)
		# bit returns true or false randomly when sampled
		bit = [true,false]
		count = 0
		while count < geneLength
			if bit.sample
				z[count] = x[count]
			else
				z[count] = y[count]
			end
			count+=1
		end	
		offspring = Population::createMember(z)
		offspring.fitness	=Fitness::getFitness(z.join())
		return offspring	
	end

	def mutate

	end
	#fight for fitness and glory. Winners get to breed
	def compete(population,size=5)
		#fight to the death
		competition = Population.new(size,false)
		size.times do 
			competition.addMember(population.getRandomMember())
		end
		return competition.getFittest
	end

end
