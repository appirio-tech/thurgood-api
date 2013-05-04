class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.string :installed_services
      t.string :instance_url
      t.string :operating_system
      t.string :password
      t.string :platform
      t.string :repo_name
      t.string :status
      t.string :languages
      t.string :username

      t.timestamps
    end
  end
end
