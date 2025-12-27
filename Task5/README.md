## Запуск

1) Создание namespaces и севрисов
````shell
./create-namespaces-services.sh
````

1) Применение сетевых политик
````shell
kubectl apply -f non-admin-api-allow.yaml 
````

2) Тестирование трафика
````shell
kubectl run test2 --rm -i -t -n network-test --image=alpine --labels="role=front-end" -- sh /# wget -qO- --timeout=2 http://back-end-api
````