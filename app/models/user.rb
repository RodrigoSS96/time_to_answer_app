class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #Callback
  after_create :set_statistic

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile
  accepts_nested_attributes_for :user_profile, reject_if: :all_blank

  #Validations
  validates :first_name, presence: true, if: :reset_password_token_present?
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :password_confirmation, numericality: { equal_to: :password }, allow_blank: true

  def full_name
    [self.first_name, self.last_name].join(' ')
  end

  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_users])
  end

  def reset_password_token_present?
    !!$global_params[:user][:reset_password_token]
  end
end
