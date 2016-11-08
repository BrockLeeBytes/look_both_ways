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
  		st1 = 
  		a = [st1.downcase, st2.downcase].sort
  		"#{a[0]} and #{a[1]}" 
  	end

  	# String should be street parameter from user input
  	# Each street will be passed through to be given
  	# standard capitalization. 
  	def standardize_street_name(str)
  		str.downcase.split.map(&:capitalize).join(' ')
  	end

  	# Fix this method. Needs to use method above
  	def intersection_params
  		permitted = params.require(:intersection).permit(:street_one,
  																										 :street_two,
  																										 :city, :state)
  		streets = generate_streets(permitted[:street_one], permitted[:street_two]) 
  		new_hash = { streets: streets}
  		new_hash.merge(params[:intersection])
  	end
end
