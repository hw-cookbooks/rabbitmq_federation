#
# Cookbook Name:: rabbitmq_federation
# Provider:: default (rabbitmq_federation)
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

action :set do
  options = {'uri' => new_resource.uri}
  options['expires'] = new_resource.expires if new_resource.expires

  rabbitmq_parameter new_resource.name do
    component 'federation-upstream'
    vhost new_resource.vhost
    params options
  end

  node.run_state['rabbitmq_federation'] ||= {'sets' => {}}

  set_members = [{'upstream' => new_resource.name}] +
    (node.run_state['rabbitmq_federation']['sets'][new_resource.set] || [])
  set_members.uniq!

  node.run_state['rabbitmq_federation']['sets'][new_resource.set] = set_members

  rabbitmq_parameter new_resource.set do
    component 'federation-upstream-set'
    params set_members
  end

  rabbitmq_policy "federate_#{new_resource.name}" do
    vhost new_resource.vhost
    pattern new_resource.pattern
    apply_to new_resource.apply_to
    params 'federation-upstream-set' => new_resource.set
  end
end

action :clear do
end
