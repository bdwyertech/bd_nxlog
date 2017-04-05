name 'bd_nxlog'
maintainer 'Brian Dwyer - Intelligent Digital Services'
maintainer_email 'bd@bdwyertech.net'
license 'apachev2'
description 'Installs/Configures bd_nxlog'
long_description 'Installs/Configures bd_nxlog'
version '0.1.1'

issues_url 'https://github.com/bdwyertech/bd_nxlog/issues' if respond_to?(:issues_url)
source_url 'https://github.com/bdwyertech/bd_nxlog' if respond_to?(:source_url)

# => Supported Chef Versions
chef_version '>= 11'

# => Supported Platforms
supports 'centos'
supports 'ubuntu'

# => Dependencies
depends 'apt'
depends 'logrotate'
