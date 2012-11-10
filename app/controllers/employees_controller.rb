class EmployeesController < ApplicationController
  def new
    @employee = Employe.new
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      flash[:success] = "You've create a new employee"
      redirect_to users_path
    else
      flash[:success] = "Something went wrong"
      render :new
    end
  end
end
