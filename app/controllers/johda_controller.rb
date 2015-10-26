class JohdaController < ApplicationController
	def main
		@restaurant_name = Getrestaurants.new.showoff
	end
end