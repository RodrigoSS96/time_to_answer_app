class UserProfile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar


  private

  def avatar_attached?
    avatar.attached?
  end
end
