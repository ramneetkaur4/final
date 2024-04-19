class UsersController < ApplicationController
  def show
    @user = current_user
  end
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  # def create
    @user = User.new(user_params)
    if @user.save
      # Handle successful user creation, e.g., redirect to the user's profile
      redirect_to user_path(@user)
    else
      # Handle validation errors, e.g., re-render the signup form with errors
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :province, :address)
  end
end
