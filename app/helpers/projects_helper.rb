module ProjectsHelper
  def smart_description(project)
    truncate(textilize(project.try(:description)), :length => 100).try(:html_safe)
  end
  
  def is_owner?(project)
    project && current_user && current_user == project.owner
  end
end
