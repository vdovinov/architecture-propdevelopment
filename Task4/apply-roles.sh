#!/bin/bash
# apply-roles.sh

echo "Применение RBAC ролей"

# Применение ролей
kubectl apply -f roles.yaml

echo "Роли созданы:"
kubectl get clusterroles,roles --all-namespaces | grep propdevelopment

read -p "Press Enter to continue..."