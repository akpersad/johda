class SortOrder

	attr_accessor :catagories, :items, :groups, :options
	attr_reader :order, :user_id

	def initialize(array,user_id=0)
		@order = array
		@catagories = Array.new
		@items = Array.new
		@groups = Array.new
		@options = Array.new
		@user_id = user_id
	end

	def split_into_class_array(string)
    	array = string.split(',')
    	if array[0] == 'catbox'
    		catagories << fix_order(array[1])
    	elsif array[0] == 'itembox'
    		items << fix_order(array[1])
    	elsif array[0] == 'groupbox'
    		groups << fix_order(array[1])
    	elsif array[0] == 'optionbox'
    		options << fix_order(array[1])
    	elsif array[0] == 'rest'
    		@rest_name = array[1]
    		@merch_id = array[2].to_i
    	end
    end

    def iterateOrder
    	length = order.length - 1
    	while length < order.length
    		order.each do |string|
    			split_into_class_array(string)
    		end
    		length +=1
    	end	
    end

    def fix_order(string)
    		string.split('[')[1].gsub(']',' ').split('EXTRA')
    end

	def saveOrder
		iterateOrder
		if user_id > 0		
			restaurant = Restaurant.find_by_merchant_id(@merch_id)
			user = User.find_by_id(user_id)
			new_order = Order.create(:name=>'test',:user_id=>user.id,:restaurant_id=>restaurant.id)
			#
			cat_array = []
			catagories.each do |array|
				if array.length > 1
					#add code just in case price is in here
				else
					new_order.order_catagories.create(catagory: Catagory.create(:title => array[0]))
				end
			end
			

			items.each do |array|
				if array.length == 1
					Item.create(:order_id=> new_order.id,:name=>array[0].rstrip)
				else
					Item.create(:order_id=> new_order.id,:name=>array[0].rstrip,:price => array[1].gsub(' ',''))
				end
			end

			groups.each do |array|
				if array.length == 1
					Group.create(:order_id=> new_order.id,:name=>array[0].rstrip)
				else
					Group.create(:order_id=> new_order.id,:name=>array[0].rstrip,:price => array[1].gsub(' ',''))
				end
			end

			options.each do |array|
				if array.length == 1
					Option.create(:order_id=> new_order.id,:name=>array[0].rstrip)
				else
					Option.create(:order_id=> new_order.id,:name=>array[0].rstrip,:price => array[1].gsub(' ',''))
				end
			end
		end
	end

	def display_order
	end


end