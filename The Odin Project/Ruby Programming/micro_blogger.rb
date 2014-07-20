require 'jumpstart_auth'
require 'bitly'
require 'klout'

class MicroBlogger
	attr_reader :client

	def initialize
		puts "Initializing"
		Bitly.use_api_version_3
		Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h'

		@bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
		@client = JumpstartAuth.twitter
	end

	def tweet(message)
		if message.length <= 140
			@client.update(message)
		else
			puts "Tweet too long!"
		end
	end

	def dm(target, message)
		puts "Trying to send #{target} this direct message:"
		puts message
		screen_names = @client.followers.collect { |follower| follower.screen_name }
		if screen_names.include? target
			tweet("d #{target} #{message}")
		else
			puts "#{target} is not following you!"
		end
	end

	def followers_list
		@client.followers.collect { |follower| follower.screen_name }
	end

	def spam_my_followers(message)
		followers_list.each { |follower| dm(follower, message) }
	end

	def everyones_last_tweet
		friends = @client.friends
		friends.sort_by {|friend| friend.screen_name.downcase }
		friends.each do |friend|
			print "#{friend.screen_name}: #{friend.status.text}, #{(friend.status.created_at).strftime("%A, %b %d")}"
			puts ""
		end
	end

	def shorten(original_url)
		puts "Shortening this URL: #{original_url}"
		@bitly.shorten("#{original_url}").short_url
	end

	def klout_score
        puts "Klout Scores"
        friends = @client.friends.collect{|friend| friend.screen_name}
        friends.each do |friend|
            printf "#{friend}: "
            i = Klout::Identity.find_by_screen_name(friend)
            user = Klout::User.new(i.id)
            puts "#{user.score.score}"
        end
    end

	def run
		puts "Welcome to the JSL Twitter Client!"

		command = ""
		while command != "q"
			printf "enter command: "
			input = gets.chomp
			parts = input.split(" ")
			command = parts[0]
			case command
				when 'q' then puts "Goodbye!"
				when 't' then tweet(parts[1..-1].join(" "))
				when 'dm' then dm(parts[1], parts[2..-1].join(" "))
				when 'spam' then spam_my_followers(parts[1..-1].join(" "))
				when 'elt' then everyones_last_tweet
				when 's' then shorten(parts[1..-1].join(" "))
				when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
				when "k" then self.klout_score
				else
					puts "Sorry, I don't know how to #{command}"
			end
		end
	end
end

blogger = MicroBlogger.new
blogger.run