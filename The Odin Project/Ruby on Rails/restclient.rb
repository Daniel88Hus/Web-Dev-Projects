require 'rest_client'

response = RestClient.get 'https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=test%20search'
puts response.code
puts response.cookies
puts response.headers
# puts response.to_str