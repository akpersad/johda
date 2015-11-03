class Order < ActiveRecord::Base
	has_many :order_catagories
	
	has_many :catagories, through: :order_catagories
	belongs_to :user
end
