POD=$(kubectl -n micro-onos get pods -l type=cli -o name)
STUFF=`cat $1`
kubectl -n micro-onos exec -it $POD -- gnmi_cli -set -address onos-config:5150 -timeout 5s -en PROTO -alsologtostderr -insecure -client_crt /etc/ssl/certs/client1.crt -client_key /etc/ssl/certs/client1.key -ca_crt /etc/ssl/certs/onfca.crt -proto " $STUFF"
