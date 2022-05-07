class AdminsBackoffice::SubjectsController < AdminsBackofficeController
  

  before_action :params_permited_update, only: [:update]
  before_action :set_subject, only: [:edit, :update, :destroy]

  def index
    @subjects = Subject.all.order(:description).page(params[:page])
  end


  def new
    @subject = Subject.new
  end


  def create  
    @subject = Subject.new(params_permited_update)
    
    if @subject.save
      redirect_to admins_backoffice_subjects_path, notice: "Assunto Cadastrado com Sucesso"  
    else
      render :new
    end
  end
    

  def edit
  end


  def update
    if @subject.update(params_permited_update)
      redirect_to admins_backoffice_subjects_path, notice: "Assunto Atualizado com Sucesso"  
    else
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_subjects_path, notice: "Assunto excluído com Sucesso"
    else
      render :index
    end
  end

  private

    def set_subject
      @subject = Subject.find(params[:id])
    end


    def params_permited_update
      params.require(:subject).permit(:description)
    end
end