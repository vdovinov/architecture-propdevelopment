#!/bin/bash
# create-namespaces.sh

echo "Создание namespace для PropDevelopment"

# Создание основных namespace
kubectl create namespace propdevelopment-production
kubectl create namespace propdevelopment-development

# Добавление меток для классификации
kubectl label namespace propdevelopment-production environment=production
kubectl label namespace propdevelopment-development environment=development

echo "Namespace созданы:"
kubectl get namespaces --show-labels | grep propdevelopment

read -p "Press Enter to continue..."