class SessionsController < ApplicationController
  def new
  end

  def create
   raise :test
   @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to '/'
  end

  def auth_hash
    request.env['omniauth.auth']
  end
  def failure
  end
end
