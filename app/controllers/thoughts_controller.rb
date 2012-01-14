class ThoughtsController < InheritedResources::Base
  before_filter :requires_login, :except => [:index, :show]

  def create
    @thought = Thought.new(params[:thought])
    @thought.user = current_user
    create! do |success, failure|
      success.html {
        flash[:notice] = "Thanks for the food for thought!"
        redirect_to thoughts_path
      }
      failure.html {
        flash[:error] = @thought.errors.on :description
        redirect_to thoughts_path
      }
    end
  end

  def end_of_association_chain
    super.includes(:likes)
  end
end
