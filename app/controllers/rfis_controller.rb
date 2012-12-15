require 'rfi_recipient_coordinator'
require 'address'

class RfisController < ApplicationController
  before_filter :authenticate_user!

  def new
    @rfi = Rfi.new
  end

  def create
    @rfi = Rfi.new(params[:rfi])
    if RfiRecipientCoordinator.new(current_user.id, @rfi.body, current_user.latitude, current_user.longitude)
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

  def show
    @rfi = Rfi.find(params[:id])
  end
end
