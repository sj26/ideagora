class LikesController < InheritedResources::Base
  before_filter :requires_login
  
  def create
    @like = Like.new(:user => current_user, :thought_id => params[:thought_id])
    create! do |success, failure|
      success.html { redirect_to thoughts_path }
      failure.html {
        flash[:error] = resource.errors.on :thought_id
        redirect_to thoughts_path
      }
    end
  end
  
  def destroy
    @like = Like.find_by_user_id_and_thought_id(current_user.id, params[:thought_id])
    destroy! do |success, failure|
      success.html { redirect_to thoughts_path }
      failure.html {
        flash[:error] = "Hmm, something went wrong!"
        redirect_to thoughts_path
      }
    end
  end

end
