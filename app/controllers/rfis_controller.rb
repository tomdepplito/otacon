require 'rfi_recipient_coordinator'

class RfisController < ApplicationController
  before_filter :authenticate_user!

  def new
    @rfi = Rfi.new(:parent_id => params[:parent_id], :receiver_id => params[:receiver_id])
    file = @rfi.attachments.build
  end

  def create
    @rfi = Rfi.new(params[:rfi])
    @rfi.parent_id = params[:parent_id] if params[:parent_id].present?
    @rfi.receiver_id = params[:receiver_id] if params[:receiver_id].present?
    @rfi.sender_id = current_user.id
    if @rfi.save
      flash[:success] = "You've just sent a RFI"
      redirect_to my_rfis_path
    else
      flash[:error] = "Sorry, we could not find any vendors for you.  Try modifying your search."
      render :new
    end
  end

  def index
    if current_user.company.nil?
      flash[:error] = "Create a company account to accesss this page"
      redirect_to new_company_path
    elsif current_user.company.subscription.active
      all_rfis = Rfi.all_parent_messages.select { |rfi| rfi.sender_id != @user.id }
      @rfis = all_rfis.nil? ? [] : sort_by_match(all_rfis)
    else
      flash[:error] = "Subscription is Inactive.  Please contact your company admin."
      redirect_to :root
    end
  end

  def show
    @previous_rfis = []
    @rfi = Rfi.find(params[:id])
    received_rfis = Rfi.where("parent_id = ? AND receiver_id = ? AND created_at < ?", @rfi.parent_id ? @rfi.parent_id : @rfi.id, current_user.id, @rfi.created_at)
    sent_rfis = Rfi.where("parent_id = ? AND sender_id = ? AND created_at < ?", @rfi.id, current_user.id, @rfi.created_at)
    @previous_rfis += received_rfis
    @previous_rfis += sent_rfis
  end

  def incoming_messages
    all_messages = Rfi.find_all_by_receiver_id(current_user.id)
    if current_user.company.nil?
      @messages = all_messages.sort
    elsif current_user.company
      @messages = sort_by_match(all_messages)
    else
      redirect_to :root
    end
  end

  def my_rfis
    @sent_rfis = current_user.rfis.select { |rfi| rfi.parent_id.nil? }
  end

  private

  def sort_by_match(rfis)
    specialties = current_user.specialty_list.all_keywords
    rfis_match = {}
    rfis.each do |rfi|
      rfis_match[rfi] = match_percentage(specialties, rfi)
    end
    rfis_match.sort_by { |k, v| v }.reverse
  end

  def match_percentage(employee_specialties, rfi)
    matches = []
    employee_specialties.each do |specialty|
      matches << specialty if rfi.keywords.detect { |keyword| specialty === keyword }
    end
    ((matches.length / (rfi.keywords.length > 0 ? rfi.keywords.length.to_f : 1.0)) * 100).round(0)
  end
end
