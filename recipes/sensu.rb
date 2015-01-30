#
# Cookbook Name:: rabbitmq_federation
# Recipe:: sensu
#
# Copyright 2015, Heavy Water Operations, LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This recipe serves as a LWRP usage example. We discover select
# RabbitMQ nodes that are used for Sensu. The RabbitMQ nodes may be
# RabbitMQ cluster members. This example will only work when using the
# official Sensu Chef cookbook to configure RabbitMQ, and encrypted
# data bag items are NOT being used for the RabbitMQ credentials.
upstream_nodes = Discovery.all(node['rabbitmq_federation']['sensu']['search'],
  :node => node,
  :raw_search => true,
  :minimum_response_time_sec => false,
  :environment_aware => node['rabbitmq_federation']['sensu']['environment_aware'])

upstream_nodes.each do |upstream_node|
  sensu_rabbitmq = upstream_node['sensu']['rabbitmq']

  use_ssl = upstream_node['sensu']['use_ssl']
  rabbitmq_uri = (use_ssl ? 'amqps://' : 'amqp://')

  rabbitmq_uri << [sensu_rabbitmq['user'], sensu_rabbitmq['password']].join(':')
  rabbitmq_uri << '@'

  address = Discovery.ipaddress(:remote_node => upstream_node, :node => node)
  port = sensu_rabbitmq['port']
  rabbitmq_uri << [address, port].join(':')

  if sensu_rabbitmq['vhost']
    rabbitmq_uri << ('/' + sensu_rabbitmq['vhost'].gsub(/\//, '%2F'))
  end

  if use_ssl
    rabbitmq_uri << '?certfile=/etc/rabbitmq/ssl/client/cert.pem&'
    rabbitmq_uri << 'keyfile=/etc/rabbitmq/ssl/client/key.pem'
  end

  rabbitmq_federation "sensu-upstream-#{upstream_node.name}" do
    set 'sensu-upstreams'
    uri rabbitmq_uri
    vhost sensu_rabbitmq['vhost']
    apply_to 'exchanges'
    pattern node['rabbitmq_federation']['sensu']['pattern']
  end
end
