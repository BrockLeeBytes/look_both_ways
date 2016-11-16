Rails.application.routes.draw do

  get 'intersections/new'

	root 'static_pages#home'

	get '/states', to: 'static_pages#states'
	get '/signup', to: 'users#new'
	post '/signup', to: 'users#create'
	get '/addintersection', to: 'intersections#new'
	post '/addintersection', to: 'intersections#create'
	resources :users, :intersections
end
