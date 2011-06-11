class StatusesController < InheritedResources::Base
  before_filter :find_project
  before_filter :requires_login, :requires_owner

  belongs_to :project
  
  def update
    update! { project_path(params[:project]) }
  end

  def active
    status = @project.status || @project.create_status
    status.type = "Active"
    status.save!
    redirect_to @project
  end

  def win
    status = @project.status || @project.create_status
    status.type = "Done"
    status.save!
    redirect_to @project
  end
  
  def fail
    status = @project.status || @project.create_status
    status.type = "Canned"
    status.save!
    redirect_to @project
  end

private
  def find_project
    @project = Project.find(params[:project_id])
  end

  def requires_owner
    unless is_owner?
      redirect_to :back
      flash[:alert] = 'You cannot edit projects that are not yours'
    end
  end
  
  def is_owner?
    @project.owner == current_user
  end
  helper_method :is_owner?

end
