class MenusController < ApplicationController


  def index
    @menu = Menu.new(params.key("").to_i)
    @menu.runner

    @input = session['last_search']
		@results = Getrestaurants.new(@input)

		@results.merchant_id.each_with_index do |e,i|
			if e == params.key("")
				@name = @results.name[i]
			end
		end

    render "index"
  end


  def order
    if !session[:user_id].nil?
      x = SortOrder.new(params['choices'],session[:user_id])
      x.saveOrder
      redirect_to ('/menus/order_history')
    else
      x = SortOrder.new(params['choices'])
    end
  end

  def order_history
   if !session[:user_id].nil?
    @user = User.find_by_id(session[:user_id])

    render('order_history')
   end
    
  end

end
