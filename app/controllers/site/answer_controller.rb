class Site::AnswerController < SiteController
  def question
    @answer = Answer.find(params[:answer])
    UserStatistic.set_user_statistics(@answer, current_user)
  end
end
