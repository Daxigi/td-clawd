# Clawdbot - Asistente Municipal

Configuración de Clawdbot para el sistema de trámites municipales.

## Requisitos

- Docker y Docker Compose
- API Key de Anthropic (https://console.anthropic.com/)
- (Opcional) Token de Bot de Telegram

## Instalación Rápida

```bash
# 1. Dar permisos al script
chmod +x scripts/setup.sh

# 2. Ejecutar setup
./scripts/setup.sh

# 3. Configurar API Key
nano .env
# Cambiar ANTHROPIC_API_KEY=sk-ant-api03-TU_KEY_AQUI

# 4. Iniciar
docker compose up -d

# 5. Ver logs
docker compose logs -f
```

## Acceso al Dashboard

1. Abrir: http://localhost:18789
2. Usar el token de `.env` para autenticarse

## Estructura de Archivos

```
clawdbot-server/
├── docker-compose.yml    # Configuración de Docker
├── .env                  # Variables de entorno (NO commitear)
├── .env.example          # Ejemplo de variables
├── config/
│   └── clawdbot.json     # Configuración principal
├── workspace/
│   ├── SOUL.md           # Personalidad del asistente
│   └── AGENTS.md         # Herramientas disponibles
└── scripts/
    └── setup.sh          # Script de instalación
```

## Configuración de Seguridad

El archivo `config/clawdbot.json` tiene estas restricciones por defecto:

- **Sandbox activado**: El agente no puede ejecutar comandos peligrosos
- **Rate limiting**: Máximo 10 msgs/minuto, 200 msgs/día
- **Herramientas bloqueadas**: bash, browser, write, edit
- **Solo Telegram**: WhatsApp y Discord deshabilitados

## Comandos Útiles

```bash
# Iniciar
docker compose up -d

# Detener
docker compose down

# Ver logs en tiempo real
docker compose logs -f

# Reiniciar
docker compose restart

# Verificar estado
docker compose ps
```

## Integración con MCP Server

Para conectar con tu servidor MCP existente:

1. Editar `docker-compose.yml`:
```yaml
networks:
  clawdbot-network:
    external: true
    name: shared-network  # Tu red existente
```

2. Agregar MCP como herramienta en Clawdbot (configuración avanzada)

## Solución de Problemas

### El contenedor no inicia
```bash
docker compose logs clawdbot
```

### No puedo acceder al dashboard
- Verificar que el puerto 18789 no esté en uso
- Verificar firewall local

### Error de autenticación
- Verificar que ANTHROPIC_API_KEY sea válida
- Revisar token en .env

## Seguridad

⚠️ **IMPORTANTE**:
- NUNCA subir `.env` a Git
- Rotar API keys periódicamente
- Mantener el puerto 18789 solo accesible localmente
- En producción, usar Tailscale o VPN

## Comandos de pairing

- Ver solicitudes pendientes
docker exec -it clawdbot-gateway clawdbot pairing list telegram

- Aprobar un agente
docker exec -it clawdbot-gateway clawdbot pairing approve telegram <código>

- Rechazar
docker exec -it clawdbot-gateway clawdbot pairing reject telegram <código>

- Ver usuarios aprobados
docker exec -it clawdbot-gateway clawdbot pairing status telegram
