#!/bin/bash
set -e
ALL_CONTAINERS="xos-client xos-core chameleon xos-tosca onos-synchronizer kubernetes-synchronizer tosca-loader volt-synchronizer fabric-synchronizer fabric-crossconnect-synchronizer vrouter-synchronizer rcord-synchronizer att-workflow-driver-synchronizer simpleexampleservice-synchronizer"
CONTAINERS=${1:-$ALL_CONTAINERS}

TAG=test
REPOS="xos-core xos-client xos-libraries xos-synchronizer-base att-workflow-driver-synchronizer rcord-synchronizer fabric-crossconnect-synchronizer fabric-synchronizer volt-synchronizer tosca-loader kubernetes-synchronizer addressmanager-synchronizer simpleexampleservice-synchronizer exampleservice-synchronizer openstack-synchronizer onos-synchronizer vrouter-synchronizer xos-tosca mcord-synchronizer progran-synchronizer addressmanager-synchronizer"

for REPO in $REPOS; do
  if [[ $CONTAINERS == *"$REPO"* ]]; then
     echo "Tag and push $REPO"
     docker tag xosproject/$REPO:candidate smbaker/$REPO:$TAG
     docker push smbaker/$REPO:$TAG
  else
     echo "Skipping $REPO"
  fi
done
