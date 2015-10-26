require 'pry'
require 'delivery'
class	Getrestaurants

	def initialize
		@client = Delivery::Client.new 'YzhkZWRhMDg4NGY0MmRiZDhkNTRhMTg2MDM4NjMwN2Fk'
		@list = @client.search '25 chapel st 11201'
		name
		address
		showoff
	end

	def merchant_id
		merchant_id = Array.new
		@list["merchants"].each do |id|
			merchant_id << merchant_id["id"]
		end
	end

	def name
		@restaurants = Array.new
		@list["merchants"].each do |restaurant|
			@restaurants << restaurant["summary"]["name"]
		end
		@restaurants
	end

	def address
		@addresses = Array.new
		@list["merchants"].each do |address|
			@addresses.push([
			address["location"]["street"].titleize, 
			address["location"]["city"].capitalize, 
			address["location"]["state"].capitalize, 
			address["location"]["zip"]].join(", "))
		end
		@addresses
	end

	def showoff
		hashie = {}
		@restaurants.each_with_index do |e1, i1|
			@addresses.each_with_index do |e2, i2|
				if hashie[e1].nil? && i1 == i2
					hashie[e1] = e2
				end
			end
		end
		hashie
	end

end

x = Getrestaurants.new
