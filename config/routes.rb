Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users, only: [:show, :edit, :update] do
    member do
      # ユーザーのコンサルタントステータスを変更する
      patch :toggle_consultant_status
    end

    resources :consultations, only: [:new, :create, :show] do
      collection do
        # ユーザーが受けたコンサル依頼一覧を表示する
        get :received_consultations
      end
      member do
        # コンサル依頼を受ける
        patch :accept
        # コンサル依頼を拒否する
        patch :reject
      end
    end
  end
end
