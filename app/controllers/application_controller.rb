class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
before_action :set_current_user


protected

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def after_sign_up_path_for(resource)
     user_path(resource)
  end

  def after_sign_in_path_for(resource)
     user_path(resource)
  end

  def after_sign_out_path_for(resource)
     root_path
  end

  def configure_permitted_parameters
    added_attrs = [ :email, :name, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end