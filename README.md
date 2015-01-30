rabbitmq_federation Cookbook
============================
This cookbook provides a Chef LWRP for configuring RabbitMQ
federation, `rabbitmq_federation`. The LWRP enables the RabbitMQ
federation plugin, creates RabbitMQ parameters for a federation link
upstream and its set, and creates a RabbitMQ policy to declare what is
federated and applies it to the upstream set.

This cookbook also provides two recipes to serve as usage examples.
The `default` recipe will configure RabbitMQ federation using several
cookbook attributes. The `sensu` recipe will configure RabbitMQ
federation for Sensu's exchanges, intended to connect regional
RabbitMQ clusters.

Requirements
------------
#### Cookbooks

* [RabbitMQ](https://supermarket.chef.io/cookbooks/rabbitmq)

For the `sensu` recipe (suggested):

* [Discovery](https://supermarket.chef.io/cookbooks/discovery)
* [Sensu](https://supermarket.chef.io/cookbooks/sensu)

Attributes
----------
#### rabbitmq_federation::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['rabbitmq_federation']['upstream']['name']</tt></td>
    <td>String</td>
    <td>RabbitMQ federation upstream name</td>
    <td><tt>'upstream-name'</tt></td>
  </tr>
  <tr>
    <td><tt>['rabbitmq_federation']['upstream']['set']</tt></td>
    <td>String</td>
    <td>RabbitMQ federation upstream set name</td>
    <td><tt>'upstream-set-name'</tt></td>
  </tr>
  <tr>
    <td><tt>['rabbitmq_federation']['upstream']['uri']</tt></td>
    <td>String</td>
    <td>RabbitMQ federation upstream URI</td>
    <td><tt>'amqp://server-name'</tt></td>
  </tr>
  <tr>
    <td><tt>['rabbitmq_federation']['upstream']['vhost']</tt></td>
    <td>String</td>
    <td>RabbitMQ federation upstream vhost</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['rabbitmq_federation']['upstream']['expire']</tt></td>
    <td>String</td>
    <td>RabbitMQ federation queue expiry time (ms)</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['rabbitmq_federation']['policy']['pattern']</tt></td>
    <td>String</td>
    <td>RabbitMQ federation policy pattern</td>
    <td><tt>'^amq\.'</tt></td>
  </tr>
  <tr>
    <td><tt>['rabbitmq_federation']['policy']['apply_to']</tt></td>
    <td>String</td>
    <td>What to apply the RabbitMQ federation policy to</td>
    <td><tt>'exchanges'</tt></td>
  </tr>
</table>

#### rabbitmq_federation::sensu
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['rabbitmq_federation']['sensu']['search']</tt></td>
    <td>String</td>
    <td>Chef search term for RabbitMQ upstreams</td>
    <td><tt>'recipes:sensu\:\:rabbitmq'</tt></td>
  </tr>
  <tr>
    <td><tt>['rabbitmq_federation']['sensu']['environment_aware']</tt></td>
    <td>Boolean</td>
    <td>Scope Chef search to the Chef environment</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['rabbitmq_federation']['sensu']['pattern']</tt></td>
    <td>String</td>
    <td>RabbitMQ federation policy exchange pattern</td>
    <td><tt>'^(?!amq\.|results$|keepalives$)'</tt></td>
  </tr>
</table>

Usage
-----
#### rabbitmq_federation::sensu

By default, the recipe will discover all RabbitMQ nodes (regardless of
Chef environment) that were configured by the `sensu::rabbitmq`
community recipe. The default federation pattern attribute is for
regional RabbitMQ cluster nodes, those that the Sensu clients connect
to, as it federates the Sensu client subscription exchanges. To narrow
the Chef search scope, override
`['rabbitmq_federation']['sensu']['search']` appropriately. To
federate the Sensu client keepalive and check result exchanges,
override `['rabbitmq_federation']['sensu']['search']` to
`'^(results|keepalives)$'`.

Include `rabbitmq_federation::sensu`, after installing and configuring
RabbitMQ with `sensu::rabbitmq`.

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `feature/add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------

Sean Porter <portertech@gmail.com>

TODO
----

* Add support for Sensu RabbitMQ credentials in encrypted data bag
  items.

* Add support for federated exchange max-hops, message-ttl, and ha-policy

* Add support for federation policy priority and ha-mode

* Add support for federated upstream queue naming, currently forced to
  use the same name as the federated queue.
