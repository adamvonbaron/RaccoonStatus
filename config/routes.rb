Rails.application.routes.draw do
  devise_for :users, path_names: { sign_up: "" }, controllers: {
    registrations: "users/registrations",
    invitations: "users/invitations"
  }

  authenticate do
    resources :statuses
    resources :users, param: :username, only: %i[show index]
  end

  root "statuses#index"
end
