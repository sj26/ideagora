class AuthenticatedController < InheritedResources::Base
  before_action :requires_login, :except => [:index, :show]
end
