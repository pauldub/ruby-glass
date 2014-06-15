# Public: Handler for the Glass Locations API.
#
# Allows to list and get user's locations.
class Glass::Api::Locations < Glass::Api::Base
	resource "locations", only: [:get, :list]
end
