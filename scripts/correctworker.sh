
#!/bin/bash

# on kubemaster or controller-node

ssh-keygen -t rsa -b 4096

# or 

ssh-keygen -t ed25519

cd .ssh

# Copie la clé vers kubenode2 et kubenode1 (avec le bon user)
ssh-copy-id kubenode2@ipadresse_kubenode2
ssh-copy-ide kubenode1@ipadresse_kubenode1

# Teste
ssh kubenode2@192.168.11.162

# Puis relance le scp
# remplace ip_address... par les vraies adresses ip de tes serveurs workernodes
scp /etc/kubernetes/admin.conf kubenode2@ip_address_worker2:/home/kubenode2/
scp /etc/kubernetes/admin.conf kubenode1@ip_address_worker1:/home/kubenode1



# si depuis tes workers, tu essaies de taper #kubectl get nodes et tu n'as pas 
#  kubectl get nodes
#E0517 16:06:13.612471   12988 memcache.go:265] "Unhandled Error" err="couldn't get current server API group list: Get \"http://localhost:8080/api?timeout=32s\": dial tcp 127.0.0.1:8080: connect: connection refused"
#E0517 16:06:13.612741   12988 memcache.go:265] "Unhandled Error" err="couldn't get current server API group list: Get \"http://localhost:8080/api?timeout=32s\": dial tcp 127.0.0.1:8080: connect: connection refused"
#E0517 16:06:13.613777   12988 memcache.go:265] "Unhandled Error" err="couldn't get current server API group list: Get \"http://localhost:8080/api?timeout=32s\": dial tcp 127.0.0.1:8080: connect: connection refused"
#E0517 16:06:13.614026   12988 memcache.go:265] "Unhandled Error" err="couldn't get current server API group list: Get \"http://localhost:8080/api?timeout=32s\": dial tcp 127.0.0.1:8080: connect: connection refused"
#E0517 16:06:13.615361   12988 memcache.go:265] "Unhandled Error" err="couldn't get current server API group list: Get \"http://localhost:8080/api?timeout=32s\": dial tcp 127.0.0.1:8080: connect: connection refused"
#The connection to the server localhost:8080 was refused - did you specify the right host or port?

# sur master ou controller-master
scp /etc/kubernetes/admin.conf username_worker1@ipaddress_worker1:/home/kubenode1/
scp /etc/kubernetes/admin.conf username_worker2@ipaddress_worker2:/home/kubenode2/

# sur chaque worker 
# kubenode1 ou  kubenode2, colle ceci : 

mkdir -p $HOME/.kube
mv admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# après tu tapes sur chaque worker node
kubectl get nodes


