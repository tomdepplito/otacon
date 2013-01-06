require 'rfi_recipient_coordinator'
require 'address'

class RfisController < ApplicationController
  before_filter :authenticate_user!

  def new
    @rfi = Rfi.new(:parent_id => params[:parent_id])
  end

  def create
    @rfi = Rfi.new(params[:rfi])
    employee = Employee.find_by_user_id(current_user.id)
    if employee #Refactor This
      rfi_coord = RfiRecipientCoordinator.new(employee.id, @rfi.body, employee.latitude, employee.longitude, params[:miles])
    else
      rfi_coord = RfiRecipientCoordinator.new(current_user.id, @rfi.body, nil, nil, params[:miles])
    end
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
