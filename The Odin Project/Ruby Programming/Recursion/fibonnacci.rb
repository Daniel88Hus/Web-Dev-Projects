def fibs(n)
	num_one = 0
	num_two = 1
	sum = 0
	if n > 1
		1.upto(n) do |i|
			puts num_one 
			sum = num_one + num_two
			num_one = num_two
			num_two = sum
		end
	else
		puts num_one
	end
end

def fibs_rec(n)
	return 0 if n == 0
	return 1 if n == 1
	fibs_rec(n - 1) + fibs_rec(n - 2)
end

# fibs(5)
puts fibs_rec(5)