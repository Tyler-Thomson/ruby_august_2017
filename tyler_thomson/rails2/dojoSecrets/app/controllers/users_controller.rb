class UsersController < ApplicationController
  before_action :current_user, only: [:new]
  def new
  end

  def create
    @user = User.create(user_params)
    if @user
      flash[:success]= "Registration succeeded!"
      session[:user_id] = @user.id
        return redirect_to "/users/#{@user.id}"
    end
    flash[:errors] = @user.errors.full_messages
    return redirect_to :back
  end

  def show
    @user = current_user
  end

  def edit
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
