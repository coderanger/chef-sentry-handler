Description
===========

Configures and activates an error handler to send run failures to a [Sentry](htt://getsentry.com/) server.

Requirements
============

## Platform

Tested on Ubuntu 12.04 and higher.

## Cookbooks:

Depends on the `chef_handler` cookbook to activate the error handler.

Attributes
==========

* `node['sentry']['dsn']` – **Required** The DSN for your Sentry server.
* `node['sentry']['enabled']` - Boolean to enable/disable the error reporter. Defaults to `true`.

Usage
=====

Simply add the `sentry-handler` recipe to your base role, preferably at the front
of the run list to ensure any subsequent errors are reported, and then set the
DSN in the node attributes.

License and Author
==================

Author:: Noah Kantrowitz (<noah@coderanger.net>)

Copyright:: 2012, Noah Kantrowitz

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
