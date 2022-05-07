class Question < ApplicationRecord
  belongs_to :subject, counter_cache: true, inverse_of: :questions
  has_many :answers
  validates :description, presence: true
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  #Callback
  after_create :set_statistic

  scope :search, ->(term) {
    where("lower(description) LIKE ?", "%#{term}%")
  }

  scope :last_questions, ->(page) {
    includes(:answers, :subject).order('created_at desc').page(page)
  }

  scope :search_subject, ->(subject_id) {
    where(subject_id: subject_id)
  }

  paginates_per 5

  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_questions])
  end
end
