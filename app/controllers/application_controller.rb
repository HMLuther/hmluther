class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception # :null_session
  skip_before_action :verify_authenticity_token, if: :json_request?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  protected

  # def after_sign_in_path_for(resource)
  #   sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
  #   if request.referer == sign_in_url
  #     super
  #   else
  #     stored_location_for(resource) || request.referer || root_path
  #   end
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  def json_request?
    request.format.json?
  end

  def authenticate_api_user
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      ENV["FMP_TOKEN"] == token
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'

    respond_to do |format|
      format.json { render json: 'Bad credentials', status: 401 }
    end
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end

  def authenticate_admin
    unless current_user.try(:admin?)
      user_not_authorized
    end
  end

end
