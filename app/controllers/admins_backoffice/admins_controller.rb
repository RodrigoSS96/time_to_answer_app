class AdminsBackoffice::AdminsController < AdminsBackofficeController

  before_action :password_verify, only: [:update]
  before_action :set_admin_user, only: [:edit, :update, :destroy]
  before_action :params_permited_update, only: [:update]

  def index
    @admins = Admin.all.page(params[:page])
  end

  def new
    @admin = Admin.new
  end


  def create

    @admin = Admin.new(params_permited_update)

    if @admin.save
      redirect_to admins_backoffice_admins_path, notice: "Usuário Cadastrado com Sucesso"
    else
      render :new
    end
  end


  def edit

  end


  def update
    if @admin.update(params_permited_update)
      AdminMailer.update_email(current_admin, @admin).deliver_now
      redirect_to admins_backoffice_admins_path, notice: "Usuário Atualizado com Sucesso"
    else
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "Usuário excluído com Sucesso"
    else
      render :index
    end
  end

  private

    def password_verify
      if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
        params[:admin].extract!(:password, :password_confirmation)
      end
    end


    def set_admin_user
      @admin = Admin.find(params[:id])
    end


    def params_permited_update
      params.require(:admin).permit(:email, :password, :password_confirmation)
    end

end