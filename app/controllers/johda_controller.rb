class JohdaController < ApplicationController

	def search
	end

	def main
		if !params['address'].nil?
			session['last_search'] = params['address']
		end
		@input = session['last_search']
		@results = Getrestaurants.new(@input)

		def most_recent
			array=[]
			@results.name.each do |name|
				if Restaurant.find_by_name(name)
					x = Restaurant.find_by_name(name)
					array << x
				end
			end
			array
		end

		@cuisine = []

		@results.cuisine.each do |c|
			c.each do |e|
				@cuisine << e
			end
		end
		@cuisine.uniq!
		@cuisine = @cuisine.sort

		# @page = Restaurant.order(:name).page(params[:page]).per(8)

		i = 0
		while i < @results.name.length
			Restaurant.create(
				:merchant_id => @results.merchant_id[i],
				:name => @results.name[i], 
				:address => @results.address[i], 
				:cuisine => @results.cuisine[i], 
				:phone_number => @results.phonenumber[i],
				:logo => @results.merchant_logo[i],
				:rating => @results.rating[i],
				:rating_img => @results.rating_img[i],
				:price_rating => @results.price_rating[i],
				:time_needed => @results.time_needed[i],
				:delivery_charge => @results.delivery_charge[i],
				:min_order => @results.min_order[i]
				)
			i+=1
		end
		
		@page = Kaminari.paginate_array(most_recent).page(params[:page]).per(8)

		session["results"] = @results
		session["cuisine"] = @cuisine
		session["page"] = @page

		if @results.name == []
			flash[:danger] = "No results were returned. Please try again."
			redirect_to ("/")
		end
	end

	def filter
		@index = []
		test = []
	

		 params.keys.collect do |k|
		 	k.split(" ")
		 end.each do |a|
		 	if a.length == 2
		 		test<<params[a.join(' ')]
		 	end
		 end

		session["results"].cuisine.each_with_index do |e,num|
			test.each do |i|
				if e.include?(i)
					@index << num
				end
			end
		end

		def most_recent
			array=[]
			session["results"].name.each_with_index do |name, i|
				@index.each do |e|
					if Restaurant.find_by_name(name) && e == i
						x = Restaurant.find_by_name(name)
						array << x
					end
				end
			end
			array
		end

		@page = Kaminari.paginate_array(most_recent).page(params[:page]).per(8)
	end
end