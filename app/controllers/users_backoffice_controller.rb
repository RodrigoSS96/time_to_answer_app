class UsersBackofficeController < ActionController::Base
    before_action :authenticate_user!
    before_action :build_profile
    layout = 'users_backoffice.html.erb'

  private

  def build_profile
    current_user.build_user_profile if current_user.user_profile.blank?
  end
end
