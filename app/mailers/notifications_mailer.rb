class NotificationsMailer < ApplicationMailer
  default from: "from@example.com"

  def send_update_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Welcome to Sodata!' )
  end

  def send_stolen_alert(user, bike)
    @sad_user = user
    @bike = bike
    @users = User.all
    @users.each do |user|
      @user = user
      mail( :to => user.email,
      :subject => 'ALERT! ALERT! STOLEN BIKE!' )
    end
  end
end
