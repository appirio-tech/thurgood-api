class RemoveJobIdFromJob < ActiveRecord::Migration
  def up
    remove_column :jobs, :jobId
  end

  def down
    add_column :jobs, :jobId, :string
  end
end
