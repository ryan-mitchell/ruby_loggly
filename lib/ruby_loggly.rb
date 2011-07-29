require 'rest_client'

class Loggly

	def initialize(uri, username, password)
		@uri = uri
		@user = username
		@pass = password
	end

	def log(log_string)
		RestClient.post('https://logs.loggly.com/inputs/faa5af5f-c6d1-43fd-bda8-7b49a4ef1f58', log_string)
	end

	def search(query)
		RestClient.get(@uri, {:params => {:q => query}})
	end

end
