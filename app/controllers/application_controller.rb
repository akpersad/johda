class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def check_if_logged_in
    deny_access unless logged_in?
  end

  def disable_nav
    @disable_nav = true
  end
end
