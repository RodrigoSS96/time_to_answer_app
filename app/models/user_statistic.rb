class UserStatistic < ApplicationRecord
  belongs_to :user

  def answered_questions
    self.right_questions + self.wrong_questions
  end

  def self.set_user_statistics(answer, user)
    if !!user
      user_statistic =  UserStatistic.find_or_create_by(user: user)
      answer.correct? ? user_statistic.right_questions += 1 : user_statistic.wrong_questions += 1
      user_statistic.save
    end
  end
end
