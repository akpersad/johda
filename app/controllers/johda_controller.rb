class JohdaController < ApplicationController

	def search
	end

	def main
		@input = params['address']
		@results = Getrestaurants.new(@input)
		# @results.page(1).per(10).padding(3)
		if @results.name == []
			flash[:success] = "<b>No results were returned. Please try again.</b>"
			redirect_to ("/")
		end
	end
end