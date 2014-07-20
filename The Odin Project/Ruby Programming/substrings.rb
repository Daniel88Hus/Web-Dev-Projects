dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(word, dictionary)
	word.downcase!
	results = {}
	dictionary.each {|word| 
		count = word.scan(/#{word}/).count
		results[word] = count if count > 0
	}
	return results
end

puts substrings("Howdy partner, sit down, how's it going?", dictionary)