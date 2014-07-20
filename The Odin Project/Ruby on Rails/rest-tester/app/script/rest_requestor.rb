require 'rest-client'

while true do
	puts "Enter path request"
	test = gets.chomp
	if test == "end"
		break
	else
		url = "http://localhost:3000/#{test}"
		puts RestClient.post(url, "")
	end
end

