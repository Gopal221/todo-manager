Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # 
  root 'todo_lists#index'
  resources :todo_lists do 
  	resources :todo_items do
  		collection do
	      patch :sort
        patch :mark_as_complete
	    end
  	end
  end
end
