class AddDefaultToProjectStatus < ActiveRecord::Migration
  def change
    change_column_default :projects, :status, :active
  end
end
