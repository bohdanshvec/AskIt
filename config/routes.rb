Rails.application.routes.draw do

  resources :questions do
    get 'show_error', on: :collection
  end

  root "pages#index"
end
