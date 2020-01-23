# Run contianer with passthrough to local network
docker run -d --network=host --name=kubectl-host --rm -it piotrzan/kubectl-comp

# Generate raw config from kubeclt on localhost and copy the config to the container
kubectl config view --raw > config
docker cp ./config kubectl-host:./root/.kube

docker attach kubectl-host