require 'rfi_recipient_coordinator'
require 'address'

class RfisController < ApplicationController
  before_filter :authenticate_user!

  def new
    @rfi = Rfi.new(:parent_id => params[:parent_id])
    file = @rfi.attachments.build
  end

  def create
    @rfi = Rfi.new(params[:rfi])
    employee = Employee.find_by_user_id(current_user.id)
    if employee #Refactor This
      @rfi.sender_id = employee.id
    else
      @rfi.sender_id = user.id
    end
    if @rfi.save
      flash[:success] = "You've just sent a RFI"
      redirect_to rfis_path
    else
      flash[:error] = "Sorry, we could not find any vendors for you.  Try modifying your search."
      render :new
    end
  end

  def index
    employee = Employee.find_by_user_id(current_user.id)
    specialties = SpecialtyList.find_by_owner_id(employee.id).all_keywords
    @rfis = Rfi.all
    @rfi_match = {}
    @rfis.each do |rfi|
      @rfi_match[rfi] = match_percentage(specialties, rfi)
    end
    @rfis = @rfi_match.sort_by { |k, v| v }.reverse
  end

  def show
    @rfi = Rfi.find(params[:id])
  end

  def match_percentage(employee_specialties, rfi)
    matches = []
    employee_specialties.each do |specialty|
      matches << specialty if rfi.keywords.detect { |keyword| specialty === keyword }
    end
    (matches.length / (rfi.keywords.length > 0 ? rfi.keywords.length.to_f : 1.0)) * 100
  end
end
