# Encoding: UTF-8
#
# Cookbook:: bd_nxlog
# Resource:: nxlog_config
#
# Copyright:: 2017, Intelligent Digital Services
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

# => Define the Resource Name
resource_name :nxlog_config

# => Define the Resource Properties
property :config, String, name_property: true
property :cookbook, String, required: false
property :source, String, default: lazy { "#{config}.erb" }
property :variables, Hash, default: {}
property :from_template, [FalseClass, TrueClass], default: lazy { source.end_with?('.erb') ? true : false }
property :path, String, default: lazy { ::File.join(node['nxlog']['conf_dir'], "#{config}.conf") }
property :owner, String, required: false
property :group, String, default: node['nxlog']['group']

# => Define the Resource Default Action
default_action :create

# => Define the Create Action
action :create do
  #
  # => Create a NXLog Config
  #

  # => Deploy the Configuration
  if new_resource.from_template
    template "Deploy NXLog Config (#{new_resource.path})" do
      cookbook  new_resource.cookbook
      source    new_resource.source
      path      new_resource.path
      variables new_resource.variables
      owner     new_resource.owner
      group     new_resource.group
      mode '0640'
      action :create
    end
  else
    cookbook_file "Deploy NXLog Config (#{new_resource.path})" do
      cookbook  new_resource.cookbook
      source    new_resource.source
      path      new_resource.path
      owner     new_resource.owner
      group     new_resource.group
      mode '0640'
      action :create
    end
  end
end

# => Define the Remove Action
action :remove do
  #
  # => Remove a NXLog Config
  #

  file "Remove NXLog Config (#{new_resource.path})" do
    path new_resource.path
    action :delete
  end
end
