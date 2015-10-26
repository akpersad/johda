class MenusController < ApplicationController

  def index
    @menu = Menu.new
    @menu.runner
    
    
    render('index')
    
  end

end
