class NoticesController < AuthenticatedController
  before_filter :requires_organiser, :except => [:index, :show]
  
  def create
    @notice = Notice.new(params[:notice])
    @notice.user = current_user
    @notice.camp = Camp.current
    create! { notices_path }
  end
  
  def update
    update! { notices_path }
  end
end
