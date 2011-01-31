execute "testing" do
  command %Q{
    echo "i ran at #{Time.now}" >> /root/cheftime
  }
end

execute "restart-mysql" do
  command "/etc/init.d/mysql restart"
  action :nothing
end

execute "set timezone to utc" do
  command "ln -nsf /usr/share/zoneinfo/UTC /etc/localtime"
  not_if "ls -la /etc/localtime | grep -q UTC"
  action :run

  if ['solo', 'db_master', 'db'].include?(node[:instance_role])
    notifies :run, resources(:execute => 'restart-mysql'), :delayed
  end
end

# uncomment if you want to run couchdb recipe
# require_recipe "couchdb"

# uncomment to turn use the MBARI ruby patches for decreased memory usage and better thread/continuationi performance
# require_recipe "mbari-ruby"

# uncomment to turn on thinking sphinx 
require_recipe "thinking_sphinx"
require_recipe "delayed_job"
require_recipe "email_reply_process"
require_recipe "ssmtp"
require_recipe "queued_messaging_system"
require_recipe "crontab_mailto"
require_recipe "scoutapp" if node[:environment][:framework_env] == 'production'

if %w( db_master ).include?(node[:instance_role])
  file '/etc/.mysql.backups.yml' do
    group 'deploy'
    mode '660'
  end
end

if ['solo', 'app', 'app_master'].include?(node[:instance_role])
  execute "ensure proper db encoding in config file" do
    cwd "/data/ShotRunner/current"
    environment "RAILS_ENV" => node[:environment][:framework_env]
    command "rake db:add_encoding"
    user 'deploy'
    action :run
  end

  file "/data/ShotRunner/current/tmp/restart.txt" do
    action :touch
  end
end

# uncomment to turn on ultrasphinx 
# require_recipe "ultrasphinx"

#uncomment to turn on memcached
# require_recipe "memcached"

#uncomment to run the authorized_keys recipe
#require_recipe "authorized_keys"

#uncomment to run the eybackup_slave recipe
#require_recipe "eybackup_slave"
