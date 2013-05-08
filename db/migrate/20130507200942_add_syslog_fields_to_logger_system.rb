class AddSyslogFieldsToLoggerSystem < ActiveRecord::Migration
  def change
    add_column :logger_systems, :syslog_hostname, :string
    add_column :logger_systems, :syslog_port, :string
  end
end
