class RemoveAccessTokenFromApiKeys < ActiveRecord::Migration
  def up
    remove_column :api_keys, :access_token
  end

  def down
    add_column :api_keys, :access_token, :string
  end
end
