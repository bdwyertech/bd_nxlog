# Encoding: UTF-8
# Resource Test

include_recipe 'bd_nxlog::default'

nxlog_config 'dummy_template'

nxlog_config 'test_other_config' do
  source 'dummy_template.erb'
end

nxlog_config 'default' do
  source 'default.conf'
end
