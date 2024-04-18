1. helm repo add prometheus-community  https://prometheus-community.github.io/helm-charts

2. kubectl create ns monitoring
3. helm install prom prometheus-community/kube-prometheus-stack -n monitoring --values values.yml
4. helm repo add grafana https://grafana.github.io/helm-charts

5. helm upgrade --install loki grafana/loki-distributed -n monitoring --set service.type=LoadBalancer
6. helm upgrade --install promtail grafana/promtail -f promtail-values.yml -n monitoring
7. kubectl patch service/prom-grafana -n monitroing --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]'
8. cred Garafana 
        Username: admin
        Password: prom-operator

9. kubectl apply -f pv-storage-loki-alert.yaml
10. kubectl apply -f pv-storage-loki-0.yml