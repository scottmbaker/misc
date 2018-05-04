#! /bin/bash
TOSCA_URL=`minikube service xos-gui --url`
ACCOUNT=admin@opencord.org
PASSWORD=letmein
RECIPE=$1

echo "Tosca URL is $TOSCA_URL"
curl -H "xos-username: $ACCOUNT" -H "xos-password: $PASSWORD" -X POST --data-binary @$RECIPE $TOSCA_URL/run
