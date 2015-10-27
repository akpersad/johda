class JohdaController < ApplicationController

	def search
	end

	def main
		@rest = Getrestaurants.paginate(:page => params[:page], :per_page => 5)
		@input = params['address']
		@results = Getrestaurants.new(@input)
		if @results.name == []
			flash[:success] = "<b>No results were returned. Please try again.</b>"
			redirect_to ("/")
		end
	end
end