ActionMailer::Base.smtp_settings = {
  :address                => "smtp.gmail.com",
  :port                   => 587,
  :domain                 => 'soclivity.com',
  :user_name              => 'mailbox@soclivity.com',
  :password               => 'Grupact0729',
  :authentication         => 'plain',
  :enable_starttls_auto   => true
}
