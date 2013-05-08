class AddAccessKeyToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :access_key, :string
  end
end
