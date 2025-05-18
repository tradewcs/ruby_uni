class SessionsController < ApplicationController
  def new
  end

  def create
    session[:user_id] = params[:user_id].to_i
    # Example: treat user_id == 1 as admin, others as normal users
    session[:admin] = (session[:user_id] == 1)
    redirect_to root_path, notice: "Logged in as user#{session[:user_id]}"
  end

  def destroy
    session[:user_id] = nil
    session[:admin] = nil
    redirect_to root_path, notice: "Logged out."
  end
end