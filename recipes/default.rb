# Encoding: UTF-8
#
# Cookbook:: bd_nxlog
# Recipe:: default
#
# Copyright:: 2017, Brian Dwyer - Intelligent Digital Services
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# => Debian Crap
if platform_family?('debian')
  include_recipe 'apt'

  package %w(libapr1 libdbi1 libcap2)
  package 'libperl5.14' if node['platform_version'] == '12.04'
  package 'libperl5.22' if node['platform_version'] == '16.04'
end

# => Download NXLog Package
nxpkg = remote_file 'NXLog Package' do
  path ::File.join(Chef::Config[:file_cache_path], ::File.basename(node['nxlog']['url']))
  source node['nxlog']['url']
  checksum node['nxlog']['checksum']
  action :create
  notifies :install, 'package[nxlog]', :immediately
end

# => Install NXLog from Package
package 'nxlog' do
  source nxpkg.path
  provider Chef::Provider::Package::Dpkg if platform_family?('debian')
  retries 1 if platform_family?('debian')
  action :nothing
end

# => NXLog Configuration Directory
directory 'NXLog Configuration Directory' do
  path node['nxlog']['conf_dir']
  mode 0755
  recursive true
  action :create
end

# => NXLog Log Directory
directory 'NXLog Log Directory' do
  path ::File.dirname(node['nxlog']['log_file'])
  mode '2750'
  owner node['nxlog']['user']
  group node['nxlog']['group']
  action :create
  only_if { ::File.basename(path) == 'nxlog' }
end

# => NXLog SSL/TLS Directory
directory 'NXLog SSL/TLS Directory' do
  path node['nxlog']['ssl_dir']
  mode 0750
  owner 'root'
  group node['nxlog']['group']
  action :create
end

# => Deploy NXLog Configuration
template 'NXLog Configuration' do
  path node['nxlog']['config']
  source 'nxlog.conf.erb'
  mode 0640
  group node['nxlog']['group']
  action :create
  notifies :restart, 'service[nxlog]', :delayed
end

link '/etc/nxlog.conf' do
  to node['nxlog']['config']
  only_if { platform_family?('rhel') }
end

# => Start NXLog Service
service 'nxlog' do
  action node['nxlog']['enabled'] ? [:enable, :start] : [:disable, :stop]
end

# => Setup Log Rotation
logrotate_app 'nxlog' do
  path node['nxlog']['log_file']
  options %w(compress copytruncate daily dateext missingok notifempty sharedscripts)
  frequency 'daily'
  rotate 60
  create "0640 #{node['nxlog']['user']} #{node['nxlog']['group']}"
end

# => Add NXLog to Groups
node['nxlog']['groups'].each do |k, _v|
  group "Add NXLog to #{k}" do
    group_name k.to_s
    append true
    members [node['nxlog']['user']]
    action :manage
  end
end
