# Chef Handler for Sentry

Installs and configures a [Chef handler][0] for sending errors
to [Sentry][1].

## Requirements

Chef Client 12.1 or above.

## Platforms

This cookbook has been verified to work on the following platforms:

- Ubuntu 14.04/16.04
- RHEL (CentOS) 5/6/7
- AIX 7.1
- Solaris 11
- Windows 2008r2/2012r2

## Usage

All you need to do is set the `node['sentry']['options']['dsn']` value and add
the default recipe of this cookbook to your run-list. You can do this
from a wrapper cookbook recipe:

``` ruby
node.default['sentry']['options']['dsn'] = 'https://xxxx:yyyy@sentry.corporate.com/1'
include_recipe 'chef-sentry-handler::default'
```

[0]: https://docs.chef.io/handlers.html
[1]: https://getsentry.com
