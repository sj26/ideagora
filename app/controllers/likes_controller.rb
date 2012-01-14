class LikesController < InheritedResources::Base
  before_filter :requires_login
  
  def create
    @like = Like.new(:user => current_user, :thought_id => params[:thought_id])
    create! do |success, failure|
      success.html { redirect_to thoughts_path }
      failure.html { redirect_to thoughts_path }
    end
  end
  
  def destroy
  end

end
