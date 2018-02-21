Rails.application.routes.draw do
  

	#1. ####example for rooting 
	#get '/index', controller: 'products', action: 'index'	
	#get  'index', => 'products#index'	


  #26/09/2017 import from products controller
	resources :products do
		#post request called import, import action def in controller products
		collection {post :import}
		collection {get :filter}
		collection {post :filter}

	end 

	
	get '/shopfloor', controller: 'products', action: 'shopfloor'
	
	#localhost/3000
	root to:  				'products#show'	
										

	match 'destroy_them_all', to: 'proudcts#destroy', via: :delete

end											

	
