class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception
  attr_reader :current_user

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_admin
    return unless @current_user.nil? || !@current_user.admin?

    render_not_authorized
  end

  def render_not_authorized
    render json: { error: 'Not Authorized' }, status: 403
  end

  def render_not_authenticated
    render json: { error: 'Not Authorized' }, status: 401
  end

  def resource
    @_resource ||= find_model(params[:resource_type], params[:resource_id])
  end

  def find_model(type, id)
    type.singularize.camelize.constantize.find(id)
  end
end
