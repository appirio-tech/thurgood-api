class AddPapertrailIdToLoggerAccounts < ActiveRecord::Migration
  def change
    add_column :logger_accounts, :papertrail_id, :string
  end
end
