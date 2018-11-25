class NoticesController < AuthenticatedController
  before_action :requires_organiser, :except => [:index, :show]
  
  def create
    @notice = current_user.notices.build(notice_params)
    @notice.camp = current_camp
    create! { notices_path }
  end
  
  def update
    update! { notices_path }
  end

  private

  def notice_params
    params.require(:notice).permit(:title, :content)
  end
end
