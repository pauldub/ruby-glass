module Glass::Api::Resource
	def resource(name)
		class_eval do
			@resource = name

			def self.resource_name
				@resource
			end
		end

		include InstanceMethods
	end

	module InstanceMethods
		def insert(payload)
			client.post(resource_url, payload)	
		end

		def list
			client.get(resource_url)
		end

		def get(id)
			client.get(resource_url(id))
		end

		def patch(id, payload)
			client.patch(resource_url(id), payload)
		end

		def update(id, payload)
			client.put(resource_url(id), payload)
		end

		def delete(id)
			client.delete(resource_url(id))
		end

		def resource_url(id = nil)
			url = "#{self.class.resource_name}"
			url << "/#{id}" if id
			url
		end
	end
end
