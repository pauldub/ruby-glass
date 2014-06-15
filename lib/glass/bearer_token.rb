require 'faraday'

# Internal: A Faraday middleware adding the access token to each request.
class Glass::BearerToken < Faraday::Middleware
	attr_reader :token

	def initialize(app, token)
		super(app)

		@token = token
	end

	def call(env)
		env[:request_headers]['Authorization'] ||= "Bearer #{token}"
		@app.call(env)
	end
end

Faraday::Request.register_middleware bearer_token: -> { Glass::BearerToken }
