module IntersectionsHelper
	require 'rest-client'

	def validate_location(intersection)
		params = {
			address: intersection,
			key: ENV['GMAPS_API_KEY']
		}
		url = 'https://maps.googleapis/maps/api/geocode/json'
		response = RestClient::Request.execute(
			method: :post,
			url: url,
			payload: params)
	end
end
