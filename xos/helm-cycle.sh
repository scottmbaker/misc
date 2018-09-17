#! /bin/bash

USE_PROFILE=${PROFILE:-rcord-lite}

echo "Profile is $USE_PROFILE"

for THIS_PROFILE in $(echo $USE_PROFILE | sed "s/,/ /g"); do
  helm del --purge $THIS_PROFILE
done

helm del --purge xos-core
helm del --purge xossh
helm del --purge cord-kafka
helm del --purge onos
helm del --purge demo-exampleservice
helm del --purge demo-simpleexampleservice

kubectl delete pods --all
kubectl delete configmaps --all

echo "Waiting for all pods to be deleted..."
GET_PODS_RESULT=`kubectl get pods`
while [ -n "$GET_PODS_RESULT" ]; do
   GET_PODS_RESULT=`kubectl get pods`
done
echo "We are clear of pods"

which minikube
if [[ $? == 0 ]]; then 
    docker_env=`minikube docker-env`
    if [[ "$docker_env" != "'none' driver does not support 'minikube docker-env' command" ]]; then
      eval $docker_env
    fi
fi

groups | grep -i docker
IN_DOCKER=$?

set -e

#cd ~/cord/automation-tools/developer
#if [[ $IN_DOCKER == 0  ]]; then
#    ./imagebuilder.py -f ~/cord/helm-charts/examples/filter-images.yaml
#else
#    sudo ./imagebuilder.py -f ~/cord/helm-charts/examples/filter-images.yaml
#fi

/opt/smbaker/rebuild-containers.sh

cd ~/cord/helm-charts

#helm install -n onos-fabric -f configs/onos-fabric.yaml onos
#helm install -n onos-voltha -f configs/onos-voltha.yaml onos

helm install -n onos -f configs/onos.yaml onos

helm dep update xos-core
helm install xos-core -n xos-core \
     -f examples/image-tag-candidate.yaml -f examples/imagePullPolicy-IfNotPresent.yaml

for THIS_PROFILE in $(echo $USE_PROFILE | sed "s/,/ /g"); do    
  helm dep update xos-profiles/$THIS_PROFILE
  helm install xos-profiles/$THIS_PROFILE -n $THIS_PROFILE \
       --set computeNodes.master.name="$( hostname )" \
       --set vtn-service.sshUser="$( whoami )" \
       -f examples/image-tag-candidate.yaml -f examples/imagePullPolicy-IfNotPresent.yaml
done
  
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
helm install -f examples/kafka-single.yaml --version 0.8.8 -n cord-kafka incubator/kafka
