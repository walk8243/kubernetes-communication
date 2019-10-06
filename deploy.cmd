minikube start

kubectl create namespace k8s-communication
kubectl create namespace k8s-communication-sub

kubectl create -f deploy.yaml
kubectl expose deployment server --type=LoadBalancer --port=80
minikube service server
