module Enumerable
	def my_each(with_index = false)
		self.length.times do |index|
			if with_index ? yield(self[index], index) : yield(self[index])
		end
	end

	def my_each_with_index
		my_each(true)
	end

	def my_select
		new_enum = self.class.new
		my_each {|element| new_enum << element if yield element}
		new_enum
	end

	def my_all?
		my_each{|element| return false unless yield element}
		true
	end

	def my_any?
		my_each{|element| return true if yield element}
		false
	end

	def my_none?
		my_each {|element| return false if yield element}
		true
	end

	def my_map(proc = false)
		new_enum = self
		my_each(true) do |element, index|
			new_enum[index] = proc.call(element) if proc
			new_enum[index] = yield element if block_given?
		end
		new_enum
	end

	def my_inject(total = self[0])
		my_each {|element| total = yield total, element}
		total
	end

	def multiply_els(array)
		array.my_inject(1) {|total, x| total * x}
	end
end