Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  delete "/session", to: "sessions#destroy"
  root "posts#index"

  #Post routes
  resources :posts do 
    collection do
        post :create_form
        get :create_form
        post :create_confirm
        get :create_confirm
        patch :edit_form
        get :update_confirm
        post :post_update
        get :search_post
        get :upload
        post :import
    end
  end

  # User routes
  resources :users do
    collection do
      post :create_form
      get :create_form
      post :create_confirm
      get :create_confirm
      get :search_user
    end
    member do
      get :profile
      get :edit_profile
      post :update_profile
      get :update_profile, to: "users#edit_profile"
      get :update_confirm
      post :user_update
      post :create_confirm
      get :create_confirm
      get :change_password
      post :update_password
      get :update_password
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
end
