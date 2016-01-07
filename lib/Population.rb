#group of individual members
class Population

	require_relative './Member'

	attr_accessor :populace
	@@fitness = nil
	@@geneLength = nil
	@@parameters = {}
	@popSize = 0
	@populace = []
	@alphaMaleIndex = nil
	@alphaMale = nil
	#size: members in population
	#geneLength: bytes per individual
	#init: if true, fill population with random members
	#args: determines if whole byte is used or not
	# => example: all ascii letters can be found using
	# => only that last 7 bits
	def initialize(size = 0,init=false,args={},fitness=nil)

		if size > 0 && init == true && fitness != nil
			#set class vars and member data
			@popSize = size
			@@geneLength = fitness::geneLength
			@@parameters = args
			@@fitness = fitness
			Member.setGeneticData(@@geneLength,@@parameters)
			if init == true
				# if we're randomly creating population
				# we use the populate function,
				# and then set the best candidate for this generation
				@populace = populate()
				@alphaMaleIndex = getFittestIndex(@populace)
				@alphaMale = @populace[@alphaMaleIndex]
			end
		else
			if size	== 0
				size = 100
			end
				@popSize = size
				@populace	= Array.new(@popSize)
				return @populace			
		end
	end

	#number of population members
	def getSize
		return @popSize
	end

	def getFittest
		if @alphaMale != nil
			return @alphaMale	
		else
			@alphaMaleIndex = getFittestIndex(populace)
			@alphaMale =  @populace[@alphaMaleIndex]
			return @alphaMale
		end
	end

	def getMemberCount
		#unlike size, this only counts instantiated members
		i=0
		@populace.each do |x|
			if x.class != NilClass	
				i+=1
			end
		end
		return i
	end

	def addMember(member)
		#we'll only be adding to populations with room in them
		i = 0
		while i < self.getSize
			if @populace[i].class	== NilClass	
				@populace[i] = member
				break
			end
			i+=1
		end
	end

	def getRandomMember()
		return @populace.sample
	end
	
	#member of population at index MUTATES
	def mutateMember(index)
		genes = @populace[index].genes 
		mutationIndex = rand(4)
		if @@parameters[:data] == :word
			genes[mutationIndex] = '0' + Random.new().rand(65..90).to_s(2)
		else
			genes[mutationIndex] = rand.byte(1).to_s(2)
		end
		@populace[index].genes = genes
	end

	def printPopulation()
		puts 'Printing Population:'
		puts
		i=0
		bestFit =-1
		@populace.each do |x|
			if x.class != NilClass	
				print "Member: #{i+1} Fitness:"
				puts x.fitness
				if x.fitness	> bestFit	
					bestFit	= x.fitness	
				end
				i+=1
			end
		end
		puts
		puts "Total Members: #{i}"
		puts "Highest Fitness: #{bestFit}"
	end

	private 

	def getFittestIndex(populace)
		bestFitnessIndex = -1
		bestFitness = -1
		count = 0
		while count < populace.length
			if populace[count].class != NilClass
				if bestFitness < populace[count].fitness
						bestFitnessIndex = count
						bestFitness = populace[count].fitness
				end
			end
			count += 1
		end
		return bestFitnessIndex
	end

	#generate @popsize random members
  def populate
	 	pop = []
		@popSize.times do
			temp = Member.new()
			temp.fitness = @@fitness::getFitness(temp.geneString)
		 	pop.push(temp)
		end
  	return pop
	end

	#static
	def self.createMember(genes=[])
		Member.new(genes)
	end

end
