class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  validates :username, presence: {  allow_blank: true }, uniqueness: { allow_blank: true }
  validates :email, presence: true, uniqueness: true

  has_many :statuses, dependent: :destroy
  has_many :invitations, class_name: "User", as: :invited_by
  has_one :current_status, -> { order(created_at: :desc) }, class_name: "Status"
  
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [64, 64]
  end

  def to_param = username
end
