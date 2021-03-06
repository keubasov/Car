class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  # Добавляем поля в контроллер devise
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale


  protected
  # поле t_username используется только при регистрации
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :t_username, :region_id, :verified, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :t_username, :region_id, :verified, :role])
  end

  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{I18n.locale}'"
    #I18n.locale = params[:locale] || I18n.default_locale
  end

  private
  def extract_locale_from_accept_language_header
   request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
