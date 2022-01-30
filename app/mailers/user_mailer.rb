class UserMailer < ApplicationMailer
  include Devise::Mailers::Helpers
  include DeviseInvitable::Mailer

  def invitation_instructions(resource, token, opts = {})
    @token = token
    devise_mail(resource, :invitation_instructions, opts)
  end
end
