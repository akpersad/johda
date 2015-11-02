require 'pry'
require 'json'
require 'open-uri'
require 'delivery'

class	Getrestaurants

	def initialize(address)
		@address = address
		key = ENV["DELIVERY_KEY"]
		# @url = "https://api.delivery.com/merchant/search/delivery?client_id=#{key}&address=#{@address}"
		# @list = JSON.load(open(@url))
		@client = Delivery::Client.new "#{key}"
		@list = @client.search "#{@address}"
		displaying
		rating
		rating_img
	end

	def search_address
		a = @list["search_address"]
		@address = "#{a["street"]}., #{a["city"]}, #{a["state"]}, #{a["zip_code"]}"
	end

	def displaying
		@open_rest = Array.new
		if !@list["merchants"].nil?
			@list["merchants"].each do |x|
				if x["ordering"]["is_open"] == true && !x["summary"]["cuisines"].nil?
					@open_rest << x
				end
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
				address["location"]["city"].titleize, 
				address["location"]["state"].upcase, 
				address["location"]["zip"]].join(", "))
			end
		end
		@addresses
	end

	# def latlong
	# 	@latlong = Array.new
	# 	if !@open_rest.nil?
	# 		@open_rest.each do |lat|
	# 			@latlong.push([lat["location"]["latitude"], lat["location"]["longitude"]])
	# 		end
	# 	end
	# 	@latlong
	# end

	# def last_or_next_order_time
	# 	@last_or_next_order_time = Array.new
	# 	if !@open_rest.nil?
	# 		@open_rest.each do |time|
	# 			@last_or_next_order_time << time["ordering"]["last_or_next_order_time"]
	# 		end
	# 	end
	# 	@last_or_next_order_time
	# end

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
		@cuisines
	end

	def rating
		@rating = Array.new
		if !@open_rest.nil?
			@open_rest.each do |x|
				@rating << x["summary"]["star_ratings"]
			end
		end
		@rating.map! {|x|x || 0}
	end

	def rating_img
		@rating_img = Array.new
		@rating.each do |rate|
			if rate >= 5
				@rating_img << "http://i.imgur.com/kfZfAqz.png"
			elsif rate == 4.5
				@rating_img << "http://i.imgur.com/IWYguVS.png"
			elsif rate == 4
				@rating_img << "http://i.imgur.com/1DWwykk.png"	
			elsif rate == 3.5
				@rating_img << "http://i.imgur.com/UZysvEt.png"
			elsif rate == 3
				@rating_img << "http://i.imgur.com/BRmZNj5.png"
			elsif rate == 2.5
				@rating_img << "http://i.imgur.com/oYBhO4V.png"
			elsif rate == 2
				@rating_img << "http://i.imgur.com/J8X1vzk.png"
			elsif rate == 1.5
				@rating_img << "http://i.imgur.com/H6MZGkJ.png"
			elsif rate == 1
				@rating_img << "http://i.imgur.com/4mr0qBY.png"
			else
				@rating_img << "http://www.coutellerie-tourangelle.com/images/imagecache/fiche_article/1817643Product_Primary_Image_1297700022.jpg"
			end
		end
		@rating_img
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

	def price_rating
		@price_rating = Array.new
		if !@open_rest.nil?
			@open_rest.each do |x|
				@price_rating << x["summary"]["price_rating"]
			end
		end
		@price_rating.map! {|x|x || 0}
		# a = @price_rating.apartition{|x| x.is_a? String}.map(&:sort).flatten.reverse!
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