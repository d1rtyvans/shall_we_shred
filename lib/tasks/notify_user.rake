require "shred_client"

namespace :shred_client do
  desc "Requests 7 day weather forecast, runs shredability algorythm and notifies user"
  task :notify_user do
    ShredClient.notify_user
    puts "User has been notified."
  end
end
