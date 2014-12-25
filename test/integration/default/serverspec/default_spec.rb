require 'spec_helper'

describe 'chef-sentry-handler::default' do
  describe file('/tmp/kitchen/handlers') do
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end

  describe file('/tmp/kitchen/handlers/sentry.rb') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end

  describe file('/opt/chef/embedded/lib/ruby/gems/' \
    '1.9.1/gems/uuidtools-2.1.5') do
    it { should be_directory }
  end

  describe file('/opt/chef/embedded/lib/ruby/gems/' \
    '1.9.1/gems/sentry-raven-0.9.4') do
    it { should be_directory }
  end
end
