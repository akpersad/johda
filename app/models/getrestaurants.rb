require 'pry'
require 'json'
require 'open-uri'

class	Getrestaurants

	def initialize(address)
		@address = address
		key = "YzhkZWRhMDg4NGY0MmRiZDhkNTRhMTg2MDM4NjMwN2Fk"
		@url = "https://api.delivery.com/merchant/search/delivery?client_id=#{key}&address=#{@address}"
		@list = JSON.load(open(@url))
		displaying
	end

	def displaying
		@open_rest = Array.new
		@list["merchants"].each do |x|
			if x["ordering"]["is_open"] == true
				@open_rest << x
			end
		end
	end

	def merchant_id
		merchant_id = Array.new
		if !@open_rest.nil?
			@open_rest.each do |id|
				merchant_id << id["id"]
			end
		end
		merchant_id
	end

	def name
		@restaurants = Array.new
		if !@open_rest.nil?
			@open_rest.each do |restaurant|
				@restaurants << restaurant["summary"]["name"]
			end
		end
		@restaurants
	end

	def address
		@addresses = Array.new
		if !@open_rest.nil?
			@open_rest.each do |address|
				@addresses.push([
				address["location"]["street"].titleize, 
				address["location"]["city"].capitalize, 
				address["location"]["state"].capitalize, 
				address["location"]["zip"]].join(", "))
			end
		end
		@addresses
	end

	def latlong
		@latlong = Array.new
		if !@open_rest.nil?
			@open_rest.each do |lat|
				@latlong.push([lat["location"]["latitude"], lat["location"]["longitude"]])
			end
		end
		@latlong
	end

	def last_or_next_order_time
		@last_or_next_order_time = Array.new
		if !@open_rest.nil?
			@open_rest.each do |time|
				@last_or_next_order_time << time["ordering"]["last_or_next_order_time"]
			end
		end
		@last_or_next_order_time
	end

	def delivery_charge
		@delivery_charge = Array.new
		if !@open_rest.nil?
			@open_rest.each do |x|
				if x["ordering"]["delivery_charge"] == 0
					 @delivery_charge << x["ordering"]["delivery_percent"]
				else
					@delivery_charge << x["ordering"]["delivery_charge"]	
				end
			end
		end
		@delivery_charge
	end

	def cuisine
		@cuisines = Array.new
		if !@open_rest.nil?
			@open_rest.each do |x|
				@cuisines << (x["summary"]["cuisines"])
			end
		end
		@cuisines.compact!
	end

	def rating
		@rating = Array.new
		if !@open_rest.nil?
			@open_rest.each do |x|
				@rating << x["summary"]["star_ratings"]
			end
		end
		@rating
	end

	def phonenumber
		@phone_number = Array.new
		if !@open_rest.nil?
			@open_rest.each do |x|
				@phone_number << x["summary"]["phone"]
			end
		end
		@phone_number
	end

	def merchant_logo
		@logo = Array.new
		if !@open_rest.nil?
			@open_rest.each do |x|
				@logo << x["summary"]["merchant_logo"]
			end
		end
		@logo
	end

	def min_order
		@min_order = Array.new
		if !@open_rest.nil?
			@open_rest.each do |x|
				@min_order << x["ordering"]["minimum"]
			end
		end
		@min_order
	end
end