class SortOrder

	attr_accessor :catagories, :items, :groups, :options
	attr_reader :order

	def initialize(array)
		@order = array
		@catagories = Array.new
		@items = Array.new
		@groups = Array.new
		@options = Array.new
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
		new_order = Order.create(:name=>'test')
		cat_array = []
		catagories.each do |array|
			if array.length > 1
			else
				cat_array << Catagory.create(:title => array[0])
			end
		end
		cat_array.each do |catagory_object|
			new_order.order_catagories.create(catagory: catagory_object)
		end
			# pass in rest name, merch id and user id
		 #order = Order.create(:name => 'lois',:uniq_id =>123)
		 # pass in catagory, should make multiple for each catagory selected

		 # catagory = Catagory.create(:title=>@order[0])
		 # builds connection order.order_catagories.create(catagory: catagory)
		 binding.pry
		
	end


end