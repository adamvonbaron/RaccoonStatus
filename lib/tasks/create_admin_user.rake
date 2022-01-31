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
    user.accept_invitation!
    user.invitation_accepted_at = Time.now
    user.save

    admin = Admin.create!(
      password: ENV.fetch("DEFAULT_ADMIN_PASSWORD"),
      password_confirmation: ENV.fetch("DEFAULT_ADMIN_PASSWORD"),
      email: ENV.fetch("DEFAULT_ADMIN_EMAIL")
    )
  end
end
