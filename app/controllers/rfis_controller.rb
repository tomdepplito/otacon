require 'rfi_recipient_coordinator'
require 'address'

class RfisController < ApplicationController
  before_filter :authenticate_user!

  def new
    @rfi = Rfi.new(:parent_id => params[:parent_id])
  end

  def create
    @rfi = Rfi.new(params[:rfi])
    rfi_coord = RfiRecipientCoordinator.new(current_user.id, @rfi.body, current_user.latitude, current_user.longitude, params[:miles])
    if rfi_coord.messages.length > 0
      flash[:success] = "You've just sent #{rfi_coord.messages.length} messages"
      redirect_to rfis_path
    else
      flash[:error] = "Sorry, we could not find any vendors for you.  Try modifying your search."
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
