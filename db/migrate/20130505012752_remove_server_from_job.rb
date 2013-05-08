class RemoveServerFromJob < ActiveRecord::Migration
  def up
    remove_column :jobs, :server_id
  end

  def down
    add_column :jobs, :server_id, :string
  end
end
