# Public: Handler for the Glass Settings API.
#
# Allows to get user's settings.
class Glass::Api::Settings < Glass::Api::Base
	resource "settings", only: [:get]
end
