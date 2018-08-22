ONOS_ADDR=`kubectl get services | grep -i onos-fabric-ssh | awk '{print $3}'`
ssh karaf@$ONOS_ADDR -p 8101
