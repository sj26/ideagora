module ApplicationHelper
  def flash_helper
    [:error, :warning, :notice, :message, :alert].collect do |key|
      content_tag(:p, flash[key], :class => ["flash", key.to_s]) unless flash[key].blank?
    end.join
  end
	
  def textilize(text)
    RedCloth.new(text).to_html
  end
end
