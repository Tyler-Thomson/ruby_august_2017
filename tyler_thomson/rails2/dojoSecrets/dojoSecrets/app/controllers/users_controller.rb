class UsersController < ApplicationController
  before_action :current_user
  def new
    @user = current_user
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
    @user = current_user
  end

  def update
    user = current_user
    if user.update(user_params)
      return redirect_to "/users/#{user.id}"
    end
    return redirect_to :back
  end

  def destroy
    @user = current_user
    @user.destroy
    session.clear
    return redirect_to '/register'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
