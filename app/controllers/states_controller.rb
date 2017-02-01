class StatesController < ApplicationController

	def index
		@states = State.all
	end

	def show
		@state = State.find_by(name: params[:id])
	end

	def new
		@state = State.new
		@states = State.all 
	end

	def create_intersection
		@state = State.find_by(postal_code: state_params )
		@intersection = @state.intersections.build(intersection_params)
		if @intersection.save
			cities = @state.cities.push(@intersection.city)
			@state.update_attributes(cities: cities.uniq)
			redirect_to @intersection
		else
			flash[:danger] = @intersection.errors.full_messages.to_sentence
			redirect_back(fallback_location: :new)
		end
	end

	private

		def state_params
			permitted = params.permit(:postal_code)
			permitted[:postal_code]
		end

		def intersection_params
			permitted = params.require(:intersection).permit(:street_one,
																												:street_two,
																												:city)
		end
end
