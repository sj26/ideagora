module ProjectsHelper
  def smart_description(project)
    raw truncate_html(textilize(project.description), length: 100)
  end
  
  def is_owner?(project)
    project && current_user && current_user == project.owner
  end
end
