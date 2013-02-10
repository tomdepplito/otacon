class Notifier < ActionMailer::Base
  default :from => "tomdepplito@gmail.com"

  # send a signup email to the user, pass in the user object that contains the user's email address
  def signup_email(user)
    mail(:to => user.email,
         :subject => "Welcome to Otacon!",
         :body => "this is working")
  end

  def new_employee_confirmation(user, company)
    @user = user
    @company = company
    mail(:to => user.email,
         :subject => "Verify your position with #{company.name}")
  end
end
