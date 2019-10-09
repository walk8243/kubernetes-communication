@echo off
setlocal

REM Startup confirmation minikube
set TMP_FILE1=minikube_status.log
set TMP_FILE2=minikube_host_status.log
minikube status > %TMP_FILE1%
find /i "host:" %TMP_FILE1% > %TMP_FILE2%
find /i "Running" %TMP_FILE2% > nul
if not %ERRORLEVEL% equ 0 (
  minikube start
)
if exist %TMP_FILE1% ( del %TMP_FILE1% )
if exist %TMP_FILE2% ( del %TMP_FILE2% )

REM deploy for minikube
kubectl create namespace k8s-communication > nul 2>&1
kubectl create namespace k8s-communication-sub > nul 2>&1
kubectl apply -f deploy.yaml > nul 2>&1
kubectl expose deployment server --type=LoadBalancer --port=80 --namespace=k8s-communication > nul 2>&1
minikube service server --namespace=k8s-communication

endlocal
exit /b 0
