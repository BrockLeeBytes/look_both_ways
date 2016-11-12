class IntersectionsController < ApplicationController
  
  def new
  @intersection = Intersection.new
  end

  def create
  	@intersection = Intersection.new(intersection_params)
  	if @intersection.save
  		redirect_to @intersection
  	else
  		render :new
  	end
  end

  def show
  	@intersection = Intersection.find(params[:id])
  end

  def maps_url
  	search = @intersection.streets
  	search = search.split.join('+')
  	search = "#{search},#{@intersection.city}+#{@intersection.state}"
  	"https://www.google.com/maps/embed/v1/place?key=#{ENV['GMAPS_API_KEY']}&q=#{search}"
  end
  helper_method :maps_url

  private

  	def generate_streets(st1, st2)
  		a = [st1, st2].sort
  		"#{a[0]} and #{a[1]}" 
  	end

  	# Fix this method. Needs to use method above
  	def intersection_params
  		permitted = params.require(:intersection).permit(:street_one,
  																										 :street_two,
  																										 :city, :state)
  		streets = generate_streets(permitted[:street_one], permitted[:street_two]) 
  		new_hash = { streets: streets}
  		permitted.merge(new_hash)
  	end
end
