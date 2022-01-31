Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, path_names: { sign_up: "" }, controllers: {
    registrations: "users/registrations",
    invitations: "users/invitations"
  }

  authenticate do
    resources :statuses, except: %i[ index ]
    resources :users, param: :username, only: %i[show index]
  end

  root "statuses#index"
end
