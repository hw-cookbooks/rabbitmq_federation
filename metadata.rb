name             'rabbitmq_federation'
maintainer       'Heavy Water Operations, LLC.'
maintainer_email 'support@hw-ops.com'
license          'Apache 2.0'
description      'Configures RabbitMQ Federation'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'rabbitmq', '>= 3.9.0'

suggests 'discovery'
suggests 'sensu', '>= 2.5.0'
