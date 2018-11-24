module ApplicationHelper
  def textilize(text)
    raw RedCloth.new(text).to_html
  end
end
