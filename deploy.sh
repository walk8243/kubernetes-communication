#!/bin/bash

# Startup confirmation minikube
MINIKUBE_STATUS=`minikube status | grep "host:" | awk -F':' '{print $2}'`
if [ $MINIKUBE_STATUS != "Running" ]; then
  minikube start
fi

# deploy for minikube
kubectl create namespace k8s-communication > /dev/null 2>&1
kubectl create namespace k8s-communication-sub > /dev/null 2>&1
kubectl apply -f deploy.yaml > /dev/null 2>&1
kubectl expose deployment server --type=LoadBalancer --port=80 --namespace=k8s-communication > /dev/null 2>&1
minikube service server --namespace=k8s-communication
