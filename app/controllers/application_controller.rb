class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  
  
  def set_search
    @q = Tweet.search(params[:q])
    @tweets = @q.result.page(params[:page]).per(10).order("created_at DESC")
  end
  
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image, :profile])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :profile, :password, :password_confirmation, :current_password])
  end
end
