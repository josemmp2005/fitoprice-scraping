# Imagen que ejecuta UN workflow de n8n una vez y termina. La usa GitHub Actions
# (.github/workflows) para leer los precios cada día y el registro oficial cada semana
# sin tener n8n encendido todo el tiempo. En local no hace falta: n8n corre con el
# docker-compose del backend.
#
#   docker build -t fitoprice-n8n .
#   docker run --rm -e FITOPRICE_API_URL=https://tu-api -e FITOPRICE_API_KEY=... fitoprice-n8n
#   docker run --rm -e WORKFLOW=FitoPriceRegOfic -e FITOPRICE_API_URL=... -e FITOPRICE_API_KEY=... fitoprice-n8n
FROM n8nio/n8n:3.2.2

# Los workflows leen la URL y la clave de la API con $env
ENV N8N_BLOCK_ENV_ACCESS_IN_NODE=false \
    N8N_DIAGNOSTICS_ENABLED=false \
    GENERIC_TIMEZONE=Europe/Madrid \
    WORKFLOW=FitoPriceScraper

COPY workflows /workflows

# Importa los workflows y ejecuta el de WORKFLOW (FitoPriceScraper o FitoPriceRegOfic).
# n8n escribe en la salida todo el resultado (megas con el registro oficial): se guarda en un
# archivo y solo se enseña el final si falla. Con error, el contenedor sale con código 1
# y la ejecución de GitHub Actions queda en rojo.
COPY run.sh /run.sh
ENTRYPOINT ["tini", "--", "/bin/sh", "/run.sh"]
