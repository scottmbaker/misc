set -e

SRC_CONTAINER=$1
DEST_CONTAINER=$2

SRC_IP=`kubectl -n voltha get pods -o wide | grep $SRC_CONTAINER | awk '{print $6}'`
DEST_CONTAINER=`kubectl -n voltha get pods | grep -i $DEST_CONTAINER | awk '{print $1}'`

echo "src: $SRC_CONTAINER ip: $SRC_IP"
echo "dest: $DEST_CONTAINER"

kubectl -n voltha exec -it $DEST_CONTAINER -- sh -c "apk add iptables > /dev/null && iptables -L INPUT | grep -i partition-$SRC_CONTAINER || iptables -A INPUT -i eth0 -s 10.244.1.43 -j DROP -m comment --comment partition-$SRC_CONTAINER"
