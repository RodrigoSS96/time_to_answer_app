module UsersBackofficeHelper
  def avatar_url(user)
    avatar = user.user_profile.avatar
    avatar.attached? ? avatar : 'img.jpg'
  end
end
