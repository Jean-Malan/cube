Rails.application.routes.draw do
  root "profiles#index"
  
  resources :bits do
    collection do
      get :get_bits
    end
  end
  
  resources :profiles do
      collection do
        get :get_all_profiles
        get :get_friends
        post :build_friend_request
        get :get_all_pending_requests
        get :get_all_friend_requests
        post :handle_friend_request
      end
    end

  devise_for :users, :controllers => { registrations: 'registrations' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
