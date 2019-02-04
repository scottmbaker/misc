#!/bin/bash
set -e
ALL_CONTAINERS="xos-libraries xos-client xos-synchronizer-base xos-core chameleon xos-tosca onos-synchronizer vtn-synchronizer openstack-synchronizer exampleservice-synchronizer addressmanager-synchronizer kubernetes-synchronizer tosca-loader volt-synchronizer fabric-synchronizer fabric-crossconnect-synchronizer vrouter-synchronizer vsg-hw-synchronized rcord-synchronizer hippie-oss-synchronizer att-workflow-driver-synchronizer mcord-synchronizer progran-synchronizer"
CONTAINERS=${1:-$ALL_CONTAINERS}

TAG=test
REPOS="xos-core xos-client xos-libraries xos-synchronizer-base att-workflow-driver-synchronizer rcord-synchronizer fabric-crossconnect-synchronizer fabric-synchronizer volt-synchronizer tosca-loader kubernetes-synchronizer addressmanager-synchronizer simpleexampleservice-synchronizer exampleservice-synchronizer openstack-synchronizer onos-synchronizer vrouter-synchronizer xos-tosca"

for REPO in $REPOS; do
  if [[ $CONTAINERS == *"$REPO"* ]]; then
     echo "Tag and push $REPO"
     docker tag xosproject/$REPO:candidate smbaker/$REPO:$TAG
     docker push smbaker/$REPO:$TAG
  else
     echo "Skipping $REPO"
  fi
done
