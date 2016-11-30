class StatesController < ApplicationController

	def index
	end

	def show
	end

	def new
		@state = State.new
		@states = State.all 
	end

	def create_intersection
		@state = State.find_by(postal_code: state_params )
	end

	private

		def state_params
			permitted = params.require(:state).permit(:postal_code)
			permitted[:postal_code]
		end
end
