pushd ~/cord/helm-charts
helm install xos-services/att-workflow-driver -n att-workflow-driver  -f examples/image-tag-candidate.yaml -f examples/imagePullPolicy-IfNotPresent.yaml
popd
pushd ~/cord/orchestration/xos_services/olt-service/samples
/opt/smbaker/helm-tosca.sh olt_device_host_and_port.yaml
/opt/smbaker/helm-tosca.sh pon_port.yaml
/opt/smbaker/helm-tosca.sh subscriber.yaml
popd
pushd ~/cord/orchestration/xos_services/fabric-crossconnect/samples
/opt/smbaker/helm-tosca.sh bng_mapping_any.yaml
popd
