def caesar_cipher (string, num)
	char_array = string.split('')
	char_array = char_array.map {|letter|
		if(letter =~ /[a-z]/)
			letter = letter.ord
			while (letter + num > 'z'.ord) do
				letter = letter - 'z'.ord + 'a'.ord - 1
			end
			(letter += num).chr
		elsif (letter =~ /[A-Z]/)
			letter = letter.ord
			while (letter + num > 'Z'.ord) do
				letter = letter - 'Z'.ord + 'A'.ord - 1
			end
			(letter += num).chr
		else
			letter
		end
	}
	char_array.join
end


puts var = caesar_cipher("What a string!", 5)