class Node
	attr_accessor :child, :parent
	attr_reader :value

	def initialize(value)
		@value = value
	end
end

def build_tree(array)
	array.each do |value|
		add_node(value)
	end
end

def add_node(value)
	
					
					
					

					
					
					