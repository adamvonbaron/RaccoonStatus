Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]

  authenticate do
    resources :statuses
    resources :users, param: :username
  end

  root "statuses#index"
end
