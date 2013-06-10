desc "Sweeper to release all servers"
task :release_all_servers => :environment do
  Server.all.each { |s| s.release }
end

desc "Check to see if the Papertrail API is working properly"
task :check_papertrail => :environment do
  Papertrail.check_me
end