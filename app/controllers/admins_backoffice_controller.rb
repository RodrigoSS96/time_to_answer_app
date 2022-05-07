class AdminsBackofficeController < ActionController::Base
    before_action :authenticate_admin!
    layout = 'admins_backoffice.html.erb'
end
