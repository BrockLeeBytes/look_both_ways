class IntersectionsController < ApplicationController
  

  def index
    @intersections = Intersection.where(state_id: params[:id2], city: params[:id])
  end

  def show
  	@intersection = Intersection.find(params[:id])
    @review = current_user.reviews.build if logged_in?
    @reviews = @intersection.reviews
  end

  def maps_url
  	search = generate_search(@intersection.street_one,@intersection.street_two)
  	search = search.split.join('+')
  	search = "#{search},#{@intersection.city}+#{@intersection.state}"
  	"https://www.google.com/maps/embed/v1/place?key=#{ENV['GMAPS_API_KEY']}&q=#{search}"
  end
  helper_method :maps_url

  private

    # Returns search string to be used in maps_url
  	def generate_search(st1, st2)
  		a = [st1, st2].sort
  		"#{a[0]} and #{a[1]}" 
  	end

end
