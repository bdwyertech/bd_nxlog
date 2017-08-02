# Encoding: UTF-8

# => Sources
case node['platform_family']
when 'rhel'
  case node['platform_version'].to_i
  when 5, 6
    # => NXLog Source (CentOS/RHEL 5 & 6)
    default['nxlog']['url'] = 'http://nxlog.co/system/files/products/files/348/nxlog-ce-2.9.1716-1_rhel6.x86_64.rpm'
    default['nxlog']['checksum'] = 'dc8e02ad9cf4df79d0afecc68a8e419b469e0b5d7c2d37a7115eb0670dbcf9f3'
  when 7
    # => NXLog Source (CentOS/RHEL 7)
    default['nxlog']['url'] = 'http://nxlog.co/system/files/products/files/348/nxlog-ce-2.9.1716-1_rhel7.x86_64.rpm'
    default['nxlog']['checksum'] = 'b79455042b31802fc8a77332995a36cf58244446ba7d4edbff2b046c5d89738e'
  end
when 'debian'
  case node['platform_version']
  when '12.04'
    default['nxlog']['url'] = 'http://nxlog.co/system/files/products/files/348/nxlog-ce_2.9.1716_ubuntu_1204_amd64.deb'
    default['nxlog']['checksum'] = 'eb53da18970bc1336dcdcb5fe51a46f5845fa6c52031b73e5eab04207cdd9808'
  when '16.04'
    default['nxlog']['url'] = 'http://nxlog.co/system/files/products/files/348/nxlog-ce_2.9.1716_ubuntu_1604_amd64.deb'
    default['nxlog']['checksum'] = '1820511ae580d87f91a43ec0a7482c6b2f639ad4a825448f7f904616561a706b'
  end
end

#
# => NXLog Settings
#
default['nxlog'].tap do |nxlog|
  # => Enable/Disable NXLog
  nxlog['enabled']   = true

  nxlog['user']      = 'nxlog'
  nxlog['group']     = 'nxlog'

  nxlog['log_level'] = 'INFO'
  nxlog['log_file']  = '/var/log/nxlog/nxlog.log'

  nxlog['config']   = '/etc/nxlog/nxlog.conf'
  nxlog['conf_dir'] = '/etc/nxlog/conf.d'
  nxlog['ssl_dir']  = '/etc/nxlog/ssl'

  # => Groups to add NXLog to (key = Name, value = Description)
  # nxlog['groups']['adm'] = 'Typical Group for Reading Logs'
  nxlog['groups'] = {}
end
