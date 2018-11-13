#! /bin/bash
set -e

#TOSCA_URL=`minikube service xos-tosca --url`


# NOTE: probably could have used localhost:30007...

TOSCA_PORTMAP=`kubectl get services | grep -i xos-tosca | awk '{print $5}'`
TOSCA_PUBLIC_PORT=`echo $TOSCA_PORTMAP | cut -d ":" -f 2 | cut -d "/" -f 1`
TOSCA_ADDR=`kubectl describe node node1 | grep -i internalip | awk '{print $2}'`
TOSCA_URL="http://$TOSCA_ADDR:$TOSCA_PUBLIC_PORT"

ACCOUNT=admin@opencord.org
PASSWORD=letmein
RECIPE=$1

echo "Tosca URL is $TOSCA_URL"
curl -H "xos-username: $ACCOUNT" -H "xos-password: $PASSWORD" -X POST --data-binary @$RECIPE $TOSCA_URL/run
