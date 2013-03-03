class EmployeesController < ApplicationController
  before_filter :get_company_info, :except => [:validate_employee]

  def edit
  end

  def update
    @employee.update_attributes(params[:user])
    if @employee.save
      flash[:success] = "Employee Updated!"
      redirect_to edit_company_path(@employee.company_id)
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    @employee.company_id = nil unless @company.admin_id == @employee.id
    if @employee.save
      flash[:success] = "Deleted Employee"
      redirect_to edit_company_path(@company.id)
    else
      flash[:error] = "Something went wrong"
      redirect_to :root
    end
  end

  def validate_employee
    @employee = User.find_by_email(params[:email])
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
    @employee = User.find(params[:id])
    @company = Company.find(params[:company_id])
    @offices = @company.offices
  end
end
