#! /bin/bash

helm delete rcord-lite
helm delete xos-core
helm del --purge rcord-lite
helm del --purge xos-core

GET_PODS_RESULT=`kubectl get pods`
while [ -n "$GET_PODS_RESULT" ]; do
   GET_PODS_RESULT=`kubectl get pods`
done

set -e
cd ~/cord/build
eval $(minikube docker-env)
scripts/imagebuilder.py -f helm-charts/examples/filter-images.yaml
cd helm-charts
helm install xos-core -n xos-core -f examples/candidate-tag-values.yaml
helm dep update xos-profiles/rcord-lite
helm install xos-profiles/rcord-lite -n rcord-lite -f examples/candidate-tag-values.yaml
