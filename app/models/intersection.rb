class Intersection < ApplicationRecord
	has_many :reviews
	has_many :users, :through => :reviews
	belongs_to :state
	accepts_nested_attributes_for :state
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
		search = "#{self.street_one.split.join('+')}+and+#{self.street_two.split.join('+')},+#{self.city.split.join('+')},+#{self.state.postal_code}"
	end

	def intersection_must_exist
		data_hash = get_geocode
		results = data_hash['results'][0]
		status = data_hash['status']
		if status != 'OK' || results['types'][0] != 'intersection'
			errors.add(:intersection, 'must exist')
		elsif !correct_state?(results['formatted_address'])
			errors.add(:intersection, 'is in incorrect state')
		else
			set_formatted_address(results['formatted_address'])
		end
	end

	def correct_state?(address)
		address_array = address.split(',')
		if self.state.postal_code == address_array[-1]
			true
		else
			false
		end
	end

	# Returns true if Google's api returns a full address
	def good_address?(address_array)
		if address_array.length === 4
			true
		else
			false
		end
	end


	def set_formatted_address(address)
		address_array = address.split(',')
		if good_address?(address_array)
			self.formatted_address = address
			self.city = address_array[1].strip
		else
			address_array[0] = " #{address_array[0]}"
			address_array.unshift("#{self.street_one} & #{self.street_two}")
			self.city = address_array[1].strip
			self.formatted_address = address_array.join(',')
		end
	end

	# Returns an average of all the ratings the intersection has recieved
	def rating_avg
		total = 0.0
			
		if self.reviews.length === 0
			return total
		else
			self.reviews.each do |f|
				total += f.rating
			end
		end
		total / self.reviews.length
	end
end
