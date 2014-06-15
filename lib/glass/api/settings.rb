# Public: Handler for the Glass Settings API.
#
# Allows to get user's settings.
class Glass::Api::Settings < Glass::Api::Base
	resource "settings", only: [:get]

	# TODO: Might be useful to provide information on authorization error.
	def scopes
		%w(glass.timeline glass.location)
	end
end
