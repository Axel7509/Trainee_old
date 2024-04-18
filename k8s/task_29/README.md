eksctl create cluster -f eks-cluster.yml

kubectl create secret tls my-tls-secret --cert=fullchain.pem --key=privkey.pem

eksctl delete cluster -f eks-cluster.yml