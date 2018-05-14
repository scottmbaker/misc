#! /bin/bash
alias helm-cycle="/opt/smbaker/helm-cycle.sh"
alias helm-xossh-start="kubectl get pods | grep -i xossh | grep -v "erminating" > /dev/null || (pushd ~/cord/helm-charts; helm install xos-tools/xossh -n xossh; popd)"
alias helm-xossh-stop="helm del --purge xossh"
alias helm-xossh="~/cord/helm-charts/xos-tools/xossh/xossh-attach.sh"
alias helm-wait="/opt/smbaker/helm-wait.sh"
alias helm-tosca="/opt/smbaker/helm-tosca.sh"
