class SpecialtyListsController < ApplicationController
  def edit
    @specialty_list = SpecialtyList.find_by_user_id(params[:id])
  end

  def update
    @specialty_list = SpecialtyList.find_by_user_id(params[:id])
    if @specialty_list.update_attributes
      flash[:success] = "List Updated!"
      redirect_to users_path
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end
end
