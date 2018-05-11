# Use this file to easily define all of your cron jobs.
# http://en.wikipedia.org/wiki/Cron
# http://github.com/javan/whenever
set :output, "log/cronlog.log"
set :environment, :production

every 6.hours do
  # do some routine jobs
  # e.g.)
  #   command "/usr/bin/some_great_command"
  #   runner "MyModel.some_method"
  #   rake "some:great:rake:task"
end
