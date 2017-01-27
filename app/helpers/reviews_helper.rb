module ReviewsHelper

	# Returns true if review belongs to current user
	def current_user_review?(review)
		user = User.find(review.user_id)
		current_user?(user)
	end
end
