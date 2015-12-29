# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,
    :address        => "smtp.gmail.com",
    :port           => 587,
    :domain         => "gmail.com",
    :user_name      => "ramselvam62@gmail.com",
    :password       => "17091962",
    :authentication => :plain
}