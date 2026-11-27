#!/bin/sh
# Ejecuta un workflow de n8n una vez (lo usa el Dockerfile). WORKFLOW elige cuál.
set -u
n8n import:workflow --separate --input=/workflows > /dev/null || exit 1

echo "Ejecutando $WORKFLOW contra $FITOPRICE_API_URL"
if n8n execute --id="$WORKFLOW" > /tmp/run.log 2>&1; then
  echo "$WORKFLOW terminado correctamente"
else
  echo "$WORKFLOW ha fallado. Final de la salida de n8n:"
  tail -c 4000 /tmp/run.log
  exit 1
fi
