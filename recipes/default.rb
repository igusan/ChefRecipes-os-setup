#
# Cookbook Name:: os-setup
# Recipe:: default
#
# Copyright 2013, igusan
#
# All rights reserved
#
current_user = node["current_user"]
current_dir = node["etc"]["passwd"][current_user]["dir"]

template "/etc/sysconfig/i18n" do
	source "i18n.erb"
	owner "root"
	group "root"
	mode "0644"
end

package "iptables" do
	action :install
end

template "/etc/sysconfig/iptables" do
	source "iptables.erb"
	owner "root"
	group "root"
	mode "0600"
end
package "logwatch" do
	action :install
end

package "vim" do
	action :install
end

template "#{current_dir}/.vimrc" do
	source "vimrc.erb"
	owner "#{current_user}"
	group "#{current_user}"
	mode "0646"
end
directory "#{current_dir}/vim" do
	owner "#{current_user}"
	group "#{current_user}"
	mode "0755"
	action :create
end

%w{.vimbackup .vimswap}.each do | directory_name|
	directory "#{current_dir}/vim/#{directory_name}" do
		owner "#{current_user}"
		group "#{current_user}"
		mode "0755"
		action :create
	end
end


directory "/etc/skel/" do
	owner "root"
	group "root"
	mode "0755"
	action :create
end


template "/etc/skel/.vimrc" do
	source "vimrc.erb"
	owner "root"
	group "root"
	mode "0646"
end

directory "/etc/skel/vim" do
	owner "root"
	group "root"
	mode "0755"
	action :create
end

%w{.vimbackup .vimswap}.each do | directory_name|
	directory "/etc/skel/vim/#{directory_name}" do
		owner "root"
		group "root"
		mode "0755"
		action :create
	end
end


