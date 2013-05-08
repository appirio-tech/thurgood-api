class AddPapertrailApiTokenToLoggerAccount < ActiveRecord::Migration
  def change
    add_column :logger_accounts, :papertrail_api_token, :string
  end
end
