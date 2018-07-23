#!/bin/bash
set -e
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
cd ~/cord/orchestration/xos_services/onos-service
sudo docker build -t xosproject/onos-synchronizer:candidate -f Dockerfile.synchronizer .
cd ~/cord/orchestration/xos_services/vtn-service
sudo docker build -t xosproject/vtn-synchronizer:candidate -f Dockerfile.synchronizer .
cd ~/cord/orchestration/xos_services/openstack
sudo docker build -t xosproject/openstack-synchronizer:candidate -f Dockerfile.synchronizer .
cd ~/cord/orchestration/xos_services/exampleservice
sudo docker build -t xosproject/exampleservice-synchronizer:candidate -f Dockerfile.synchronizer .
cd ~/cord/orchestration/xos_services/simpleexampleservice
sudo docker build -t xosproject/simpleexampleservice-synchronizer:candidate -f Dockerfile.synchronizer .
cd ~/cord/orchestration/xos_services/addressmanager
sudo docker build -t xosproject/addressmanager-synchronizer:candidate -f Dockerfile.synchronizer .
cd ~/cord/orchestration/xos_services/kubernetes-service
sudo docker build -t xosproject/kubernetes-service-synchronizer:candidate -f Dockerfile.synchronizer .
# tosca-loader
cd ~/cord/orchestration/xos-tosca/loader
sudo docker build -t xosproject/tosca-loader:candidate -f Dockerfile.tosca-loader .    
# rcord
cd ~/cord/orchestration/xos_services/olt-service
sudo docker build -t xosproject/volt-synchronizer:candidate -f Dockerfile.synchronizer .
cd ~/cord/orchestration/xos_services/fabric
sudo docker build -t xosproject/fabric-synchronizer:candidate -f Dockerfile.synchronizer .
cd ~/cord/orchestration/xos_services/fabric-crossconnect
sudo docker build -t xosproject/fabric-crossconnect-synchronizer:candidate -f Dockerfile.synchronizer .
cd ~/cord/orchestration/xos_services/vrouter
sudo docker build -t xosproject/vrouter-synchronizer:candidate -f Dockerfile.synchronizer .
cd ~/cord/orchestration/xos_services/vsg-hw
sudo docker build -t xosproject/vsg-hw-synchronizer:candidate -f Dockerfile.synchronizer .
cd ~/cord/orchestration/profiles/rcord
sudo docker build -t xosproject/rcord-synchronizer:candidate -f Dockerfile.synchronizer .
cd ~/cord/orchestration/xos_services/hippie-oss
sudo docker build -t xosproject/hippie-oss-synchronizer:candidate -f Dockerfile.synchronizer .
