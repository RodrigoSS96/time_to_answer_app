module UsersBackoffice::ProfileHelper
  def gender_select(user, gender)
    user.user_profile.gender == gender ? 'btn-primary' : 'btn-default'
  end
end
