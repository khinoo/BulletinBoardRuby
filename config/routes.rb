Rails.application.routes.draw do
  root "posts#index"

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
end
