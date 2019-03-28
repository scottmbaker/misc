#!/bin/bash
set -e
ALL_CONTAINERS="xos-libraries xos-client xos-synchronizer-base xos-core xos-libraries xos-tosca onos-synchronizer vtn-synchronizer openstack-synchronizer exampleservice-synchronizer addressmanager-synchronizer kubernetes-synchronizer tosca-loader volt-synchronizer fabric-synchronizer fabric-crossconnect-synchronizer vrouter-synchronizer vsg-hw-synchronized rcord-synchronizer hippie-oss-synchronizer att-workflow-driver-synchronizer simpleexampleservice-synchronizer"
CONTAINERS=${1:-$ALL_CONTAINERS}
CORD_BASE=${CORD_DIR:-~/projects/opencord}
SERVICES_BASE=$CORD_BASE/orchestration/xos-services
cd $CORD_BASE/orchestration/xos
if [[ $CONTAINERS == *"xos-libraries"* ]]; then
  echo "Building Libraries"
  sudo docker build -t xosproject/xos-libraries:candidate -f containers/xos/Dockerfile.libraries .
#  rm -rf containers/xos/tmp.chameleon
#  cp -a $CORD_BASE/component/chameleon containers/xos/tmp.chameleon
fi
if [[ $CONTAINERS == *"xos-client"* ]]; then
  sudo docker build -t xosproject/xos-client:candidate -f containers/xos/Dockerfile.client .
fi
if [[ $CONTAINERS == *"xos-synchronizer-base"* ]]; then
  sudo docker build -t xosproject/xos-synchronizer-base:candidate -f containers/xos/Dockerfile.synchronizer-base .
fi
if [[ $CONTAINERS == *"xos-core"* ]]; then
  sudo docker build -t xosproject/xos-core:candidate -f containers/xos/Dockerfile.xos-core .
fi
if [[ $CONTAINERS == *"xos-tosca"* ]]; then
  cd $CORD_BASE/orchestration/xos-tosca
  sudo docker build -t xosproject/xos-tosca:candidate -f Dockerfile .
fi
if [[ $CONTAINERS == *"onos-synchronizer"* ]]; then
  cd $SERVICES_BASE/onos-service
  sudo docker build -t xosproject/onos-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"vtn-synchronizer"* ]]; then
  cd $SERVICES_BASE/vtn-service
  sudo docker build -t xosproject/vtn-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"openstack-synchronizer"* ]]; then
  cd $SERVICES_BASE/openstack
  sudo docker build -t xosproject/openstack-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"exampleservice-synchronizer"* ]]; then
  cd $SERVICES_BASE/exampleservice
  sudo docker build -t xosproject/exampleservice-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"simpleexampleservice-synchronizer"* ]]; then
  cd $SERVICES_BASE/simpleexampleservice
  sudo docker build -t xosproject/simpleexampleservice-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"addressmanager-synchronizer"* ]]; then
  cd $SERVICES_BASE/addressmanager
  sudo docker build -t xosproject/addressmanager-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"kubernetes-synchronizer"* ]]; then
  cd $SERVICES_BASE/kubernetes-service
  sudo docker build -t xosproject/kubernetes-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"tosca-loader"* ]]; then
  # tosca-loader
  cd $CORD_BASE/orchestration/xos-tosca/loader
  sudo docker build -t xosproject/tosca-loader:candidate -f Dockerfile.tosca-loader .
fi
if [[ $CONTAINERS == *"volt-synchronizer"* ]]; then
  # rcord
  cd $SERVICES_BASE/olt-service
  sudo docker build -t xosproject/volt-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"fabric-synchronizer"* ]]; then
  cd $SERVICES_BASE/fabric
  sudo docker build -t xosproject/fabric-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"fabric-crossconnect-synchronizer"* ]]; then
  cd $SERVICES_BASE/fabric-crossconnect
  sudo docker build -t xosproject/fabric-crossconnect-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"vrouter-synchronizer"* ]]; then
  cd $SERVICES_BASE/vrouter
  sudo docker build -t xosproject/vrouter-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"vsg-hw-synchronized"* ]]; then
  cd $SERVICES_BASE/vsg-hw
  sudo docker build -t xosproject/vsg-hw-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"rcord-synchronizer"* ]]; then
  cd $SERVICES_BASE/rcord
  sudo docker build -t xosproject/rcord-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"hippie-oss-synchronized"* ]]; then
  cd $SERVICES_BASE/hippie-oss
  sudo docker build -t xosproject/hippie-oss-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"att-workflow-driver-synchronizer"* ]]; then
  cd $SERVICES_BASE/att-workflow-driver
  sudo docker build -t xosproject/att-workflow-driver-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"progran-synchronizer"* ]]; then
    cd $SERVICES_BASE/progran
    sudo docker build -t xosproject/progran-synchronizer:candidate -f Dockerfile.synchronizer .
fi
if [[ $CONTAINERS == *"mcord-synchronizer"* ]]; then
    cd $CORD_BASE/orchestration/profiles/mcord
    sudo docker build -t xosproject/mcord-synchronizer:candidate -f Dockerfile.synchronizer .
fi
