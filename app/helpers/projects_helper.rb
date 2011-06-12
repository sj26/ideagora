module ProjectsHelper
  def smart_description(project)
    truncate(textilize(project.try(:description)), :length => 100).try(:html_safe)
  end
end
