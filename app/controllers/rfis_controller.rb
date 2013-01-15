require 'rfi_recipient_coordinator'

class RfisController < ApplicationController
  before_filter :authenticate_user!, :look_up_user

  def new
    @rfi = Rfi.new(:parent_id => params[:parent_id], :receiver_id => params[:receiver_id])
    file = @rfi.attachments.build
  end

  def create
    @rfi = Rfi.new(params[:rfi])
    @rfi.parent_id = params[:parent_id] if params[:parent_id].present?
    @rfi.receiver_id = params[:receiver_id] if params[:receiver_id].present?
    employee = Employee.find_by_user_id(current_user.id)
    @rfi.sender_id = employee ? employee.id : current_user.id
    if @rfi.save
      flash[:success] = "You've just sent a RFI"
      redirect_to rfis_path
    else
      flash[:error] = "Sorry, we could not find any vendors for you.  Try modifying your search."
      render :new
    end
  end

  def index
    if @user.class.name == 'Employee'
      specialties = SpecialtyList.find_by_owner_id(@user.id).all_keywords
      @rfis = Rfi.all_parent_messages.select { |rfi| rfi.sender_id != @user.id }
      @rfi_match = {}
      @rfis.each do |rfi|
        @rfi_match[rfi] = match_percentage(specialties, rfi)
      end
      @rfis = @rfi_match.sort_by { |k, v| v }.reverse
    end
  end

  def show
    @rfi = Rfi.find(params[:id])
  end

  def incoming_messages
    @messages = Rfi.find_all_by_receiver_id(@user.id)
  end

  private

  def match_percentage(employee_specialties, rfi)
    matches = []
    employee_specialties.each do |specialty|
      matches << specialty if rfi.keywords.detect { |keyword| specialty === keyword }
    end
    ((matches.length / (rfi.keywords.length > 0 ? rfi.keywords.length.to_f : 1.0)) * 100).round(0)
  end

  def look_up_user
    @user = Employee.find_by_user_id(current_user.id)
    @user ||= User.find(current_user.id)
  end
end
