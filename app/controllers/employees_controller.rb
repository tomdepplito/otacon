class EmployeesController < ApplicationController
  def new
    @employee = Employee.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @employee = Employee.new #This does not work yet
    @employee.user_id = User.find_by_email(params[:email]).id
    @employee.company_id = params[:id]
    respond_to do |format|
      format.js
    end
  end
end
