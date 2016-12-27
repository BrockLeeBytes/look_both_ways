Rails.application.routes.draw do


  get 'intersections/new'

	root 'static_pages#home'

	get '/signup', to: 'users#new'
	post '/signup', to: 'users#create'
	get '/intersections', to: 'intersections#index'
	get '/states', to: 'states#index'
	get '/createintersection', to: 'states#new'
	post '/createintersection', to: 'states#create_intersection'
	get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'
	delete '/logout', to: 'sessions#destroy'

	resources :users, :intersections, :states
end
