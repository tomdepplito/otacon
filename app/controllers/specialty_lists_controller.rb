class SpecialtyListsController < ApplicationController
  def edit
    @specialty_list = SpecialtyList.find_by_user_id(params[:id])
  end

  def update
    @specialty_list = SpecialtyList.find_by_user_id(params[:id])
    @specialty_list.update_attributes(params[:specialty_list])
    if @specialty_list.save
      flash[:success] = "List Updated!"
      redirect_to users_path
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end
end
