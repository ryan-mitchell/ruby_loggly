require 'rest_client'

class Loggly

	def initialize(uri, username, password)
		@uri = uri
		@user = username
		@pass = password
	end

	def search(query)
		RestClient.get(@uri, {:params => {:q => query}})
	end

end
