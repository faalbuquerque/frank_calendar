require 'sinatra'

module Authentication
  def current_user
    @user ||= User.user_new(session[:user]) if session[:user]
  end

  def user_signed_in?
    !!current_user
  end

  def authenticate_user
    halt 401, { message: 'Se logue para continuar!' }.to_json unless user_signed_in?
  end
end
