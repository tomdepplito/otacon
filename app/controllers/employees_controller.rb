class EmployeesController < ApplicationController
  def new
    @employee = Employee.new
    @company = Company.find(params[:company_id])
  end

  def create
    @company = Company.find(params[:company_id])
    @employee = Employee.new
    @employee.user_id = User.find_by_email(params[:email]).id
    @employee.company_id = @company.id

    if @employee.save
      flash[:success] = "You've Added an employee"
      redirect_to company_path(@company.id)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end
end
