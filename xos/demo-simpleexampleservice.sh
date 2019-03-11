#! /bin/bash

set -e 
pushd ~/cord/helm-charts
helm dep update xos-profiles/demo-simpleexampleservice
helm install xos-profiles/demo-simpleexampleservice -n demo-simpleexampleservice \
     -f examples/image-tag-candidate.yaml -f examples/imagePullPolicy-IfNotPresent.yaml

SIMPLEEXAMPLESERVICE_PATH=~/cord/orchestration/xos-services/simpleexampleservice
USERNAME=admin@opencord.org
PASSWORD=letmein
TOSCA_URL=http://$( hostname ):30007
TOSCA_FN=$SIMPLEEXAMPLESERVICE_PATH/xos/examples/SimpleExampleServiceInstance.yaml
curl -H "xos-username: $USERNAME" -H "xos-password: $PASSWORD" -X POST --data-binary @$TOSCA_FN $TOSCA_URL/run
popd
