#!/usr/bin/env bash

set -euo pipefail

echo "===== Network Debug Check ====="

echo "[1] Checking environment variables for kube API..."
env | grep KUBERNETES || echo "No KUBERNETES_* env vars found"

echo -e "\n[2] DNS resolution test:"
nslookup kubernetes.default || true

echo -e "\n[3] Curl to kubernetes service (via DNS):"
curl -vsk --max-time 5 https://kubernetes.default.svc.cluster.local:443/ || true

echo -e "\n[4] Curl to kubernetes service (via env vars):"
if [[ -n "${KUBERNETES_SERVICE_HOST:-}" && -n "${KUBERNETES_PORT_443_TCP_PORT:-}" ]]; then
  curl -vsk --max-time 5 https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_PORT_443_TCP_PORT/ || true
else
  echo "KUBERNETES_SERVICE_* vars not set!"
fi

echo -e "\n[5] Routing table:"
ip route

echo -e "\n[6] Network interfaces:"
ip addr show

echo -e "\n===== Done ====="
