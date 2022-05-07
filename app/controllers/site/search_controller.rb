class Site::SearchController < SiteController

  def questions
    @questions = Question.includes(:answers, :subject)
                         .search(params[:term].downcase)
                         .page(params[:page])
  end

  def subject
    @questions = Question.includes(:answers, :subject)
                         .search_subject(params[:subject_id].downcase)
                         .page(params[:page])
  end

  private

  def search_params
    params.require.permit(:term)
  end
end
