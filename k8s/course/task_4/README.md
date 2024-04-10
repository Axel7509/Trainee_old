//
kubectl get nodes
sh to the worker node
ssh node01
for i in $(seq 1 6) ; do mkdir "/redis0$i" ; done
ls -ld /redis*
\\

#!/bin/bash

# Apply the Persistent Volumes configuration.
kubectl apply -f manifests/pvs.yml

# Apply the Redis cluster service configuration.
kubectl apply -f manifests/redis-cluster-service.yml

# Apply the Redis cluster statefulset configuration.
kubectl apply -f manifests/redis-cluster-statefulset.yml

# Execute the redis-cli command to create a Redis cluster with 3 masters and 3 replicas.
kubectl exec -it redis-cluster-0 -- redis-cli --cluster create --cluster-replicas 1 $(kubectl get pods -l app=redis-cluster -o jsonpath='{range.items[*]}{.status.podIP}:6379 {end}')a