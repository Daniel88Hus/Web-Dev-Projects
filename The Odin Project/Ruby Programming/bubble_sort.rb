def bubble_sort(array)
	sorted = false
	while !sorted do
		sorted = true
		array = array.each_with_index do |item, index|
			if index != array.length - 1 && item > array[index + 1]
				array[index], array[index + 1] = array[index + 1], item
				sorted = false
			end
		end
	end
	array
end

def bubble_sort_by (array, &block)
	sorted = false
	while !sorted do
		sorted = true
		array = array.each_with_index do |item, index|
			if index != array.length - 1 && block.call(item, array[index + 1]) < 0
				array[index], array[index + 1] = array[index + 1], item
				sorted = false
			end
		end
	end
	p array
end

#p bubble_sort([4,3,78,2,0,2])

bubble_sort_by(["hi","hiiii","hey"]) do |left,right|
	right.length - left.length
end