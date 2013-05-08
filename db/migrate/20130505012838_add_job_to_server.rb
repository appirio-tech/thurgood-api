class AddJobToServer < ActiveRecord::Migration
  def change
    add_column :servers, :job_id, :string
  end
end
