class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Добавляем поля в контроллер devise
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale


  protected
  # поле t_username используется только при регистрации
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :t_username])
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
