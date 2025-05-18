require 'ostruct'

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)
  end

  def current_user
    if session[:user_id]
      email = "user#{session[:user_id]}@test.com"
      OpenStruct.new(
        id: session[:user_id],
        email: email,
        admin: (email == "user57@test.com")
      )
    else
      nil
    end
  end

  helper_method :current_user
end