class CreateLoggerSystems < ActiveRecord::Migration
  def change
    create_table :logger_systems do |t|
      t.string :name
      t.integer :account_id
      t.string :papertrail_id

      t.timestamps
    end
  end
end
