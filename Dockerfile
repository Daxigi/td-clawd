# Imagen base con Node.js
FROM node:22-slim

# Instalar git y dependencias
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Instalar clawdbot y mcporter globalmente (como root)
RUN npm install -g clawdbot@latest mcporter@latest

# Crear directorios necesarios
RUN mkdir -p /home/node/.clawdbot \
             /home/node/.mcporter \
             /home/node/clawd/skills/tramites \
    && chown -R node:node /home/node

# Cambiar a usuario node
USER node
WORKDIR /home/node

# Puerto del gateway
EXPOSE 18789

# Comando de inicio
CMD ["clawdbot", "gateway", "--port", "18789"]