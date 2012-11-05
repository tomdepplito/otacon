class OfficesController < ApplicationController
  def new
    @office = Office.new
  end

  def create
    @office = Office.new(params[:office])
    if @office.save
      flash[:success] = "You've create a new office"
      redirect_to offices_show_path
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end
end
