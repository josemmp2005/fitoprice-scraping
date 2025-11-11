# Usa la imagen oficial de n8n
FROM n8nio/n8n:latest

# Crea carpeta de workflows
WORKDIR /data

# Copia el workflow exportado al contenedor
COPY workflows /data/workflows

# Ejecuta el workflow directamente
# ⚠️ Cambia 'scraper_fitoprice.json' por el nombre real de tu archivo
CMD ["n8n", "execute", "--input=/data/workflows/scraper_fitoprice.json"]
