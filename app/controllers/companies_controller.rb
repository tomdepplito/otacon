class CompaniesController < ApplicationController

  before_filter :authenticate_user!

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    @company.admin_id = current_user.id
    if @company.save
      flash[:success] = "You've created a company"
      redirect_to company_path(@company)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      flash[:success] = "Company Updated!"
      redirect_to company_path(@company)
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end
end
