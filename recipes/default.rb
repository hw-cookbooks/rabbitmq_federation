#
# Cookbook Name:: rabbitmq_federation
# Recipe:: default
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

# Be sure to install, configure, and start RabbitMQ prior to using
# this recipe. We're going to enable the Federation plugin and
# configure federation using the federation LWRP that this cookbook
# provides, using cookbook attributes for the resource.
rabbitmq_plugin 'rabbitmq_federation'

# rabbitmqctl set_parameter federation-upstream my-upstream \
# '{"uri":"amqp://server-name","expires":3600000}'
#
#  rabbitmqctl set_policy --apply-to exchanges federate-me "^amq\." \
# '{"federation-upstream-set":"all"}'
#
# rabbitmqctl set_parameter federation-upstream-set name \
# '[json-object, json-object, ...]'
#
upstream = node['rabbitmq_federation']['upstream']

rabbitmq_federation upstream['name'] do
  set upstream['set']
  uri upstream['uri']
  vhost upstream['vhost']
  expires upstream['expires']
end
