class Catagory < ActiveRecord::Base
	has_many :order_catagories
	belongs_to :order
end
