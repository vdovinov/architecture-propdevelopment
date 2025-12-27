#!/bin/bash
# create-users.sh

echo "Создание пользователей для PropDevelopment"

# Директория для сертификатов
CERT_DIR="./k8s-certs"
mkdir -p $CERT_DIR

# Список пользователей
USERS=(
  "security_auditor"
  "namespace_admin"
  "developer"
  "viewer"
)

# Создание конфигурационного файла OpenSSL
cat > "$CERT_DIR/openssl.conf" <<EOF
[ req ]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn

[ dn ]
CN = placeholder
O = propdevelopment
EOF

# Создание ключей и CSR для каждого пользователя
for USER in "${USERS[@]}"; do
  echo "Создание сертификатов для пользователя: $USER"

  # Обновляем конфигурацию для текущего пользователя
  echo "Обновляем конфигурацию для текущего пользователя"
  sed "s/CN = placeholder/CN = $USER/" "$CERT_DIR/openssl.conf" > "$CERT_DIR/openssl-$USER.conf"

  # Генерация приватного ключа
  openssl genrsa -out $CERT_DIR/$USER.key 2048

  # Создание CSR с использованием конфигурационного файла
  openssl req -new \
    -key $CERT_DIR/$USER.key \
    -out $CERT_DIR/$USER.csr \
    -subj "/CN=$USER/O=propdevelopment" \
    -config "$CERT_DIR/openssl-$USER.conf"

  # Удаляем временный конфиг
  rm "$CERT_DIR/openssl-$USER.conf"

done

# Удаляем общий конфиг
rm "$CERT_DIR/openssl.conf"

echo "Пользователи созданы"

read -p "Press Enter to continue..."