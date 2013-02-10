class EmployeesController < ApplicationController
  before_filter :get_company_info, :only => ['new', 'create']

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(params[:employee])
    @employee.user_id = User.find_by_email(params[:email]).id
    @employee.company_id = @company.id

    if @employee.save
      flash[:success] = "You've Added an employee"
      redirect_to edit_company_path(@company.id)
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
    redirect_to edit_company_path(@company.id)
  end

  def validate_employee
    @employee = Employee.new
    @employee.user_id = User.find_by_email(params[:email]).id
    @employee.company_id = params[:company_id]
    if @employee.save
      flash[:success] = "Email Validated!"
      redirect_to :root
    else
      flash[:error] = "Something went wrong"
      render :status => 500
    end
  end

  private

  def get_company_info
    @company = Company.find(params[:company_id])
    @offices = Office.where('company_id = ?', @company.id)
  end
end
