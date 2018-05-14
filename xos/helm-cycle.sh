#! /bin/bash

USE_PROFILE=${PROFILE:-rcord-lite}

echo "Profile is $USE_PROFILE"

helm delete $USE_PROFILE
helm delete xos-core
helm delete xossh
helm del --purge $USE_PROFILE
helm del --purge xos-core
helm del --purge xossh

kubectl delete pods --all
kubectl delete configmaps --all

set -e
cd ~/cord/build

docker_env=`minikube docker-env`
if [[ "$docker_env" != "'none' driver does not support 'minikube docker-env' command" ]]; then
  eval $docker_env
fi

scripts/imagebuilder.py -f ~/cord/helm-charts/examples/filter-images.yaml

echo "Waiting for all pods to be deleted..."
GET_PODS_RESULT=`kubectl get pods`
while [ -n "$GET_PODS_RESULT" ]; do
   GET_PODS_RESULT=`kubectl get pods`
done
echo "We are clear of pods"

cd ~/cord/helm-charts
helm dep update xos-core
helm install xos-core -n xos-core -f examples/candidate-tag-values.yaml
helm dep update xos-profiles/$USE_PROFILE
helm install xos-profiles/$USE_PROFILE -n $USE_PROFILE -f examples/candidate-tag-values.yaml
