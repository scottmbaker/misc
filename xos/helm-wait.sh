#!/bin/bash
CHAM_URL=`minikube service xos-chameleon --url`
echo "CHAM URL is", $CHAM_URL
python ~/cord/build/scripts/xos-wait-dynamicload.py 300 $CHAM_URL vsg-hw volt fabric vrouter
