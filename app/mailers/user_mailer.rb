class UserMailer < ActionMailer::Base
#  default from: "from@example.com"
  
  def registeration_confirmation(user)
    mail(:to => user.email , :subject => "Welcome", :from => "help@soclivity.com")
  end
end
