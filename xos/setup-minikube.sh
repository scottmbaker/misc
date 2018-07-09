#! /bin/bash

set -e

USER=$( whoami )

sudo apt update
sudo apt-get -y install python
sudo apt-get -y install python-pip
pip install requests
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.25.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
wget https://github.com/kubernetes/helm/archive/v2.8.2.tar.gz
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.8.2-linux-amd64.tar.gz
tar -xzf helm-v2.8.2-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
sudo bash -c "curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-ubuntu16.04 > /usr/local/bin/docker-machine-driver-kvm"
sudo chmod +x /usr/local/bin/docker-machine-driver-kvm
sudo mkdir -p /mnt/extra/minikube_home
sudo chown $USER /mnt/extra/minikube_home
export MINIKUBE_HOME=/mnt/extra/minikube_home
sudo minikube start --vm-driver=none --bootstrapper=kubeadm
sudo chown -R $USER /mnt/extra/minikube_home
sudo chown -R $USER /users/$USER/.kube
sudo apt-get install -y socat
