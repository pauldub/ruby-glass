# Public: Handler for the Glass Accounts API.
#
# Allows to create user's accounts.
class Glass::Api::Accounts < Glass::Api::Base
	resource "accounts", only: [:insert]

	# TODO: Might be useful to provide information on authorization error.
	def scopes
		%w(glass.timeline glass.location)
	end
end
