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
		@merch_id = params.key("")
    if MenuComment.find_by_merch_id(@merch_id.to_i)
      @comment = MenuComment.find_by_merch_id(@merch_id.to_i)
    else
      @comment = MenuComment.create(:merch_id=>@merch_id.to_i) 
    end
    render "index"
  end


  def order
    if !session[:user_id].nil?
      
      x = SortOrder.new(params['choices'],session[:user_id])
      x.saveOrder
     
    else
      x = SortOrder.new(params['choices'])
      x.display_order
    end
    redirect_to ('/menus/order_confirm')
  end

  def order_confirm
     if !session[:user_id].nil?
        if !params['reorder'].nil?
          @order = Order.find_by_id(params['reorder'].to_i)
        else
          user = User.find_by_id(session[:user_id])
          @order = user.orders.last
        end
          render('order_confirm')
    else
      @order = Order.last
      render('order_confirm')
     end
  end

  def confirm

    @order = Order.find_by_id(params['order_id'])
    @order.update(:complete=>1)
    @order.update(:submit_time=>Time.now.to_i)
    @order.save
    
  end

  def comment
    if !session[:user_id].nil?
      x = MenuComment.find_by_merch_id(params['merch_id'])
      x = x.comments.create
      x.user_id = session[:user_id]
      x.title = params['title']
      x.comment = params['comment']
      x.save
    else
      x = MenuComment.find_by_merch_id(params['merch_id'])
      @guest = 'guest'
      x = x.comments.create
      x.title = params['title']
      x.comment = params['comment']
      x.save
    end

    ###
    @menu = Menu.new(params['merch_id'].to_i)
    @menu.runner

    @input = session['last_search']
    @results = Getrestaurants.new(@input)

    @results.merchant_id.each_with_index do |e,i|
      if e == params.key("")
        @name = @results.name[i]
      end
    end
    @merch_id = params['merch_id']

    if MenuComment.find_by_merch_id(@merch_id.to_i)
      @comment = MenuComment.find_by_merch_id(@merch_id.to_i)
    else
      @comment = MenuComment.create(:merch_id=>@merch_id.to_i) 
    end
    
    redirect_to('/')  
  end

end
