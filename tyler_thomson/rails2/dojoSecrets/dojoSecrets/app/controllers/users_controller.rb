class UsersController < ApplicationController
  before_action :current_user, only: [:new]
  def new
  end

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      return redirect_to "/login"
    end
    flash[:errors] = user.errors.full_messages
    flash[:errors] << "Can't be blank"
    return redirect_to '/register'
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
