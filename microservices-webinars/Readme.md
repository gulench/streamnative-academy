High Level Microservices Architecture
-------------------------------------
![Alt text](../images/microservices_arch.png "Microservices Architecture")

Create Logical Components
-------------------------
1. Run Pulsar Standalone
```
docker run -it \
  -p 6650:6650 \
  -p 8080:8080 \
  -p 4181:4181 \
  --name pulsar \
  apachepulsar/pulsar:2.10.1 \
  bin/pulsar standalone
```

2. Create tenants and namespaces
```
/pulsar/bin/pulsar-admin tenants create orders
/pulsar/bin/pulsar-admin namespaces create orders/inbound
/pulsar/bin/pulsar-admin namespaces create orders/validation
/pulsar/bin/pulsar-admin namespaces create orders/outbound
```

3. Create topics
```
/pulsar/bin/pulsar-admin topics create persistent://orders/inbound/food-orders
/pulsar/bin/pulsar-admin topics create persistent://orders/validation/geo-encoder
/pulsar/bin/pulsar-admin topics create persistent://orders/validation/payments
/pulsar/bin/pulsar-admin topics create persistent://orders/validation/restaurants
/pulsar/bin/pulsar-admin topics create persistent://orders/validation/aggregated-orders
/pulsar/bin/pulsar-admin topics create persistent://orders/outbound/orders-accepted
/pulsar/bin/pulsar-admin topics create persistent://orders/outbound/orders-declined
```

4. Verify creation
```
/pulsar/bin/pulsar-admin topics list orders/inbound
/pulsar/bin/pulsar-admin topics list orders/validation
/pulsar/bin/pulsar-admin topics list orders/outbound
```

5. Deploy the Validation function
```
/pulsar/bin/pulsar-admin functions create \
 --function-config-file function_config/validation_func_config.yaml \
 --jar myjars/workshop.jar
```

6.Deploy the Geo function
```
/pulsar/bin/pulsar-admin functions create \
 --function-config-file function_config/geo_func_config.yaml \
--jar myjars/workshop.jar
```

7.Deploy the Payments function
```
/pulsar/bin/pulsar-admin functions create \
 --function-config-file function_config/payments_func_config.yaml \
--jar myjars/workshop.jar
```

8.Deploy the Restaurant function
```
/pulsar/bin/pulsar-admin functions create \
 --function-config-file function_config/restaurants_func_config.yaml \
--jar myjars/workshop.jar
```

9.Deploy the Aggregation function
```
/pulsar/bin/pulsar-admin functions create \
 --function-config-file function_config/aggregation_func_config.yaml \
--jar myjars/workshop.jar
```

9.Deploy the Food Order Source
```
/pulsar/bin/pulsar-admin source create \
  --source-config-file function_config/food_orders_source_config.yaml \
  --archive myjars/workshop.jar
```


11.Get Functions Configurations
```
/pulsar/bin/pulsar-admin functions get --name order-validation-func
/pulsar/bin/pulsar-admin functions get --name geo-encoder-func
/pulsar/bin/pulsar-admin functions get --name payments-func
/pulsar/bin/pulsar-admin functions get --name restaurants-func
/pulsar/bin/pulsar-admin functions get --name order-aggregation-func
```

12.Get Functions Status
```
/pulsar/bin/pulsar-admin functions status --name order-validation-func
/pulsar/bin/pulsar-admin functions status --name geo-encoder-func
/pulsar/bin/pulsar-admin functions status --name payments-func
/pulsar/bin/pulsar-admin functions status --name restaurants-func
/pulsar/bin/pulsar-admin functions status --name order-aggregation-func
```

13.Get Functions Stats
```
/pulsar/bin/pulsar-admin functions stats --name order-validation-func
/pulsar/bin/pulsar-admin functions stats --name geo-encoder-func
/pulsar/bin/pulsar-admin functions stats --name payments-func
/pulsar/bin/pulsar-admin functions stats --name restaurants-func
/pulsar/bin/pulsar-admin functions stats --name order-aggregation-func
```

14.Delete Functions
```
/pulsar/bin/pulsar-admin functions delete --name order-validation-func
/pulsar/bin/pulsar-admin functions delete --name geo-encoder-func
/pulsar/bin/pulsar-admin functions delete --name payments-func
/pulsar/bin/pulsar-admin functions delete --name restaurants-func
/pulsar/bin/pulsar-admin functions delete --name order-aggregation-func
```

15.Delete Source
```
/pulsar/bin/pulsar-admin source delete --name food-orders-source
```

16.Check topics stats
```
/pulsar/bin/pulsar-admin topics stats persistent://orders/inbound/food-orders
/pulsar/bin/pulsar-admin topics stats-internal persistent://orders/inbound/food-orders

/pulsar/bin/pulsar-admin topics stats persistent://orders/validation/geo-encoder
/pulsar/bin/pulsar-admin topics stats-internal persistent://orders/validation/geo-encoder

/pulsar/bin/pulsar-admin topics stats persistent://orders/validation/payments
/pulsar/bin/pulsar-admin topics stats-internal persistent://orders/validation/payments

/pulsar/bin/pulsar-admin topics stats persistent://orders/validation/restaurants
/pulsar/bin/pulsar-admin topics stats-internal persistent://orders/validation/restaurants

/pulsar/bin/pulsar-admin topics stats persistent://orders/validation/aggregated-orders
/pulsar/bin/pulsar-admin topics stats-internal persistent://orders/validation/aggregated-orders

/pulsar/bin/pulsar-admin topics stats persistent://orders/outbound/food-orders
/pulsar/bin/pulsar-admin topics stats-internal persistent://orders/outbound/food-orders

/pulsar/bin/pulsar-admin topics stats persistent://orders/outbound/orders-accepted
/pulsar/bin/pulsar-admin topics stats-internal persistent://orders/outbound/orders-accepted

/pulsar/bin/pulsar-admin topics stats persistent://orders/outbound/orders-declined
/pulsar/bin/pulsar-admin topics stats-internal persistent://orders/outbound/orders-declined
```

## Consumers

Run inside the `pulsar` container:

java -cp myjars/workshop.jar sn.academy.food_delivery.consumers.DeclinedOrdersConsumer

java -cp myjars/workshop.jar sn.academy.food_delivery.consumers.AcceptedOrdersConsumer
