# Chef Handler for Sentry

A [Chef](https://www.chef.io) cookbook that configures and activates
an error handler to send failures to
a [Sentry](https://www.getsentry.com) server.

## Requirements

Chef 12.1 or newer is required.

## Usage

All you need to do is set the `node['sentry']['dsn']` value and add
the default recipe of this cookbook to your run-list. You can do this
from a wrapper cookbook recipe:

``` ruby
node.default['sentry']['dsn'] = 'https://xxxx:yyyy@sentry.corporate.com/1'
include_recipe 'chef-handler-sentry::default'
```

## License

Copyright 2012-2016, Noah Kantrowitz

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
