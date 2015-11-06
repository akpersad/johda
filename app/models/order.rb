class Order < ActiveRecord::Base
	has_many :order_catagories
	has_many :catagories, through: :order_catagories
	has_many :items
	has_many :groups
	has_many :options
	belongs_to :user
	belongs_to :restaurant
	
end
