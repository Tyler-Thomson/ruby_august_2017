class SessionsController < ApplicationController
  def new
  end

  def create
    flash[:errors] ||= []
    @user = User.find_by_email(params[:login][:email])

    if @user
      if @user.try(:authenticate, params[:login][:password])
        flash[:notice] = ["Successfully logged in."]

        session[:user_id] = @user.id
        return redirect_to "/users/#{@user.id}"
      end
      flash[:errors] << "Invalid Combination"
    else
      flash[:errors] << "Invalid Combination"
    end
    return redirect_to '/login'
  end

  def logout
    session.clear
    return redirect_to '/login'
  end
end
