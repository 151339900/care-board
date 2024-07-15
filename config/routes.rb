Rails.application.routes.draw do
  devise_for :admins
  devise_for :users,skip: [:passwords], controllers: {
     registrations: "public/registrations",
     sessions: 'public/sessions'
   }

  scope module: :public do
    root :to =>"homes#top"
    get 'posts/new'
    post '/posts' => 'posts#create'
    get '/about' => 'homes#about'
    get 'posts' => 'posts#index'
    get 'posts/:id' => 'posts#show'
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
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
