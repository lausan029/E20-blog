Rails.application.routes.draw do

  get 'pages/dashboard'
  delete 'pages/delete_user/:id', to: 'pages#delete_user', as: 'delete_user'

	resources :posts do
		resources :comments, only: [:create, :destroy]
	end

	devise_for :users, controllers: {
		sessions: 'users/sessions',
		registrations: 'users/registrations'
	}

	root 'posts#index'
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
