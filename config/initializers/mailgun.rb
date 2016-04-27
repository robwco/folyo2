unless Rails.env.production?
  ENV['MAILGUN_DOMAIN'] = 'app3ab86bce1500439aa2da4c214caf6794.mailgun.org'
  ENV['MAILGUN_USER_NAME'] = 'postmaster@app3ab86bce1500439aa2da4c214caf6794.mailgun.org'
  ENV['MAILGUN_PASSWORD'] = '739d7731e083ce7dcbe54b3d37ff0a30'
end

Rails.configuration.action_mailer.smtp_settings = {
  :authentication => :plain,
  :address => "smtp.mailgun.org",
  :port => 587,
  :domain => ENV['MAILGUN_DOMAIN'],
  :user_name => ENV['MAILGUN_USER_NAME'],
  :password => ENV['MAILGUN_PASSWORD']
}
