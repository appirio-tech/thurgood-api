class AddPapertrailAccountIdToLoggerSystem < ActiveRecord::Migration
  def change
    add_column :logger_systems, :papertrail_account_id, :string
  end
end
