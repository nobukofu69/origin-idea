Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users, only: [:show, :edit, :update] do
    member do
      patch :toggle_consultant_status
    end
  end
end
