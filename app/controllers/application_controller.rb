class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_params, if: :devise_controller?

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :area_code])
  end

  def configure_permitted_parameters
    added_attrs = [ :username, :email, :password, :password_confirmation, :area_code　]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
