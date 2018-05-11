Rails.application.routes.draw do

  match '/logout', to: 'sessions#destroy', via: [:get, :post]
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }

  resources :users, path: 'u' do
    get :curl, on: :member
    get :demo, on: :collection
    get :demo_curl, on: :collection

    resources :charges, except:[:index, :show] do
      post :plan, :on => :collection
      post :unsubscribe, :on => :collection
    end

    get :tor, on: :member
    get :blacklist, on: :member
    post :post_update, on: :member
  end

  # API
  namespace :v1, defaults: {format: :json} do
    get :api, to: 'users#api', :path => '/'
  end

  # match '/:locale' => 'evangelists#index', via: [:get], :as => 'locale_root'
   root 'users#index'
end
