set -e

SRC_CONTAINER=$1
DEST_CONTAINER=$2

SRC_IP=`kubectl -n voltha get pods -o wide | grep $SRC_CONTAINER | awk '{print $6}'`
DEST_CONTAINER=`kubectl -n voltha get pods | grep -i $DEST_CONTAINER | awk '{print $1}'`

echo "src: $SRC_CONTAINER ip: $SRC_IP"
echo "dest: $DEST_CONTAINER"

kubectl -n voltha exec -it $DEST_CONTAINER -- sh -c "iptables -D INPUT \`iptables -L INPUT --line-number | grep partition-$SRC_CONTAINER | head | awk '{print \$1}'\`"
