# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    resource :session, only: %i[new create destroy] # маршруты в единственном числе и мы не ожидаем идентификаторов (id)

    resources :users, only: %i[new create edit update]

    resources :questions do
      resources :comments, only: %i[create destroy]

      resources :answers, except: %i[new show]
    end

    resources :answers, except: %i[new show] do
      resources :comments, only: %i[create destroy]
    end

    namespace :admin do
      resources :users, only: %i[index new create edit update destroy]
    end

    root 'pages#index'
  end
end
