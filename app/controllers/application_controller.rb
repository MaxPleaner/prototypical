class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SocketHelpers::ControllerHelpers

  before_action :set_current_user
  def set_current_user
    @current_user = User.find_by(id: session[:current_user_id])
  end

  before_action :set_messages
  def set_messages
    flash[:messages] ||= []
  end

  def login!(user)
    raise ArgumentError unless user.persisted?
    user.update(session_token: SecureRandom.urlsafe_base64)
    session[:current_user_id] = user.id
  end

  def logout!(user)
    raise ArgumentError unless user.persisted?
    user.update(session_token: nil)
    session.delete(:current_user_id)
  end

end
