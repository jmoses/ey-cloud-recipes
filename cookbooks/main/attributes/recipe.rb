recipes('main')
owner_name(@attribute[:users].first[:username])
owner_pass(@attribute[:users].first[:password])
default[:application_name] = node[:applications].keys.find {|app| app =~ /shotrunner/i}
