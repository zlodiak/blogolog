class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # protect_from_forgery

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.superadmin?
      flash[:alert] = "Доступ только зарегистрироавнным пользователям!"
      redirect_to root_path
    end
  end  

  def error_403
    render :file => "#{Rails.root}/public/403", :status => 403 
  end

  def error_404
    render :file => "#{Rails.root}/public/404", :status => 404
  end  

  def admin_check
    error_403 unless current_user.superadmin == true
  end   

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:password, :password_confirmation,:current_password,:email,:title) }
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:password, :password_confirmation,:current_password,:email,:title) }
    end    
end
