# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'.freeze

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # => Host Name
  config.vm.hostname = 'bd-nxlog'

  # => Base Box
  config.vm.box = 'Ubuntu16.04_x64'
  # config.vm.box = 'CentOS7.3_x64'

  # => Chef Omnibus Updater
  if Vagrant.has_plugin?('vagrant-omnibus')
    config.omnibus.chef_version = '12.19.36' # => :latest
  end

  # => Vagrant HostManager Configuration
  if Vagrant.has_plugin?('vagrant-hostmanager')
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true # => Manages local machine's /etc/hosts
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
  end

  config.vm.provision :chef_solo do |chef|
    chef.json = {}

    chef.add_recipe 'bd_nxlog'
  end

  # => VMware Customization
  %w(vmware_workstation vmware_fusion).each do |platform|
    config.vm.provider platform do |v|
      v.vmx['memsize'] = 2048
      v.vmx['numvcpus'] = 2
      v.vmx['vhv.enable'] = true
      v.gui = false
    end
  end
end
