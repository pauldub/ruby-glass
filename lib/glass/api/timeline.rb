# Public: Handler for the Glass Timeline API.
#
# Allows to create, list, get and manipulate timeline cards.
class Glass::Api::Timeline < Glass::Api::Base
	resource "timeline"

	# TODO: Might be useful to provide information on authorization error.
	def scopes
		%w(glass.timeline glass.location)
	end
end
