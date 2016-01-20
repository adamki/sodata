require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'

class TwilioService
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new ENV["account_sid"], ENV["auth_token"]
  end

  def build_sms(bike)
    users = User.all
    message = build_message(bike)
    users.each do |user|
      send_sms(user.phone_number, message) if user.gets_alert
    end
  end

  private

  def build_message(bike)
    "Please be on the lookout for a #{bike.model} #{bike.make} bike, serial number #{bike.serial_number} that was stolen on #{Time.now}"
  end

  def send_sms(recipient = "+17758159995", message)
    client.messages.create(from: '+17752009368', 
                           to: recipient, 
                           body: message)
  end
end
