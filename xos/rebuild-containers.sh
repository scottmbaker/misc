#!/bin/bash
set -e
SERVICES_BASE=~/cord/orchestration/xos-services
cd ~/cord/orchestration/xos
sudo docker build -t xosproject/xos-libraries:candidate -f containers/xos/Dockerfile.libraries .
rm -rf containers/xos/tmp.chameleon
cp -a ~/cord/component/chameleon containers/xos/tmp.chameleon
sudo docker build -t xosproject/xos-client:candidate -f containers/xos/Dockerfile.client .
sudo docker build -t xosproject/xos-synchronizer-base:candidate -f containers/xos/Dockerfile.synchronizer-base .
sudo docker build -t xosproject/xos-core:candidate -f containers/xos/Dockerfile.xos-core .
#sudo docker build -t xosproject/chameleon:candidate -f containers/chameleon/Dockerfile.chameleon .
#cd ~/cord/orchestration/xos-tosca
#sudo docker build -t xosproject/xos-tosca:candidate -f Dockerfile .
cd $SERVICES_BASE/onos-service
sudo docker build -t xosproject/onos-synchronizer:candidate -f Dockerfile.synchronizer .
cd $SERVICES_BASE/vtn-service
sudo docker build -t xosproject/vtn-synchronizer:candidate -f Dockerfile.synchronizer .
cd $SERVICES_BASE/openstack
sudo docker build -t xosproject/openstack-synchronizer:candidate -f Dockerfile.synchronizer .
cd $SERVICES_BASE/exampleservice
sudo docker build -t xosproject/exampleservice-synchronizer:candidate -f Dockerfile.synchronizer .
cd $SERVICES_BASE/simpleexampleservice
sudo docker build -t xosproject/simpleexampleservice-synchronizer:candidate -f Dockerfile.synchronizer .
cd $SERVICES_BASE/addressmanager
sudo docker build -t xosproject/addressmanager-synchronizer:candidate -f Dockerfile.synchronizer .
cd $SERVICES_BASE/kubernetes-service
sudo docker build -t xosproject/kubernetes-synchronizer:candidate -f Dockerfile.synchronizer .
# tosca-loader
cd ~/cord/orchestration/xos-tosca/loader
sudo docker build -t xosproject/tosca-loader:candidate -f Dockerfile.tosca-loader .    
# rcord
cd $SERVICES_BASE/olt-service
sudo docker build -t xosproject/volt-synchronizer:candidate -f Dockerfile.synchronizer .
cd $SERVICES_BASE/fabric
sudo docker build -t xosproject/fabric-synchronizer:candidate -f Dockerfile.synchronizer .
cd $SERVICES_BASE/fabric-crossconnect
sudo docker build -t xosproject/fabric-crossconnect-synchronizer:candidate -f Dockerfile.synchronizer .
cd $SERVICES_BASE/vrouter
sudo docker build -t xosproject/vrouter-synchronizer:candidate -f Dockerfile.synchronizer .
cd $SERVICES_BASE/vsg-hw
sudo docker build -t xosproject/vsg-hw-synchronizer:candidate -f Dockerfile.synchronizer .
cd ~/cord/orchestration/profiles/rcord
sudo docker build -t xosproject/rcord-synchronizer:candidate -f Dockerfile.synchronizer .
cd $SERVICES_BASE/hippie-oss
sudo docker build -t xosproject/hippie-oss-synchronizer:candidate -f Dockerfile.synchronizer .
cd $SERVICES_BASE/att-workflow-driver
sudo docker build -t xosproject/att-workflow-driver-synchronizer:candidate -f Dockerfile.synchronizer .
