# Public: Handler for the Glass Subscriptions API.
#
# Allows to create, list, get and manipulate user's subscriptions.
class Glass::Api::Subscriptions < Glass::Api::Base
	resource "subscriptions", except: [:patch]

	# TODO: Might be useful to provide information on authorization error.
	def scopes
		%w(glass.timeline glass.location)
	end
end
