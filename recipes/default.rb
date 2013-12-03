# Make sure the handlers folder exists
directory node["chef_handler"]["handler_path"] do
  owner "root"
  group "root"
  mode "755"
  recursive true
  action :nothing
end.run_action(:create)

chef_gem "uuidtools"

chef_gem "sentry-raven" do
  version "0.6.0"
end

handler_file = ::File.join(node["chef_handler"]["handler_path"], 'sentry.rb')

cookbook_file handler_file do
  source "sentry.rb"
  owner "root"
  group "root"
  mode "644"
  action :nothing
end.run_action(:create)

chef_handler "Raven::Chef::SentryHandler" do
  source handler_file
  supports({:exception => true})
  arguments [node]
  action :nothing
end.run_action(node['sentry']['enabled'] ? :enable : :disable)
