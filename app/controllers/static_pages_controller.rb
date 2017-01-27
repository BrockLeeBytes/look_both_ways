class StaticPagesController < ApplicationController

	def home 
		@population = User.count
	end


end
