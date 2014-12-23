require 'twilio-ruby'
class TwilioController < ApplicationController
  include Webhookable
  # after_filter :set_header
  skip_before_action :verify_authenticity_token
  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
      r.Play 'http://linode.rabasa.com/cantina.mp3'
    end
    render_twiml response
  end

   def notify
      client = Twilio::REST::Client.new 'your Twilio Account SID', 'your Twilio Auth Token'
      message = client.messages.create from: 'sender_number', to: 'reciever_number', body: 'Hello there.'
      render plain: message.status
   end

end
