# Public: Handler for the Glass Contacts API.
#
# Allows to create, list, get and manipulate user's contacts.
class Glass::Api::Contacts < Glass::Api::Base
	resource "contacts"
end
