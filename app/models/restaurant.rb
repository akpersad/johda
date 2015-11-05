class Restaurant < ActiveRecord::Base
	validates :name, :address, :cuisine, presence: true
	validates :name, :address, :cuisine, uniqueness: true
	has_many :orders
end
