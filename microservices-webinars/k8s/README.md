# Pulsar in Kubernetes cluster

## Using a kind Kubernetes Cluster

The following setup uses a `kind` Kubernetes cluster:

```bash
# Set up a `kind` cluster
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64
kind create cluster
kubectl cluster-info --context kind-kind

# Set up helm
curl -L https://get.helm.sh/helm-v3.9.1-linux-amd64.tar.gz -o helm.tar.gz

helm repo add apache https://pulsar.apache.org/charts
helm repo list

# Install pulsar using helm chart
cd
git clone https://github.com/apache/pulsar-helm-chart
helm repo update
cd pulsar-helm-chart
./scripts/pulsar/prepare_helm_release.sh -n workshop -k pulsar -c
# helm install --values examples/values-minikube.yaml --set initialize=true  -n workshop pulsar apache/pulsar
helm install -n workshop \
  --values /workspaces/streamnative-academy/microservices-webinars/k8s/values.yaml \
  --set initialize=true \
  pulsar \
  apache/pulsar

kubectl get pods -n workshop

#- clean up
helm delete -n workshop pulsar
```

## Pulsar Manager UI

Create an admin user:

```bash
CSRF_TOKEN=$(curl http://localhost:7750/pulsar-manager/csrf-token)
curl \
   -H 'X-XSRF-TOKEN: $CSRF_TOKEN' \
   -H 'Cookie: XSRF-TOKEN=$CSRF_TOKEN;' \
   -H "Content-Type: application/json" \
   -X PUT http://localhost:7750/pulsar-manager/users/superuser \
   -d '{"name": "admin", "password": "apachepulsar", "description": "test", "email": "username@test.org"}'
```

Login as the admin user created above. In the Pulsar Manager UI, add environment pointing to http://pulsar-proxy:80/


Accessing the pulsar_manager PostgreSQL database:

```txt
kubectl exec -it pulsar-pulsar-manager-69bc4fb5cd-crmwj -n workshop -- sh

# psql postgresql://localhost:5432/pulsar_manager -U pulsar -w

pulsar_manager=# \dt
               List of relations
 Schema |        Name         | Type  | Owner  
--------+---------------------+-------+--------
 public | consumers_stats     | table | pulsar
 public | environments        | table | pulsar
 public | namespaces          | table | pulsar
 public | publishers_stats    | table | pulsar
 public | replications_stats  | table | pulsar
 public | role_binding        | table | pulsar
 public | roles               | table | pulsar
 public | subscriptions_stats | table | pulsar
 public | tenants             | table | pulsar
 public | tokens              | table | pulsar
 public | topics_stats        | table | pulsar
 public | users               | table | pulsar
(12 rows)

pulsar_manager=# select * from users;
 user_id | access_token | name | description | email | phone_number | location | company | expire | password 
---------+--------------+------+-------------+-------+--------------+----------+---------+--------+----------
(0 rows)

pulsar_manager=# select * from roles;
 role_id | role_name | role_source | description | resource_id | resource_type | resource_name | resource_verbs | flag 
---------+-----------+-------------+-------------+-------------+---------------+---------------+----------------+------
(0 rows)

pulsar_manager=# select * from role_binding;
 role_binding_id | name | description | role_id | user_id 
-----------------+------+-------------+---------+---------
(0 rows)

```
