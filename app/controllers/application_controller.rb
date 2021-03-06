class ApplicationController < ActionController::Base
  before_action :set_locale
  after_action :user_activity
  include SessionsHelper
  include MessagesHelper
  include ApplicationHelper

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t "login"
    redirect_to new_user_session_url
  end

  def user_activity
    current_user.try :touch
  end
end
