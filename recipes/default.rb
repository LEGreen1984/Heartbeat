include_recipe "apt"

#
apt_update ("update") do
  action :update
end

#this allows us to find the remote file and install it in our tmp folder.
remote_file "/tmp/heartbeat-5.2.2-amd64.deb" do
  source "https://artifacts.elastic.co/downloads/beats/heartbeat/heartbeat-5.2.2-amd64.deb"
  action :create
end

#this uses dpkg to install heartbeat
dpkg_package "heartbeat" do
  source "/tmp/heartbeat-5.2.2-amd64.deb"
  action :install
end
#This deletes the original original heartbeat yml.
file '/etc/heartbeat/heartbeat.yml' do
  action :delete
end

#This replaces the yaml file in the default location with our onw in templates.
template "/etc/heartbeat/heartbeat.yml" do
  source "heartbeat.yml"
  notifies :restart, "service[heartbeat]"
end

#This enables the service heartbeat.
service "heartbeat" do
  action :enable
end

#This runs heartbeat from the below file location.
bash "heartbeat_start" do
  code "sudo /etc/init.d/heartbeat start"
end

service "heartbeat" do
  action :start
end







#
# Cookbook:: heartbeat
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
