Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    get :about, to: "homes#about"
    resources :genres, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
    end
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
	  end
	  resources :users, only: [:show] do
	    collection do
      
      end
      member do 
        patch 'withdraw'
        get 'unsubscribe'
      end
	  end   
    get "search" => "searches#search"
  end

  scope module: :public do
    root :to =>"homes#top"
    get 'posts/new'
    post '/posts' => 'posts#create'
    get '/about' => 'homes#about'
    get 'posts' => 'posts#index'
    get 'posts/:id' => 'posts#show', as: 'post'
    get 'posts/:id/edit' => 'posts#edit', as: 'edit_post'
    patch 'posts/:id' => 'posts#update', as: 'update_post'
    delete 'posts/:id' => 'posts#destroy', as: 'destroy_post'
    get "search" => "searches#search"
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htm

  # 顧客用ログイン
  # URL /users/sign_in ...
  # devise_for :users,skip: [:passwords], controllers: {
  #     registrations: "public/registrations",
  #     sessions: 'public/sessions'
  # }

  # # 管理者用
  # # URL /admin/sign_in ...
  # devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  #   sessions: "admin/sessions"
  # }
end
