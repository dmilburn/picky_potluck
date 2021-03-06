class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :gate_keeper

  helper_method :current_user, :is_current_user?, :yummly_url_generator

  def current_user
    User.find_by(id: session[:user_id])
  end

  def gate_keeper
    if !current_user
      flash[:notice] = "Sign in required."
      redirect_to enter_path
    end
  end

  def is_current_user?(user)
    user.id == current_user.id
  end

  def yummly_url_generator(yummly_id)
    "http://www.yummly.com/recipe/#{yummly_id}"
  end
end
