#!/bin/bash

set -e

#add repo
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

mkdir -p ~/.kube && cp kubespray/inventory/mycluster/artifacts/admin.conf ~/.kube/config

#install dashboard
helm install --namespace monitoring --create-namespace -f ./manifests/dashboard-values.yml kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard
kubectl apply -f manifests/dashboard-admin.yml
#для управления
#kubectl -n monitoring describe secret $(kubectl -n monitoring get secret | grep admin-user | awk '{print $1}')
#kubectl port-forward -n monitoring $(kubectl get pods -n monitoring -l "app.kubernetes.io/name=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}") 9090

#install app
kubectl create ns ms
kubectl -n ms apply -f ./microservices-demo/release/kubernetes-manifests.yaml
kubectl -n ms apply -f ./manifests/ms-ingress-nginx.yaml

#install prometheus
helm install --namespace monitoring --create-namespace -f manifests/prometheus-values.yml ms-prometheus prometheus-community/prometheus
#helm upgrade  --namespace monitoring ms-prometheus -f manifests/prometheus-values.yml prometheus-community/prometheus
#helm uninstall --namespace monitoring ms-prometheus

#install grafana
helm install --namespace monitoring --create-namespace -f manifests/grafana-values.yml ms-grafana grafana/grafana
#helm upgrade  --namespace monitoring ms-grafana -f manifests/grafana-values.yml grafana/grafana 
#helm uninstall --namespace monitoring ms-grafana

#install loki
helm upgrade --namespace monitoring --install ms-loki grafana/loki-stack
kubectl -n monitoring apply -f ./manifests/loki-ingress-nginx.yml