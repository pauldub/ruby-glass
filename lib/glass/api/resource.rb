# Public: Builds API instance methods.
module Glass::Api::Resource
	def resource(name, only: nil, except: [])
		handlers = %i(insert list get patch update delete)

		class_eval do
			@resource = name
			@handlers = only || handlers 
			@handlers -= except

			def self.resource_name
				@resource
			end

			def self.handlers
				@handlers
			end
		end

		include InstanceMethods
		
		# Remove methods as requested.
		handlers.each do |method|
			if defined?(method)
				undef_method method unless self.handlers.include? method
			end
		end
	end

	module InstanceMethods
		def insert(payload)
			client.post(resource_path, payload)	
		end

		def list
			client.get(resource_path)
		end

		def get(id)
			client.get(resource_path(id))
		end

		def patch(id, payload)
			client.patch(resource_path(id), payload)
		end

		def update(id, payload)
			client.put(resource_path(id), payload)
		end

		def delete(id)
			client.delete(resource_path(id))
		end

		def resource_path(id = nil)
			path = "#{self.class.resource_name}"
			path << "/#{id}" if id
			path
		end
	end
end
