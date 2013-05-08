class RemoveAccountIdFromLoggerSystem < ActiveRecord::Migration
  def up
    remove_column :logger_systems, :account_id
  end

  def down
    add_column :logger_systems, :account_id, :string
  end
end
