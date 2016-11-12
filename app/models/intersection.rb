class Intersection < ApplicationRecord
	validate :intersection_must_exist

	require 'rest-client'
	
	def get_geocode
		address = search_parameters
		key = ENV['GMAPS_API_KEY']
		url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{key}"
		response = RestClient.get url
		data_hash = JSON.parse response
	end

	def search_parameters
		search = "#{self.streets.split.join('+')},+#{self.city.split.join('+')},+#{self.state}"
	end

	def intersection_must_exist
		data_hash = get_geocode
		results = data_hash['results'][0]
		status = data_hash['status']
		if status != 'OK' || results['types'][0] != 'intersection'
			errors.add(:intersection, 'must exist')
		end
	end
end
