class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def not_found
    render_not_found
  end

  def authorize_admin
    return unless @current_user.nil? || !@current_user.admin?

    render_not_authorized
  end

  def resource
    @_resource ||= find_model(params[:resource_type], params[:resource_id])
  end

  def find_model(type, id)
    type.singularize.camelize.constantize.find(id)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :current_password) }
  end
end
