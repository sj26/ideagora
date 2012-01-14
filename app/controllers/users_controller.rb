class UsersController < AuthenticatedController
  actions :index, :update
  helper :projects

  def show
    @user = User.find(params[:id])
    render :me if @user == current_user
  end

  def edit
    @user = current_user
    @skills_tags_json = User.tag_counts_on(:skills).to_json
    @interests_tags_json = User.tag_counts_on(:interests).to_json
  end

  def update
    update! { my_profile_path }
  end
end
