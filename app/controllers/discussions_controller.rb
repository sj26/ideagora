class DiscussionsController < InheritedResources::Base
  before_filter :requires_login

  def update
    update! { @discussion.path }
  end
end
