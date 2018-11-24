class RenameProjectStatusValues < ActiveRecord::Migration
  def change
    execute %{UPDATE projects SET status = CASE status WHEN 'Active' THEN 'active' WHEN 'DONE!' THEN 'done' WHEN 'Canned' THEN 'fail' ELSE 'active' END}
  end
end
