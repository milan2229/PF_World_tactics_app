ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
 :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'example.com',
  :user_name => 'yuuyaneish1899@gmail.com',
  :password => 'copsgqkxvajitmow',
  :authentication => :plain,
  :enable_starttls_auto => true
}

