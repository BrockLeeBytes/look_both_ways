class State < ApplicationRecord
	has_many :intersections
	accepts_nested_attributes_for :intersections
end
