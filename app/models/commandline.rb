require 'delivery'
# goal
# make this model get json data
# make methods that makes these groups from Json
# Menu *entire menu
	# Menu *submenus 
		# Item *uniq inside submeuns
		# 	Option groups *groups options 
		# 		Options 
		# 		Options ect..
class Menu
	attr_reader :data, :subMenus, :items, :optionsGroup, :options
	def initialize
		@data = Delivery::Client.new 'YzhkZWRhMDg4NGY0MmRiZDhkNTRhMTg2MDM4NjMwN2Fk'
		@subMenus = Array.new
		@items = Array.new
		@optionsGroup = Array.new
		@options = Array.new
	end
	#63183
	def start
		info ||= data.menu(63183) 
		# top level keys ["schedule", "warnings", "menu"]
	end
	def mainMenu
		menu ||= start['menu']
	end
	def buildSubMenu
		mainMenu.each do |hashes|
			subMenus << {'name' => hashes['name'],
			'description' => hashes['description']}
		end
	subMenus
	end
	def buildItems
		temp = Array.new
		mainMenu
		mainMenu.each do |x|
			temp = []
			x['children'].each do |hashes|
				
				temp << {'name' => hashes["name"],
					'description' => hashes["description"],
					'min_qty' => hashes["min_qty"],
					'max_qty' => hashes["max_qty"],
					'price' => hashes["price"]}
			end
			items << temp
		end	
		# is array with arrays inside with hashes inside
		# each hash matches with the submenu hash of same element
		items
	end
	def buildOptionsGroup
		mainMenu
		mainMenu.each do |x|
			diffitem = []
			x['children'].each do |hashes|
				temp = []
				
					if hashes['children'].length == 0
						temp = ['no option group for this item']
					else
						hashes['children'].each do |hash|
							#inside group option hash 
							temp << {'name' => hash['name'],
							'min_selection' => hash['min_selection'],
							'max_selection' => hash['max_selection']
							}  
							
						end
					end
					
				diffitem << temp
			end
			optionsGroup << diffitem
		end
		# first array is for submenu second is for item then thirs is where our hashes for that item lives aka groupoptions
		# if it doesnt have group options its states so.. an array will have many hashes thats because the items array has many
		# items that all point back to submenu.. so the idea is
		# 1 submenu has items.. those items have a group or dont.. then many options for each group
		# binding.pry
		optionsGroup
	end
	def buildOptions
		mainMenu
		mainMenu.each do |x|
			temp = []
			x['children'].each do |hashes|
				temp1 = []
				hashes['children'].each do |hash|
					#option group hash
					temp2 = []
					if hash['children'].length == 0
						temp2 << ['no options bruh']
					else
						hash['children'].each do |option|
							temp2 << {'name' => option["name"],
							"description" => option["description"],
							"max_price" => option["max_price"]
						}
						end
					end
					temp1 << temp2
				end
				temp << temp1
			end
			options << temp
		end
		
		#options[0][0][0] returns array of options
		#options[menu][item][options]
		options
		
	end
	def showSubMenus(num)
			puts subMenus[num]['name']
			if subMenus[num]['description'].length != 0
				puts subMenus[num]['description']
			end
			puts '------------------------------'
	end
	# methods need to be refactored to be entered into active record, right now prints to cli
	def showItems(num)
		# binding.pry
		# items[0] returns an array of all items to the 0 element in subMenus
		i = 0
		items[num].each do |itemhash|
			puts '            '
			itemhash.each do |k,v|
				puts k
				puts v
			end
			puts "the item number is #{i}"
				i+=1
			puts '            '
		end
		puts '------------------------------'
	# need to save num and then whatever element number for item to pass into show options group
	end
	def showOptionsGroup(submenu,item)
		# binding.pry
		# optionsgroup[0] returns the 0 element submenu
		# optionsgroup[0][0] refers to the item in that submenu
		# option group [0][0][0] refers to the options in that item
		optionsGroup[submenu][item].each do |og|
			puts '            '
			if og.class == String
				puts "no options avaliable"
			else
				og.each do |k,v|
					puts k
					puts v
				end
			end
			puts '            '
		end
		puts '------------------------------'
		
	end
	def showOptions(submenu,item,groupOption)
		# binding.pry
		#options[0]is the submenu
		#option[0][0] is the item
		#option[0][0][0] is array of hash
		options[submenu][item][groupOption].each do |options|
			puts '            '
				options.each do |k,v|
					puts k
					puts v
				end
			puts '            '
		end
		
	end
end
x = Menu.new
x.buildSubMenu
x.buildItems
x.buildOptionsGroup
x.buildOptions
x.showSubMenus(0)
yes = gets.chomp
puts "            "
puts "             "
puts "            "
puts "             "
if yes == "ok"
	x.showItems(0)
	puts "       "
	puts "         "
	puts "           "
	puts "          "
	okay = gets.chomp
	
	somenum = gets.chomp
		x.showOptionsGroup(0,somenum.to_i)
		puts "         "
		puts "            "
		puts "            "
		puts "            "
		done = gets.chomp
			if done == 'ok'
			x.showOptions(0,0,0)
		end
	
end