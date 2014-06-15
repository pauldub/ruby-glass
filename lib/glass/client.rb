require 'faraday'
require 'faraday_middleware'

class Glass::Client
	attr_reader :base_uri, :conn

	def initialize(token = nil)
		@base_uri = 'https://www.googleapis.com/mirror/v1'
		@conn = Faraday.new(url: @base_uri) do |conn|
			conn.request :bearer_token, token
			conn.request :json
			conn.request :multipart

			conn.response :json, content_type: 'application/json'
			# FIXME: Looks like it isn't called, but this is not really a problem.
			conn.response :mashify

			conn.adapter Faraday.default_adapter
		end
	end

	def timeline
		@timeline_api ||= Glass::Api::Timeline.new(self)
	end

	def locations
		@locations_api ||= Glass::Api::Locations.new(self)
	end

	def get(*args)
		conn.get(*args)
	end

	def post(*args)
		conn.post(*args)
	end

	def put(*args)
		conn.put(*args)
	end

	def patch(*args)
		conn.patch(*args)
	end

	def delete(*args)
		conn.delete(*args)
	end
end
