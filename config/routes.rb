Rails.application.routes.draw do
  authenticate :admin do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end

  devise_for :users, path_names: { sign_up: "" }, controllers: {
    registrations: "users/registrations",
    invitations: "users/invitations"
  }

  devise_for :admins, path_names: { sign_up: "" }

  authenticate do
    resources :statuses, except: %i[ index ]
    resources :users, param: :username, only: %i[show index]
  end

  root "statuses#index"
end
