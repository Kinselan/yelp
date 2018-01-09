class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'Thanks for registering. You are now logged in.'
      # session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = 'Too silly to be true. Your registration was rejected. Try again.'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
