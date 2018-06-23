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
cd ~/cord/orchestration/xos_services/addressmanager
sudo docker build -t xosproject/addressmanager-synchronizer:candidate -f Dockerfile.synchronizer .