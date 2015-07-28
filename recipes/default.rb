#
# Copyright 2012-2016, Noah Kantrowitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'chef_handler::default'

chef_gem 'uuidtools' do
  compile_time true
end

chef_gem 'sentry-raven' do
  version node['sentry']['gem_version']
  compile_time true
end

cookbook_file File.join(node['chef_handler']['handler_path'], 'sentry.rb') do
  action :nothing
  source 'sentry.rb'
  mode '0644'
end.run_action(:create)

chef_handler 'Chef::Handler::Sentry' do
  action :nothing
  source File.join(node['chef_handler']['handler_path'], 'sentry.rb')
  arguments node['sentry']['options']
  supports exception: true, report: true, start: false
end.run_action(:enable)
