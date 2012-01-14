class CampsController < ApplicationController
  def message_board
    @notices = current_camp.notices
  end
end
