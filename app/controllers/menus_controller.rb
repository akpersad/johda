class MenusController < ApplicationController

  def index
    @menu = Menu.new(params.key("").to_i)
    @menu.runner
    
    
    render "index"

  end

end
