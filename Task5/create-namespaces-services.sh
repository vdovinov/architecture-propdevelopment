#!/bin/bash
# create-namespaces-services.sh

# Создаем namespace
echo "Создание namespace для тестирования"
kubectl create namespace network-test
kubectl label namespace network-test environment=test

# Создаем сервисы с метками
echo "Создание сервисов"

# front-end сервис
kubectl run front-end-app \
  --image=nginx:alpine \
  --labels="role=front-end" \
  --port=80 \
  --expose \
  --namespace=network-test

# back-end-api сервис
kubectl run back-end-api-app \
  --image=nginx:alpine \
  --labels="role=back-end-api" \
  --port=80 \
  --expose \
  --namespace=network-test

# admin-front-end сервис
kubectl run admin-front-end-app \
  --image=nginx:alpine \
  --labels="role=admin-front-end" \
  --port=80 \
  --expose \
  --namespace=network-test

# admin-back-end-api сервис
kubectl run admin-back-end-api-app \
  --image=nginx:alpine \
  --labels="role=admin-back-end-api" \
  --port=80 \
  --expose \
  --namespace=network-test

echo "Ожидание запуска подов..."
sleep 10

# Проверяем созданные сервисы
echo "Созданные сервисы:"
kubectl get pods,services --namespace=network-test --show-labels