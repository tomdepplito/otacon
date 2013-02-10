# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Otacon::Application.initialize!

send_grid = YAML::load_file("#{Rails.root}/config/sendgrid.yml")

ActionMailer::Base.smtp_settings = {
  :user_name => send_grid['user_name'],
  :password => send_grid['password'],
  :domain => "https://morning-wildwood-9717.herokuapp.com/",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_url_options[:host] = "localhost:3000"
