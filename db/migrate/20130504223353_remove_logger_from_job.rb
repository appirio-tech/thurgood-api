class RemoveLoggerFromJob < ActiveRecord::Migration
  def up
    remove_column :jobs, :logger
  end

  def down
    add_column :jobs, :logger, :string
  end
end
