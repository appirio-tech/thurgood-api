class AddOptionsToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :options, :string
  end
end
