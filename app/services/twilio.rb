require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'

class Twilio
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new ENV["account_sid"], ENV["auth_token"]
  end

  def self.outgoing_sms(recipient, message)
    client.messages.create(from: '+17752009368', 
                           to: '', 
                           body: '')
  end
end
