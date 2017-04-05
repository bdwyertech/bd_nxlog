# bd_nxlog

[![Cookbook](http://img.shields.io/cookbook/v/bd_nxlog.svg)][cookbook]
[![Build Status](http://img.shields.io/travis/bdwyertech/bd_nxlog.svg)][travis]
[![Gitter](https://img.shields.io/badge/Gitter-bdwyertech%2Fbd_nxlog-brightgreen.svg)][gitter]
[![GitHub license](https://img.shields.io/badge/license-apachev2-blue.svg)][license]

[cookbook]: https://supermarket.chef.io/cookbooks/bd_nxlog
[travis]: http://travis-ci.org/bdwyertech/bd_nxlog
[gitter]: https://gitter.im/bdwyertech/bd_nxlog
[license]: https://raw.githubusercontent.com/bdwyertech/bd_nxlog/master/LICENSE

## Background
This is a cookbook to deploy NXLog Community Edition.

Rather than attempt to cover every corner case, this cookbook simply provides a resource to deploy configurations, which you can with your own templates and logic.

## Supported Platforms
  * CentOS 7
  * Ubuntu 12.04
  * Ubuntu 16.04

## Recipes
### bd_nxlog::default
  * Installs NXLog and starts/enables the service

## Resources

### nxlog_config

Supported Actions: `:create`, `:remove`

```ruby
# => From Template
nxlog_config 'syslog_forwarder' do
  source 'syslog_forwarder.conf.erb'
  variables server: 1.2.3.4
  action :create
end

# => From Cookbook File
nxlog_config 'syslog_forwarder' do
  source 'syslog_forwarder.conf'
  action :create
end

# => Delete a Config
nxlog_config 'deprecated_config' do
  action :remove
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bdwyertech/bd_nxlog.  Please use the [Gitter Chat](https://gitter.im/bdwyertech/bd_nxlog) instead of filing an issue for questions.  This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

This cookbook is available as open source under the terms of the [Apache 2.0 License](https://opensource.org/licenses/Apache-2.0).

## Authors

Author:: Brian Dwyer - Intelligent Digital Services
