#
# Copyright 2012-2016, Noah Kantrowitz
# Copyright 2016, Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef'
require 'chef/handler'
require 'raven'

# A handler which uses the Raven gem to report errors to Sentry.
# @see https://docs.chef.io/resource_chef_handler.html
# @since 1.0
class Chef::Handler::Sentry < Chef::Handler
  def initialize(options = {})
    Raven.configure do |config|
      config.logger = Chef::Log
      config.dsn = options[:dsn]
      config.ssl_verification = options[:ssl_verify]
      config.current_environment = options[:environment]
      config.environments = [options[:environment]]
      config.send_modules = Gem::Specification.respond_to?(:map)
    end

    if options[:dsn]
      Raven.logger.debug 'Raven ready to reports errors to Sentry'
    else
      Raven.logger.warn "node['sentry']['options']['dsn'] is not set! Raven will not send errors to Sentry!"
    end
  end

  def report
    return if success?
    event = if exception
              Raven::Event.capture_exception(exception)
            else
              Raven::Event.new do |e|
                e.message = 'Unknown fatal error during Chef run'
                e.level = :fatal
              end
            end
    event.server_name = node.name
    event.release = node['policy_revision'] if node['policy_revision']
    event.timestamp = run_status.start_time
    event.time_spent = run_status.elapsed_time
    event.extra = { run_id: run_status.run_id }.tap do |h|
      h[:policy_name] = node.policy_name if node.policy_name
      h[:policy_group] = node.policy_group if node.policy_group
      h[:policy_revision] = node['policy_revision'] if node['policy_revision']
    end
    Raven.send(event)
  end
end
