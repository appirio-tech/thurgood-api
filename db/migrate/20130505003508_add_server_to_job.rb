class AddServerToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :server_id, :string
  end
end
