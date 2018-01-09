class SessionsController < ApplicationController

  def new
    redirect_to root_path if current_user
    @user = User.new # todo - ask why myflix doesn't need this line here
	end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you've logged in."
      redirect_to root_path
    else
      flash[:error] = "Are you sure you're registered on this site?"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil # do i know what session is?
    flash[:notice] = "You've logged out."
    redirect_to root_path
  end
end
