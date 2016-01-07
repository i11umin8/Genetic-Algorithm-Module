#individual in a population
class Member

	attr_accessor :fitness, :geneString, :genes
	#class variables set by population handler
	@@geneLength = nil
	@@parameters = []
	#the genes
	@genes = []
	@geneString = nil
	@fitness = 0

	def initialize(genes = [])
		if !genes.empty?
			@genes = genes
			@geneString = @genes.join
		else
			@genes = self.class.generateRandomGenes()
			@geneString = @genes.join()
		end
	end

	#instance method(s):

	# apparently I don't need any for members

	#static methods

	#set gene Length and parameters.
	def self.setGeneticData(geneLength,parameters)
		@@geneLength = geneLength
		@@parameters = parameters
	end

	def self.getGeneticData()
		return {:geneLength => @@geneLength , :parameters => @@parameters}
	end

	def self.generateRandomGenes()
		genes = Array.new 
		#if we're looking for words...
		if @@parameters[:data] == :word
			#we know our data is limited to letters...
			#so, we can save precious bits generating random ascii
			#letters and converting them to byte strings
			@@geneLength.times do
				# for testing:
				# temp = Random.new.rand(65..90)
				# str += temp.chr()
				# gene = '0'+ temp.to_s(2)
				gene = '0' + Random.new.rand(65..90).to_s(2)
				genes.push(gene)
			end
			return genes
		else
			rand = Random.new()
			@@geneLength.times do
				genes.push(rand.byte(1).to_s(2))
			end
		end
	end

end