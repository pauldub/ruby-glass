# Public: Handler for the Glass Contacts API.
#
# Allows to create, list, get and manipulate user's contacts.
class Glass::Api::Contacts < Glass::Api::Base
	resource "contacts"

	# TODO: Might be useful to provide information on authorization error.
	def scopes
		%w(glass.timeline glass.location)
	end
end
