module ApplicationHelper
  def flash_helper
    [:error, :warning, :notice, :message, :alert].collect do |key|
      content_tag(:p, flash[key], :class => key.to_s) unless flash[key].blank?
    end.join
  end
	
	def textilize(text)
    RedCloth.new(text).to_html
  end
  
  def user_avatar(user, size = 50)
    image_tag(get_gravatar(user, size), :title => user.full_name, :class => "avatar")
  end
end
