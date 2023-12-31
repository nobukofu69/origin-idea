Rails.application.routes.draw do
  get '/health_check', to: proc { [200, {}, ['']] }
  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  root to: 'home#top'
  get 'home', to: 'home#index'
  get 'pages/terms', to: 'pages#terms'
  get 'pages/privacy', to: 'pages#privacy'

  resources :users, only: %i[show edit update] do
    member do
      # ユーザーのコンサルタントステータスを変更する
      patch :toggle_consultant_status
    end

    resources :consultations, only: %i[index new create show] do
      member do
        # コンサル依頼を受ける
        patch :accept
        # コンサル依頼を拒否する
        patch :reject
      end
    end
  end

  resources :talkrooms, only: [:index] do
    collection do
      get ':consultation_id', to: 'talkrooms#show', as: 'talkroom'
      patch ':consultation_id', to: 'talkrooms#end_consultation'
    end
  end
end
