
#! /bin/bash

# container must have this in helm-chart:
# securityContext:
#   capabilities:
#     add: ["NET_ADMIN"]

set -e

SRC_CONTAINER=$1
DEST_CONTAINER=$2

SRC_IP=`kubectl -n voltha get pods -o wide | grep $SRC_CONTAINER | awk '{print $6}'`
DEST_CONTAINER=`kubectl -n voltha get pods | grep -i $DEST_CONTAINER | awk '{print $1}'`

echo "src: $SRC_CONTAINER ip: $SRC_IP"
echo "dest: $DEST_CONTAINER"

kubectl -n voltha exec -it $DEST_CONTAINER -- sh -c "apk add iptables > /dev/null && iptables -L INPUT | grep -i src-partition-$SRC_CONTAINER || iptables -A INPUT -s $SRC_IP -j DROP -m comment --comment src-partition-$SRC_CONTAINER"
kubectl -n voltha exec -it $DEST_CONTAINER -- sh -c "apk add iptables > /dev/null && iptables -L OUTPUT | grep -i dest-partition-$SRC_CONTAINER || iptables -A OUTPUT -d $SRC_IP -j DROP -m comment --comment dest-partition-$SRC_CONTAINER"
