# frozen_string_literal: true

class Blog < ApplicationRecord
  belongs_to :user
  has_many :likings, dependent: :destroy
  has_many :liking_users, class_name: 'User', source: :user, through: :likings

  validates :title, :content, presence: true

  scope :published, -> { where('secret = FALSE') }

  scope :accessible_by, lambda { |target_user|
    if target_user
      where('secret = FALSE OR user_id = ?', target_user.id)
    else
      published
    end
  }

  scope :owned_by, ->(target_user) { where(user_id: target_user.id) }

  scope :search, lambda { |term|
    where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
  }

  scope :default_order, -> { order(id: :desc) }

  def owned_by?(target_user)
    user == target_user
  end
end
