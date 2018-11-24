class ProjectsController < InheritedResources::Base
  before_filter :requires_login, :except => [:all, :index, :show]
  before_filter :requires_owner, :only => [:edit, :update, :destroy, :complete, :cancel, :restart]
  
  belongs_to :user
  
  def all
    @projects = Project.all
    render :index
  end
  
  def index
    @projects = parent.projects
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  def new
    @thoughts = Thought.upvoted(1)
    new!
  end
  
  def create
    @thoughts = Thought.upvoted(1)
    @project = Project.new(params[:project])
    @project.owner = current_user
    create! { user_path(current_user) }
  end
  
  def update
    update! { user_path(current_user) }
  end
  
  def restart
    if @project.restart
      redirect_to user_project_path(@project.owner, @project)
    else
      flash[:error] = "Could not restart the project, sorry!"
    end
  end
  
  def complete
    if @project.complete
      redirect_to user_project_path(@project.owner, @project)
    else
      flash[:error] = "Could not complete the project, sorry!"
    end
  end
  
  def cancel
    if @project.cancel
      redirect_to user_project_path(@project.owner, @project)
    else
      flash[:error] = "Could not cancel the project, sorry!"
    end
  end
  
private
  def requires_owner
    unless is_owner?
      redirect_to :back
      flash[:alert] = 'You cannot edit projects that are not yours'
    end
  end
  
  def is_owner?
    resource.owner == current_user
  end
  helper_method :is_owner?
end
