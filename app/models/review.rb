class Review < ApplicationRecord
	belongs_to :user
	belongs_to :intersection
	validates :intersection_id, uniqueness: { scope: :user_id,
															message: "You've reviewed this intersection already!"}
end

