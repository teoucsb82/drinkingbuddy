require 'twilio-ruby'
 
class TwilioController < ApplicationController
  include Webhookable
  before_filter :authenticate_user!, :only => [:send_text_message]
  after_filter :set_header
  
  skip_before_action :verify_authenticity_token

  def receive_text_message 
    phone = params["From"]
    message_body = params["Body"]
    user = User.find_by_phone(phone)
    100.times { p params }
  end

  def send_text_message
    number_to_send_to = "+1#{params[:number_to_send_to]}"

    @twilio_client = Twilio::REST::Client.new TWILIO_CONFIG['sid'], TWILIO_CONFIG['token']
    @twilio_client.account.sms.messages.create(
      :from => "+13103073387",
      :to => number_to_send_to,
      :body => "Hi! Reply CHEERS to this message to confirm your account."
    )

    @user = current_user
    success = @user.update_attributes!(:phone => params[:number_to_send_to].to_i)
  end

end