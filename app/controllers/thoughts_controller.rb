class ThoughtsController < AuthenticatedController

  def index
    @thoughts = Thought.all
    @voted, @unvoted = @thoughts.partition { |t| t.likes.count > 0 }
    @unvoted.sort_by(&:created_at)
  end

  def create
    @thought = current_user.thoughts.build(thought_params)
    create! do |success, failure|
      success.html {
        flash[:notice] = "Thanks for the food for thought!"
        redirect_to thoughts_path
      }
      failure.html {
        flash[:error] = @thought.errors[:description].join
        redirect_to thoughts_path
      }
    end
  end

  private

  def end_of_association_chain
    super.includes(:likes)
  end

  def thought_params
    params.require(:thought).permit(:description)
  end
end
