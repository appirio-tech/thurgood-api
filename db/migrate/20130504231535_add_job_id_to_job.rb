class AddJobIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :job_id, :string
  end
end
