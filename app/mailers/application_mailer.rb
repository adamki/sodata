class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'

  sendgrid = SendGrid::Client.new do |c|
    c.api_key = ENV['SENDGRID_API_KEY']
  end
end
