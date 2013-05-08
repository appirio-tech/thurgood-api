class AddLoggerAccountIdToLoggerSystem < ActiveRecord::Migration
  def change
    add_column :logger_systems, :logger_account_id, :integer
  end
end
