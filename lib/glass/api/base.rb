# Public: The base class for APIs.
#
# It wraps common logic accross apis.
class Glass::Api::Base
	extend Glass::Api::Resource

	attr_reader :client

	def initialize(client) 
		@client = client
	end
end
