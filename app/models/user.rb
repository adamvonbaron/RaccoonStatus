# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  username               :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default("0"), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :uuid
#  invitations_count      :integer          default("0")
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#  index_users_on_username              (username)
#

class User < ApplicationRecord
  USERNAME_FORMAT = /\A[A-Za-z0-9][A-Za-z0-9\-_.]+\z/i

  # https://api.rubyonrails.org/v7.0/classes/ActiveModel/Validations/ClassMethods.html#method-i-validates
  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  validates :username, allow_blank: true, uniqueness: true, format: { with: USERNAME_FORMAT }

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_FORMAT }

  has_many :statuses, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :invitations, class_name: "User", as: :invited_by
  has_one :current_status, -> { order(created_at: :desc) }, class_name: "Status"
  
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [64, 64]
    attachable.variant :bigger_thumb, resize_to_limit: [128, 128]
  end

  # can probably expand this to other things too
  scope :active, -> { invitation_accepted }

  def to_param = username
end
