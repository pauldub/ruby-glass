# Public: Handler for the Glass Accounts API.
#
# Allows to create user's accounts.
class Glass::Api::Accounts < Glass::Api::Base
	resource "accounts", only: [:insert]
end
