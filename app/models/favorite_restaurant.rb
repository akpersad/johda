class FavoriteRestaurant < ActiveRecord::Base
	# validates :restaurant, uniqueness: true
	validates_uniqueness_of :user_id, :scope => [:restaurant_id]
	belongs_to :user
	belongs_to :restaurant
end
