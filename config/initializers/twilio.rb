path = File.join(Rails.root, "config/twilio.yml")
TWILIO_CONFIG = YAML.load(File.read(path))[Rails.env] || {'sid' => '', 'from' => '', 'token' => ''}

Twilio.configure do |config|
  config.account_sid = TWILIO_CONFIG['sid']
  config.auth_token = TWILIO_CONFIG['token']
end