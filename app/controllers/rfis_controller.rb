require 'rfi_recipient_coordinator'
require 'address'

class RfisController < ApplicationController
  before_filter :authenticate_user!

  def new
    @rfi = Rfi.new
  end

  def create
    @rfi = Rfi.new(params[:rfi])
    @address = Address.new(params[:house_num], params[:street], params[:city], params[:state], params[:zip])
    @rfi.street_address = @address.to_string
    if RfiRecipientCoordinator.new(current_user.id, params[:body])
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
