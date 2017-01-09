class ReviewsController < ApplicationController

	def create
		@review = current_user.reviews.build(review_params)
		if @review.save
			flash[:success] = 'Review created!'
			redirect_to :back
		else
			redirect_to :back
		end
	end

	def destroy
	end

	private

		def review_params
			params.require(:review).permit(:body, :rating, :intersection_id)
		end
end
