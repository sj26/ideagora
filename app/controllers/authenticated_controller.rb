class AuthenticatedController < InheritedResources::Base
  before_filter :requires_login, :except => [:index, :show]
end