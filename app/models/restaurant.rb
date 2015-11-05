class Restaurant < ActiveRecord::Base
	validates :name, :address, :cuisine, presence: true
	validates :name, :address, :cuisine, uniqueness: true
	has_many :orders
	has_many :favorite_restaurants
	belongs_to :user
end
