#
# Cookbook:: rabbitmq_federation
# Resource:: default (rabbitmq_federation)
#
# Copyright:: 2015, Heavy Water Operations, LLC.
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

actions :set, :clear
default_action :set

attribute :set, kind_of: String, required: true
attribute :uri, kind_of: [String, Array], required: true
attribute :vhost, kind_of: String
attribute :expires, kind_of: Integer
attribute :apply_to, kind_of: String, equal_to: %w(all queues exchanges), default: 'all'
attribute :pattern, kind_of: String, default: '^amq\.'
