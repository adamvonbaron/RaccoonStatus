namespace :setup do
  desc "create default admin user for a new environment"
  task create_admin_user: :environment do
    user = User.create!(
      username: ENV.fetch("DEFAULT_ADMIN_USERNAME"),
      password: ENV.fetch("DEFAULT_ADMIN_PASSWORD"),
      password_confirmation: ENV.fetch("DEFAULT_ADMIN_PASSWORD"),
      email: ENV.fetch("DEFAULT_ADMIN_EMAIL")
    )

    user.confirm
  end
end
