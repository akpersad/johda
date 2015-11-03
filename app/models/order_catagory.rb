class OrderCatagory < ActiveRecord::Base
	belongs_to :order
	belongs_to :catagory
end
