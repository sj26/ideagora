class DiscussionsController < AuthenticatedController

  def update
    update! { @discussion.path }
  end
end
