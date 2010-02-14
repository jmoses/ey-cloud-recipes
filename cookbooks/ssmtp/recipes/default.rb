require 'pp'
#
# Cookbook Name:: thinking_sphinx
# Recipe:: default
#

if ['solo', 'app', 'app_master'].include?(node[:instance_role])

  # be sure to replace "app_name" with the name of your application.
  run_for_app("ShotRunner") do |app_name, data|
  
    template "/etc/ssmtp/ssmtp.conf" do
      # Bleck, need fancy sphinx things.
      owner node[:owner_name]
      group node[:owner_name]
      mode 0644
      source "ssmtp.conf.erb"
      variables({
        :app_name => app_name,
        :user => node[:owner_name]
      })
    end
  
  end
end
