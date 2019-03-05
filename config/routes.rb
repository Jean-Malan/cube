Rails.application.routes.draw do
  root "profiles#index"

  resources :profiles do
      collection do
        get :get_all_profiles
        post :build_friend_request
        get :get_all_pending_requests
        get :get_all_friend_requests
      end
    end

  devise_for :users, :controllers => { registrations: 'registrations' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
