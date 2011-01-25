#
# Cookbook Name:: crontab_mailto
# Recipe:: default
#
execute "cron-MAILTO" do
  command "crontab -u #{node[:owner_name]} -l; if [ $? -eq 0 ] ; then (echo 'MAILTO=""'; crontab -u #{node[:owner_name]} -l) | uniq | crontab -u #{node[:owner_name]} - ; fi"
end
