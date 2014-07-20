require 'socket'
require 'json'

# host = 'www.tutorialspoint.com'
# port = 80
# path = "/index.htm"

# request = "GET #{path} HTTP/1.0\r\n\r\n"

host = 'localhost'
port = 2000
params = Hash.new { |hash, key| hash[key] =  Hash.new}

request = ''
until request == 'GET' || request == 'POST'
	puts "Choose a request type: GET or POST"
	request = gets.chomp
end

if request == 'POST'
	puts "Enter your name"
	name = gets.chomp
	puts "Enter your email"
	email = gets.chomp
	params[:person][:name] = name
	params[:person][:email] = email
	body = params.to_json

	request = "POST /thanks.html HTTP/1.0\r\nContent-Length: #{body.length}\r\n\r\n#{body}"
else
	request = "GET /index.html HTTP/1.0\r\n\r\n"
end


socket = TCPSocket.open(host, port)
socket.print(request)
response = socket.read

headers, body = response.split("\r\n\r\n", 2)
puts ""
print body
socket.close