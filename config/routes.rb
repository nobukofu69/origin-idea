Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users, only: [:show, :edit, :update] do
    member do
      # ユーザーのコンサルタントステータスを変更する
      patch :toggle_consultant_status

      # ユーザーが受けたコンサル依頼一覧を表示する
      get :received_consultations
    end

    resources :consultations, only: [:new, :create]
  end
end
