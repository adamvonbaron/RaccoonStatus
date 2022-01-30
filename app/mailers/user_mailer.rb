class UserMailer < Devise::Mailer
  include Devise::Mailers::Helpers
  include DeviseInvitable::Mailer

  default from: "trashpanda@raccoonstatus.biz"

  def invitation_instructions(resource, token, opts = {})
    @token = token
    devise_mail(resource, :invitation_instructions, opts)
  end
end
