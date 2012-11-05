class CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
      flash[:success] = "You've created a company"
      redirect_to company_show_path(@company)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end
end
