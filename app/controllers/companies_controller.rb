class CompaniesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_admin_status, :except => ['new', 'create']

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    @company.admin_id = current_user.id
    @subscription = Subscription.new(:stripe_customer_token => params[:stripe_card_token], :plan => 1)
    binding.pry
    if @company.save
      @subscription.company_id = @company.id
      @subscription.save_with_payment
      flash[:success] = "You've created a company"
      redirect_to company_path(@company)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def show
    @employees = Employee.where('company_id = @company.id')
  end

  def edit
    @employees = @company.employees
    @subscription = @company.subscription
    @customer = Stripe::Customer.retrieve(@subscription.stripe_customer_token)
  end

  def update
    if @company.update_attributes(params[:company])
      flash[:success] = "Company Updated!"
      redirect_to company_path(@company)
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end

  private

  def check_admin_status
    @company = Company.find(params[:id])
    redirect_to users_path unless current_user.id == @company.admin_id
  end
end
