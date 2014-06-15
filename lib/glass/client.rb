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

	# Public: Access the Timeline API resource.
	def timeline
		@timeline_api ||= Glass::Api::Timeline.new(self)
	end

	# Public: Access the Subscriptions API resource.
	def subscriptions
		@subscriptions_api ||= Glass::Api::Subscriptions.new(self)
	end

	# Public: Access the Locations API resource.
	def locations
		@locations_api ||= Glass::Api::Locations.new(self)
	end

	# Public: Access the Contacts API resource.
	def contacts
		@contacts_api ||= Glass::Api::Contacts.new(self)
	end

	# Public: Access the Accounts API resource.
	def accounts
		@accounts_api ||= Glass::Api::Accounts.new(self)
	end

	# Public: Access the Settings API resource.
	def settings
		@settings_api ||= Glass::Api::Settings.new(self)
	end

	# Public: Perform a GET request through Faraday.
	def get(*args)
		conn.get(*args)
	end

	# Public: Perform a POST request through Faraday.
	def post(*args)
		conn.post(*args)
	end

	# Public: Perform a PUT request through Faraday.
	def put(*args)
		conn.put(*args)
	end

	# Public: Perform a PATCH request through Faraday.
	def patch(*args)
		conn.patch(*args)
	end

	# Public: Perform a DELETE request through Faraday.
	def delete(*args)
		conn.delete(*args)
	end

	# Public: Returns an authorization url using provided
	# client_id and client_secret.
	def authorize
		oauth_client.auth_code.authorize_url(authorize_params(scopes))
	end

	# Public: Return an OAuth2::AccessToken using the given code.
	#
	# code - The code retrieved after authorization.
	def get_token(code)
		oauth_client.auth_code.get_token(code, get_token_params)
	end

	private

	# Internal: The OAuth2::Client used for authorization.
	def oauth_client
		@oauth_client ||= OAuth2::Client.new(@client_id, @client_secret, oauth_client_options)
	end

	# Internal: OAuth2::Client initialization options.
	def oauth_client_options
		{ 
			site: 'https://accounts.google.com',
			authorize_url: '/o/oauth2/auth',
			token_url: '/o/oauth2/token'
		}
	end

	# Internal: OAuth2 authorization parameters.
	def authorize_params(scopes)
		{
			scope: scopes.map(&method(:build_scope)).join(' '),
			redirect_uri: callback_url
		}
	end

	# Internal: Prepend's the base_scope_url to the given 
	# scope if necessary.
	def build_scope(scope)
		unless scope =~ /^https?:\/\//
			"#{base_scope_url}#{scope}"
		else
			scope
		end
	end

	# Internal: Scopes required to access the Mirror API.
	def scopes
		%w(glass.timeline glass.location)
	end


	# Internal: OAuth2 get_token parameters.
	def get_token_params
		{
			redirect_uri: callback_url
		}
	end

	# Internal: The OAuth2 callback url to use.
	#
	# "oob" is a convenient value during development because 
	# the user is redirected to a page where he can copy the 
	# authorization code.
	#
	# TODO: Parameterize the callback url.
	def callback_url
		'oob'
	end

	# Internal: The base url used in Google API scopes.
	def base_scope_url
		'https://www.googleapis.com/auth/'
	end
end
