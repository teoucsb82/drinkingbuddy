require 'twilio-ruby'
 
class TwilioController < ApplicationController
  include Webhookable
  before_filter :authenticate_user!, :only => [:send_text_message]
  after_filter :set_header
  
  skip_before_action :verify_authenticity_token

  def receive_text_message
    phone = params["From"].last(10).to_i
    user = User.find_by_phone(phone)

    message_body = params["Body"].downcase
    user.create_verification(:unique_id => user.id) if message_body.include?("cheers")

    respond_to do |format|
      if user == current_user
        format.js
      else
        render :nothing => true, :status => :ok
      end
    end
  end

  def send_text_message
    number = "+1" + params[:number_to_send_to].to_s unless params[:number_to_send_to].to_s[0..1] == "+1"
    twilio_client = Twilio::REST::Client.new
    twilio_client.account.sms.messages.create(
      :from => TWILIO_CONFIG['from'],
      :to => number,
      :body => "Hi! Reply CHEERS to this message to confirm your account."
    )

    @user = current_user
    success = @user.update_attributes!(:phone => params[:number_to_send_to].to_i)
  end

end