require 'pp'
#
# Cookbook Name:: scoutapp
# Recipe:: default
#

# be sure to replace "app_name" with the name of your application.
if ['solo', 'app', 'app_master'].include?(node[:instance_role])
  run_for_app(node[:application_name]) do |app_name, data|
    cron "scout" do
      minute   '*'
      hour     '*'
      day      '*'
      month    '*'
      weekday  '*'
      command  "scout d93351dc-019e-4b53-a4b9-e99653f02b66 "
    end  
  end
end
