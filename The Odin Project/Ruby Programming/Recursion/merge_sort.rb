def merge_sort(list)
	return list if list.size <= 1
	half = list.size / 2
	left = list[0, half]
	right = list[half, list.size]
	merge(merge_sort(left), merge_sort(right)) 
end

def merge(left, right)
	sorted = []
	until left.empty? or right.empty?
		if left.first <= right.first
			sorted << left.shift
		else
			sorted << right.shift
		end
	end
	sorted.concat(left).concat(right)
end

puts merge_sort([5,8,2,9,1])