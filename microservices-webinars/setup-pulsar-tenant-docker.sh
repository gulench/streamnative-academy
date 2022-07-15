docker exec -it pulsar /pulsar/bin/pulsar-admin tenants create orders
docker exec -it pulsar /pulsar/bin/pulsar-admin namespaces create orders/inbound
docker exec -it pulsar /pulsar/bin/pulsar-admin namespaces create orders/validation
docker exec -it pulsar /pulsar/bin/pulsar-admin namespaces create orders/outbound

docker exec -it pulsar /pulsar/bin/pulsar-admin topics create persistent://orders/inbound/food-orders
docker exec -it pulsar /pulsar/bin/pulsar-admin topics create persistent://orders/validation/geo-encoder
docker exec -it pulsar /pulsar/bin/pulsar-admin topics create persistent://orders/validation/payments
docker exec -it pulsar /pulsar/bin/pulsar-admin topics create persistent://orders/validation/restaurants
docker exec -it pulsar /pulsar/bin/pulsar-admin topics create persistent://orders/validation/aggregated-orders
docker exec -it pulsar /pulsar/bin/pulsar-admin topics create persistent://orders/outbound/orders-accepted
docker exec -it pulsar /pulsar/bin/pulsar-admin topics create persistent://orders/outbound/orders-declined
