# Create the vote namespace
kubectl apply -f manifests/vote-ns.yml

# Create the deployments and services for the PostgreSQL database
kubectl apply -f manifests/db-deployment.yml
kubectl apply -f manifests/db-service.yml

# Create the deployments and services for the redis database
kubectl apply -f manifests/redis-deployment.yml
kubectl apply -f manifests/redis-service.yml

# Create the deployments and services for the vote microservice
kubectl apply -f manifests/vote-deployment.yml
kubectl apply -f manifests/vote-service.yml

# Create the deployment for the worker microservice
kubectl apply -f manifests/worker-deployment.yml


# Create the deployments and services for the result database
kubectl apply -f manifests/result-deployment.yml
kubectl apply -f manifests/result-service.yml