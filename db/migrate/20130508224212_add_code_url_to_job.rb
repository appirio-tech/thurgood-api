class AddCodeUrlToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :code_url, :string
  end
end
