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

		# @page = Restaurant.order(:name).page(params[:page]).per(8)

		i = 0
		while i < @results.name.length
			Restaurant.create(
				:merchant_id => @results.merchant_id[i],
				:name => @results.name[i], 
				:address => @results.address[i], 
				:cuisine => @results.cuisine[i], 
				:phone_number => @results.phonenumber[i],
				:logo => @results.merchant_logo[i])
			i+=1
		end
		
		@page = Kaminari.paginate_array(most_recent).page(params[:page]).per(8)
		
		if @results.name == []
			flash[:success] = "<b>No results were returned. Please try again.</b>"
			redirect_to ("/")
		end
	end

end