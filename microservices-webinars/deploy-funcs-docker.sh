docker exec -it pulsar /pulsar/bin/pulsar-admin functions create \
 --function-config-file function_config/validation_func_config.yaml \
 --jar myjars/workshop.jar

docker exec -it pulsar /pulsar/bin/pulsar-admin functions create \
 --function-config-file function_config/geo_func_config.yaml \
--jar myjars/workshop.jar

docker exec -it pulsar /pulsar/bin/pulsar-admin functions create \
 --function-config-file function_config/payments_func_config.yaml \
--jar myjars/workshop.jar

docker exec -it pulsar /pulsar/bin/pulsar-admin functions create \
 --function-config-file function_config/restaurants_func_config.yaml \
--jar myjars/workshop.jar

docker exec -it pulsar /pulsar/bin/pulsar-admin functions create \
 --function-config-file function_config/aggregation_func_config.yaml \
--jar myjars/workshop.jar

docker exec -it pulsar /pulsar/bin/pulsar-admin source create \
  --source-config-file function_config/food_orders_source_config.yaml \
  --archive myjars/workshop.jar
