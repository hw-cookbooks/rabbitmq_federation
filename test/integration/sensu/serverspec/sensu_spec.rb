require 'serverspec'
require 'net/http'
require 'uri'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin:/usr/sbin'

describe service('rabbitmq-server') do
  it { should be_enabled }
  it { should be_running }
end

describe command('rabbitmqctl eval "rabbit_federation_status:status()."') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /{upstream_exchange,<<"test">>}/ }
  its(:stdout) { should match /status,running/ }
end
