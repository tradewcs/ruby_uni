require 'ostruct'

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Optional: handle unauthorized access gracefully
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)
  end

  def current_user
    nil

    # OpenStruct.new(id: 2, email: "filipchuk@chnu.edu.ua")
  end

  helper_method :current_user
end
