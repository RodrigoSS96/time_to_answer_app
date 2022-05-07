class AdminsBackoffice::QuestionsController < AdminsBackofficeController

  before_action :params_permited_update, only: [:update, :create]
  before_action :set_question, only: [:edit, :update]
  before_action :get_subjects, only: [:edit, :new, :create, :update]

  def index
    @questions = Question.includes(:subject).order(:description).page(params[:page])
  end


  def new
    @question = Question.new
  end


  def create  
    @question = Question.new(params_permited_update)
    
    if @question.save
      redirect_to admins_backoffice_questions_path, notice: "Pergunta Cadastrada com Sucesso"  
    else
      render :new
    end
  end
    

  def edit
  end


  def update
    if @question.update(params_permited_update)
      redirect_to admins_backoffice_questions_path, notice: "Pergunta Atualizada com Sucesso"  
    else
      render :edit
    end
  end

  def destroy
    question = Question.find(params[:id])
    if question.destroy
      redirect_to admins_backoffice_questions_path, notice: "Pergunta excluída com Sucesso"
    else
      render :index
    end
  end

  private

    def set_question
      @question = Question.find(params[:id])
    end

    def params_permited_update
      params.require(:question).permit(
        :description, 
        :subject_id, 
        answers_attributes: [:id, :description, :correct, :_destroy]
      )
    end

    def get_subjects
      @subjects = Subject.all
    end
end
