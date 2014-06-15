require 'faraday'
require 'faraday_middleware'

require 'oauth2'

# Public: The Mirror API client.
#
# It should be instanciated with the user's access token.
class Glass::Client
	attr_reader :base_uri, :conn, :client_id, :client_secret

	# Public: Create a new Mirror API client.
	#
	# token - A user access token.
	# client_id - (optional) Application's client ID.
	# client_secret - (optional) Application's client secret.
	#
	# "client_id" and "client_secret" are only required when performing 
	# authorization with the client, otherwise
	# only the "token" is required.
	def initialize(token = nil, client_id: nil, client_secret: nil)
		@client_id, @client_secret = client_id, client_secret

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

	def subscriptions
		@subscriptions_api ||= Glass::Api::Subscriptions.new(self)
	end

	def locations
		@locations_api ||= Glass::Api::Locations.new(self)
	end

	def contacts
		@contacts_api ||= Glass::Api::Contacts.new(self)
	end

	def accounts
		@accounts_api ||= Glass::Api::Accounts.new(self)
	end

	def settings
		@settings_api ||= Glass::Api::Settings.new(self)
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

	def authorize
		oauth_client.auth_code.authorize_url(authorize_params(scopes))
	end

	def scopes
		%w(glass.timeline glass.location)
	end

	def get_token(code)
		oauth_client.auth_code.get_token(code, get_token_params)
	end

	private

	def oauth_client
		@oauth_client ||= OAuth2::Client.new(@client_id, @client_secret, oauth_client_options)
	end

	def oauth_client_options
		{ 
			site: 'https://accounts.google.com',
			authorize_url: '/o/oauth2/auth',
			token_url: '/o/oauth2/token'
		}
	end

	def authorize_params(scopes)
		{
			scope: scopes.map(&method(:build_scope)).join(' '),
			redirect_uri: callback_url
		}
	end

	def build_scope(scope)
		unless scope =~ /^https?:\/\//
			"#{base_scope_url}#{scope}"
		else
			scope
		end
	end

	def get_token_params
		{
			redirect_uri: callback_url
		}
	end

	def callback_url
		'oob'
	end

	def base_scope_url
		'https://www.googleapis.com/auth/'
	end
end
