#! /bin/bash

USE_PROFILE=${PROFILE:-rcord-lite}

echo "Profile is $USE_PROFILE"

#helm delete $USE_PROFILE
#helm delete xos-core
#helm delete xossh
helm del --purge $USE_PROFILE
helm del --purge xos-core
helm del --purge xossh
helm del --purge cord-kafka
helm del --purge onos-cord

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
if [[ $? == 0 ]]; then
   IN_DOCKER=1
else
   IN_DOCKER=0
fi

set -e
cd ~/cord/build

if [[ $IN_DOCKER ]]; then
    scripts/imagebuilder.py -f ~/cord/helm-charts/examples/filter-images.yaml
else
    sudo scripts/imagebuilder.py -f ~/cord/helm-charts/examples/filter-images.yaml
fi

cd ~/cord/helm-charts

helm upgrade --install onos-cord ./onos
~/openstack-helm/tools/deployment/common/wait-for-pods.sh default
ONOS_CORD_POD=$(kubectl get pods | grep onos-cord | awk '{print $1}')
kubectl cp ~/.ssh/id_rsa "$ONOS_CORD_POD":/root/node_key

helm dep update xos-core
helm install xos-core -n xos-core \
     -f examples/image-tag-candidate.yaml -f examples/imagePullPolicy-IfNotPresent.yaml
helm dep update xos-profiles/$USE_PROFILE
helm install xos-profiles/$USE_PROFILE -n $USE_PROFILE \
     --set computeNodes.master.name="$( hostname )" \
     --set vtn-service.sshUser="$( whoami )" \
     -f examples/image-tag-candidate.yaml -f examples/imagePullPolicy-IfNotPresent.yaml

helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
helm install --name cord-kafka --set replicas=1 incubator/kafka
