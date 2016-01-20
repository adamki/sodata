class NotificationsMailer < ApplicationMailer
  default from: "from@example.com"

  def client
    client = SendGrid::Client.new(api_key: ENV['SENDGRID_API_KEY'])
  end

  def send_update_email(user)
    @user = user
    mail( :to => @user.email, :subject => 'Welcome to Sodata!' )
  end

  def send_stolen_alert
    mail = SendGrid::Mail.new do |m|
      m.to = User.pluck(:email)
      m.from = 'alerts@sodata.com'
      m.subject = "STOLEN BIKE ALERT! MISSING!!!"
      m.text = "Please be on the lookout for stolen bike"
    end

    client.send(mail)
  end



end
