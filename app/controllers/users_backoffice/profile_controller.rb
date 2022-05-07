class UsersBackoffice::ProfileController < UsersBackofficeController

  before_action :password_verify, only: :update

  def edit
    #Podemos utilizar o comando build para criar uma instância do objeto em branco
    current_user.build_user_profile if current_user.user_profile.blank?
  end

  def update
    if current_user.update(user_params)
      #Quando salva a alteração de senha, o bypass impede que seja feito o logout da aplicação
      bypass_sign_in(current_user)
      unless user_params[:user_profile_attributes][:avatar]
        redirect_to users_backoffice_profile_path, notice: 'Perfil de Usuário Atualizado com Sucesso'
      end
    else
      render :edit
    end
  end

  private

  def password_verify
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].extract!(:password, :password_confirmation)
    end
  end

  def user_params
    params.require(:user).permit(:first_name,
      :last_name, :email, :password, :password_confirmation,
      user_profile_attributes: [:id, :address, :gender, :birthdate, :avatar]
    )
  end
end
