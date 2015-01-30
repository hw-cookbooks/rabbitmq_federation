default['rabbitmq_federation']['sensu']['search'] = 'recipes:sensu\:\:rabbitmq'
default['rabbitmq_federation']['sensu']['environment_aware'] = false
default['rabbitmq_federation']['sensu']['pattern'] = '^(?!amq\.|results$|keepalives$)' # '^(results|keepalives)$'
