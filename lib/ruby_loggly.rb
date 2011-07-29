require 'rest_client'

class Loggly

	def initialize(options)
		@subdomain = options[:subdomain]
		@user = options[:user]
		@pass = options[:pass]
		@key = options[:key]
	end

	def log(log_data)
		RestClient.post("https://logs.loggly.com/inputs/#{@key}", log_data)
	end

	def search(query)
		RestClient.get("https://#{@user}:#{@pass}@#{@subdomain}.loggly.com/api/search", {:params => {:q => query}})
	end

end
