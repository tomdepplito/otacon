class UsersController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "You've updated your profile"
      redirect_to user_path
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end
end
