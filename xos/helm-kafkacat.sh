#! /bin/bash
NAME=`kubectl get pods | grep -i kafkacat | cut -f 1 -d " "`
kubectl exec -it $NAME bash
