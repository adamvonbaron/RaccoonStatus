Rails.application.routes.draw do
  devise_for :users, path_names: { sign_up: "" }, controllers: {
    registrations: "users/registrations"
  }

  authenticate do
    resources :statuses
    resources :users, param: :username
  end

  root "statuses#index"
end
