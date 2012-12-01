class RfisController < ApplicationController
  def new
    @rfi = Rfi.new
  end

  def create
    @rfi = Rfi.new(params[:rfi])
    @rfi.sender_id = current_user.id
    if @rfi.save
      flash[:success] = "RFI created"
      redirect_to rfis_path
      #redirect_to user_path(current_user)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def index
    @rfis = Rfi.all.select { |rfi| rfi.sender_id == current_user.id }
  end
end
