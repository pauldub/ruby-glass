# Public: The base class for APIs.
#
# It wraps common logic accross apis.
class Glass::Api::Base
	attr_reader :client

	def initialize(client) 
		@client = client
	end

	extend Glass::Api::Resource
end
