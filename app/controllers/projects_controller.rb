class ProjectsController < InheritedResources::Base
  before_filter :requires_login, :except => [:all, :index, :show]
  before_filter :requires_owner, :except => [:all, :index, :show, :new, :create]
  
  belongs_to :user
  
  def all
    @projects = Project.all
    render :index
  end
  
  def index
    @projects = parent.projects
  end
  
  def create
    @project = Project.new(params[:project])
    @project.owner = current_user
    create! { user_path(current_user) }
  end
  
  def update
    update! { user_path(current_user) }
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
