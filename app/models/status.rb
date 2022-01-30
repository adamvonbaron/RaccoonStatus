# == Schema Information
#
# Table name: statuses
#
#  id         :uuid             not null, primary key
#  user_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_statuses_on_user_id  (user_id)
#

class Status < ApplicationRecord
  belongs_to :user
  has_rich_text :content

  validates :content, presence: true
end
