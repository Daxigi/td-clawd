#!/bin/bash
# ============================================
# Script de Setup para Clawdbot
# ============================================

set -e

echo "============================================"
echo "  CLAWDBOT - Setup Inicial"
echo "============================================"
echo ""

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# 1. Verificar Docker
info "Verificando Docker..."
if ! command -v docker &> /dev/null; then
    error "Docker no está instalado. Por favor instálalo primero."
fi

if ! docker compose version &> /dev/null; then
    error "Docker Compose no está disponible."
fi
info "Docker OK ✓"

# 2. Crear archivo .env si no existe
if [ ! -f .env ]; then
    info "Creando archivo .env..."
    cp .env.example .env
    
    # Generar token seguro
    if command -v openssl &> /dev/null; then
        TOKEN=$(openssl rand -hex 32)
    else
        TOKEN=$(python3 -c "import secrets; print(secrets.token_hex(32))")
    fi
    
    # Reemplazar token en .env
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s/CAMBIAR_POR_TOKEN_SEGURO_DE_64_CARACTERES/$TOKEN/" .env
    else
        # Linux
        sed -i "s/CAMBIAR_POR_TOKEN_SEGURO_DE_64_CARACTERES/$TOKEN/" .env
    fi
    
    warn "Archivo .env creado. DEBES configurar tu ANTHROPIC_API_KEY"
    echo ""
    echo "  Token generado automáticamente: $TOKEN"
    echo ""
else
    info "Archivo .env ya existe ✓"
fi

# 3. Crear directorios necesarios
info "Creando directorios..."
mkdir -p config/logs
mkdir -p workspace

# 4. Ajustar permisos
info "Ajustando permisos..."
chmod 700 config
chmod 600 .env 2>/dev/null || true

# 5. Verificar configuración
info "Verificando configuración..."
if grep -q "CAMBIAR_POR_TU_API_KEY" .env; then
    warn "⚠️  ANTHROPIC_API_KEY no configurada en .env"
    echo ""
    echo "  Para obtener tu API Key:"
    echo "  1. Ve a https://console.anthropic.com/"
    echo "  2. Crea una cuenta o inicia sesión"
    echo "  3. Genera una API Key"
    echo "  4. Pégala en el archivo .env"
    echo ""
fi

# 6. Mostrar siguiente paso
echo ""
echo "============================================"
echo "  Setup completado!"
echo "============================================"
echo ""
echo "Próximos pasos:"
echo ""
echo "  1. Edita el archivo .env con tu ANTHROPIC_API_KEY:"
echo "     nano .env"
echo ""
echo "  2. (Opcional) Configura Telegram Bot Token en .env"
echo ""
echo "  3. Inicia Clawdbot:"
echo "     docker compose up -d"
echo ""
echo "  4. Abre el dashboard en tu navegador:"
echo "     http://localhost:18789"
echo ""
echo "  5. Usa el token del archivo .env para autenticarte"
echo ""
echo "============================================"
