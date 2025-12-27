#!/bin/bash
# apply-bindings.sh

echo "Применение rolebindings.yaml"
kubectl apply -f rolebindings.yaml

echo "Проверка созданных bindings:"
kubectl get rolebindings,clusterrolebindings --all-namespaces | grep -E "propdevelopment|NAME"

read -p "Press Enter to continue..."