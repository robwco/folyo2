unless Rails.env.production?
  ENV['DRIP_API_KEY'] = '4uxndsr6yzdqdozqumdx'
  ENV['DRIP_ACCOUNT_ID'] = '7912110'
end

Drip::Client.class_eval do
	def self.default_client
		Drip::Client.new do |c|
			c.api_key = ENV['DRIP_API_KEY']
			c.account_id = ENV['DRIP_ACCOUNT_ID']
		end
	end
end
