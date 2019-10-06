minikube start

kubectl create -f base-client.yaml
kubectl create -f base-server.yaml

kubectl expose deployment nginx --type=LoadBalancer --port=80
minikube service nginx
