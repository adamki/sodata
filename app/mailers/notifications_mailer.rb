class NotificationsMailer < ApplicationMailer
  default from: "from@example.com"

  def send_update_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Welcome to Sodata!' )
  end

end
