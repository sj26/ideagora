class ChangeProjectStatusToNonNullable < ActiveRecord::Migration
  def change
    execute "UPDATE projects SET status = 'active' WHERE status IS NULL"
    change_column_null :projects, :status, false
  end
end
