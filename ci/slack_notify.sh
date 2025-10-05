#!/usr/bin/env bash
set -euo pipefail

# Prioridade: variável de ambiente > arquivo .slack_webhook
URL="${SLACK_WEBHOOK:-}"
if [[ -z "${URL}" && -f ".slack_webhook" ]]; then
  URL="$(< .slack_webhook)"
fi

if [[ -z "${URL}" ]]; then
  echo "[slack] webhook não configurado (SLACK_WEBHOOK vazio e sem .slack_webhook)"
  exit 0
fi

MSG="${1:-"(sem mensagem)"}"

curl -sS -X POST -H 'Content-type: application/json' \
  --data "{\"text\":\"${MSG}\"}" \
  "${URL}" >/dev/null || true
