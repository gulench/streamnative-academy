echo "Deleting Functions and Sources"
docker exec -it pulsar /pulsar/bin/pulsar-admin source delete --name food-orders-source

docker exec -it pulsar /pulsar/bin/pulsar-admin functions delete --name order-validation-func
docker exec -it pulsar /pulsar/bin/pulsar-admin functions delete --name geo-encoder-func
docker exec -it pulsar /pulsar/bin/pulsar-admin functions delete --name payments-func
docker exec -it pulsar /pulsar/bin/pulsar-admin functions delete --name restaurants-func
docker exec -it pulsar /pulsar/bin/pulsar-admin functions delete --name order-aggregation-func
