def stock_picker(days = [])
	profit = 0
	choose = []
	message = "Don't do it bro!"
	days.each_with_index do |buy, i|
		days.each_with_index do |sell, j|
			if(i < j && buy - sell > profit)
				choose[0] = i
				choose[1] = j
				message = " for a profit of $#{buy - sell}"
			end
		end
	end
	print choose.to_s if !choose.empty?
	print message
end

stock_picker([20,2,3,4,25])