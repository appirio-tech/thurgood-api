class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :jobId
      t.datetime :starttime
      t.datetime :endtime
      t.string :logger
      t.string :status
      t.string :email
      t.string :platform
      t.string :language

      t.timestamps
    end
  end
end
