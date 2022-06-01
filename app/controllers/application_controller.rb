class ApplicationController < ActionController::Base
  before_action :set_cache_expiration

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_cache_expiration
    expires_in 60.minutes, public: true
  end
end
