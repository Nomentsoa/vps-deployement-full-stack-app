#!/bin/sh

CERT_DIR="/etc/letsencrypt/live/lazanomentsoa.tech"

if [ ! -f "$CERT_DIR/fullchain.pem" ]; then
  echo "Création d'un certificat SSL temporaire..."
  mkdir -p "$CERT_DIR"
  openssl req -x509 -nodes -newkey rsa:2048 -days 1 \
    -keyout "$CERT_DIR/privkey.pem" \
    -out "$CERT_DIR/fullchain.pem" \
    -subj "/CN=lazanomentsoa.tech"
fi

while :; do sleep 6h & wait ${!}; nginx -s reload; done &

exec nginx -g "daemon off;"
