class MenusController < ApplicationController

  def index	
  	if params.key("").to_i == 0
  		redirect_to ("/")
  	else
	    @menu = Menu.new(params.key("").to_i)
	    @menu.runner
	    
	    render "index"
	  end
  end

  def order
    
    x = SortOrder.new(params['choices'])
    x = x.saveOrder
    
  end

end
