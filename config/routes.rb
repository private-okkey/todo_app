Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "tasks#index", as: :authenticated_root
  end

  unauthenticated :user do
    root to: "pages#about", as: :unauthenticated_root
  end

  # current_user用いて、マイページ閲覧と編集に限定する
  resource :profile, only: [:show, :edit, :update]
  resources :tasks
  
  get "about", to: "pages#about", as: :about
end
