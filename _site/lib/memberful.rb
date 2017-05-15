require 'httparty'

module Memberful
	class Client 
		include HTTParty
		base_uri 'https://workshop.memberful.com'

		def api_key
			"NTm__EBbLxwr1KAMPcAn"
		end

		def base_path
			"/admin"
		end

		def plans(options = {})
			url = "#{base_path}/subscriptions.json?auth_token=#{api_key}"
			self.class.get(url,options)
		end

		def subscribers(plan_id, page, options = {})
			url = "#{base_path}/plans/#{plan_id}/subscribers.json?page=#{page}&auth_token=#{api_key}"
			self.class.get(url,options)
		end
	end
end
