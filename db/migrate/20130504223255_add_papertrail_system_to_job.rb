class AddPapertrailSystemToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :papertrail_system, :string
  end
end
