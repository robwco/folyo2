unless Rails.env.production?
  ENV['MANDRILL_APIKEY'] = 'ysqj5OBOdF-KwnQIcEoayw'
end

MandrillDm.configure do |config|
  config.api_key = ENV['MANDRILL_APIKEY']
end
