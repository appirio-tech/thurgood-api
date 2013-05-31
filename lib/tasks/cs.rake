desc "Sweeper to release all servers"
task :release_all_servers => :environment do
  Server.all.each { |s| s.release }
end