#
# Cookbook Name:: lab_ntp_cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

region = node[:ntp][:region]

package "ntp" do
	action :upgrade
end

template "/etc/ntp.conf" do
	source "ntp.conf.erb"
	owner "root"
	group "root"
	mode "0644"
	variables ({
		:servers => node[:ntp][region][:servers]
	})
end

service "ntp" do
	action [:enable, :start]
	supports :reload => true
end
