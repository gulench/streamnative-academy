echo "Copying function configuration files."
docker cp src/main/resources/function_config/ pulsar:/pulsar/

echo "Creating the jar folder."
docker exec -it pulsar mkdir -p myjars
echo "Uploading the jar file."
docker cp target/microservices-webinars-0.0.1.jar pulsar:/pulsar/myjars/workshop.jar

echo "Setup completed successfully."