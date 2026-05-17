#!/bin/bash

#Cilium over Flannel as the CNI (Container Network Interface)

# remove flannel if installed!
kubectl delete -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

# open firewall ports
sudo ufw allow proto tcp from any to any port 443
# BGP
sudo ufw allow proto tcp from any to any port 179
sudo ufw allow proto udp from any to any port 9099

# install cilium
curl -L --remote-name https://github.com/cilium/cilium-cli/releases/latest/download/cilium-linux-amd64.tar.gz
sudo tar xzvf cilium-linux-amd64.tar.gz -C /usr/local/bin
rm cilium-linux-amd64.tar.gz

# Or via Helm charts
# Add the official Cilium Helm chart repository
helm repo add cilium https://helm.cilium.io/

# Update the Helm repository cache
helm repo update

# List available Cilium chart versions to choose a pinned version
helm search repo cilium/cilium --versions | head -10
helm install cilium cilium/cilium --version 1.15.0 --namespace kube-system

# Check status using the Cilium CLI
cilium status --wait

# Alternatively, check pod status
kubectl get pods -n kube-system -l k8s-app=cilium -o wide

# View installed Cilium version
cilium version

echo "You need to open firewall ports to worker noders too !"
