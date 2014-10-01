if Rails.env.development?
  path = File.join(Rails.root, "config/twilio.yml")
  TWILIO_CONFIG = YAML.load(File.read(path))[Rails.env] || {'sid' => '', 'from' => '', 'token' => ''}

  Twilio.configure do |config|
    config.account_sid = TWILIO_CONFIG['sid']
    config.auth_token = TWILIO_CONFIG['token']
  end
else
  Twilio.configure do |config|
    config.account_sid = ENV['TWILIO_ACCOUNT_SID']
    config.auth_token = ENV['TWILIO_AUTH_TOKEN']
  end
end