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
      redirect_to company_edit_path(@company.id)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def edit
    @employee = Employee.find(params[:id])
    @offices = Office.where('company_id = ?', @employee.company_id)
  end

  def update
    @employee = Employee.find(params[:id])
    @offices = Office.where('company_id = ?', @employee.company_id)
    if @employee.update_attributes(params[:employee])
      flash[:success] = "Employee Updated!"
      redirect_to edit_company_path(@employee.company_id)
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @company = Company.find(@employee.company_id)
    @employee.delete unless @company.admin_id == @employee.id
    redirect_to :back
  end
end
