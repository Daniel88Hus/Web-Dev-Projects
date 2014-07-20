require 'socket'
require 'json'

server = TCPServer.open(2000)



loop {
	Thread.start(server.accept) do |client|
		request = client.gets

		request_header, request_body = request.split("\r\n\r\n", 2)
		trimmedrequest = request.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, '')
   		filename = trimmedrequest.chomp
		method = request_header.split[0]

		if File.exist? path
			response_body = File.read(path)
			client.puts "HTTP/1.1 200 OK\r\nContent-Type:text/html\r\n\r\n"
			if method == 'GET'
				client.puts(response_body)
			elsif method == 'POST'
				params = JSON.parse(request_body)
				data = "<li>name: #{params['person']['name']}</li><li>email: #{params['person']['email']}</li>"
				client.puts response_body.gsub('<%= yield %>', data)
			end
		else
			client.puts "HTTP/1.1 404 Not Found \r\n\r\n"
			client.puts "404 Error, File not found"
		end
		client.close
	end

	# client = server.accept
	# client.puts(Time.now.ctime)
	# client.puts "Closing the connection. Bye!"
	# client.close			
}