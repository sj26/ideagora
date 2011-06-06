class CampsController < ApplicationController
  def message_board
    @notices = Camp.current.notices
  end
end
