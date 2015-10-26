require 'delivery'
require 'pry'

class Menu 

	attr_reader :entire_menu, :catagories, :items, :groups, :options

	def initialize(restID = 63341)
		# Delivery api stuff
		data = Delivery::Client.new 'YzhkZWRhMDg4NGY0MmRiZDhkNTRhMTg2MDM4NjMwN2Fk'
		@entire_menu = data.menu(restID)
		# Menu information
		@catagories = Array.new
		@items = Array.new
		@groups = Array.new
		@options = Array.new

	end

	def build_catagories
		entire_menu['menu'].each do |menu|
			catagories << {'name' => menu['name'],
			'description' => menu['description']}
		end
	end

	def build_items_for_each_catagory
		entire_menu['menu'].each do |menu|
			items_container = Array.new
			menu['children'].each do |item|
				items_container << {'name' => item["name"],
					'description' => item["description"],
					'min_qty' => item["min_qty"],
					'max_qty' => item["max_qty"],
					'price' => item["price"]}
			end
			items << items_container
		end
	end

	def build_groups_for_each_item
		entire_menu['menu'].each do |menu|
			group_container = Array.new
			menu['children'].each do |item|
				item_group = Array.new
				if item['children'].length == 0
					# we use = so that its consistent on our call
					item_group = ["This Item Has No Group For Options"]
				else
					item['children'].each do |group|
						item_group << {'name' => group['name'],
							'min_selection' => group['min_selection'],
							'max_selection' => group['max_selection']}
					end
				end
				group_container << item_group
			end
			groups << group_container
		end
	end

	def build_options_for_each_group
		entire_menu['menu'].each do |menu|
			option_container = Array.new
			menu['children'].each do |item|
				item_group = Array.new
				item['children'].each do |group|
					group_options = Array.new
					if group['children'].length == 0
						group_options << ["This Item Has No Group For Options"]
					else
						group['children'].each do |option|
							group_options << {'name' => option["name"],
							"description" => option["description"],
							"max_price" => option["max_price"]}
						end
					end
					item_group << group_options
				end
				option_container << item_group
			end
			options << option_container
		end
		
	end

	def runner
		#catagories[0] returns first title in submenu

		#items[0] refers to first title in submenu and returns array of all its items
		#items[0][0] is the first individual item in that submenu

		#groups[0] refers to the title in the submenu
		#groups[0][0] refers to the item in the submenu 
		#groups[0][0][0] refers to that items group could be group options or price options
		#groups[0][0][0].class will return either hash or string

		#options[0] the 0 refers to first title in submenu and returns array of all its items
		#options[0][0] the second 0 refers to each item in a submenu
		#options[0][0][0] the third 0 refers to the group 
		#options[0][0][0][0] the last 0 refers to the option in that group
		build_catagories
		build_items_for_each_catagory
		build_groups_for_each_item
		build_options_for_each_group
	end





	

end



