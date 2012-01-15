module UsersHelper
  def get_gravatar(user, size) #you can request an image size between 1px - 512px.
    email_md5 = Digest::MD5.hexdigest(user.email).to_s
    url = "http://www.gravatar.com/avatar/" + email_md5 + ".jpg?s=" + size.to_s
  end
  
  def user_avatar(user, size = 50)
    if user.avatar.present?
      image_tag(user.avatar, :title => user.full_name, :alt => user.first_name, :class => "avatar", :width => size, :height => size)
    else
      image_tag(get_gravatar(user, size), :title => user.full_name, :alt => user.first_name, :class => "avatar", :width => size, :height => size)
    end
  end
end
