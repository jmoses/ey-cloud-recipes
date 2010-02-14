require 'pp'
#
# Cookbook Name:: thinking_sphinx
# Recipe:: default
#

if ['solo', 'app', 'app_master'].include?(node[:instance_role])

  # be sure to replace "app_name" with the name of your application.
  run_for_app("ShotRunner") do |app_name, data|
    template "/etc/monit.d/queued_messaging_system.#{app_name}.monitrc" do
      source "queued_messages.monitrc.erb"
      owner node[:owner_name]
      group node[:owner_name]
      mode 0644
      variables({
        :app_name => app_name,
        :user => node[:owner_name]
      })
    end

  end
end
