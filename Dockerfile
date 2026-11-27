# Imagen para ejecutar el scraping una sola vez (por ejemplo, desde un cron externo).
# En local no hace falta: n8n corre con el docker-compose del backend.
#
#   docker build -t fitoprice-scraper .
#   docker run --rm -e FITOPRICE_API_URL=... -e FITOPRICE_API_KEY=... fitoprice-scraper
FROM n8nio/n8n:3.2.2

# El workflow lee la URL y la clave de la API con $env
ENV N8N_BLOCK_ENV_ACCESS_IN_NODE=false \
    N8N_DIAGNOSTICS_ENABLED=false \
    GENERIC_TIMEZONE=Europe/Madrid

COPY workflows /workflows

# Importa el workflow y lo ejecuta una vez
ENTRYPOINT ["tini", "--", "/bin/sh", "-c"]
CMD ["n8n import:workflow --input=/workflows/scraper_fitoprice.json && n8n execute --id=FitoPriceScraper"]
