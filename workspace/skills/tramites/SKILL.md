---
name: tramites-municipales
description: Consulta el sistema de trámites municipales usando mcporter y el servidor MCP.
metadata:
  moltbot:
    requires:
      bins:
        - mcporter
---

# Skill: Trámites Municipales

Herramienta para consultar el sistema de trámites municipales via MCP.

## Cómo ejecutar herramientas

Ejecutar comandos con mcporter:
```bash
mcporter call mi-servidor-mcp.<nombre_herramienta> <parametro>:<valor>
```

## Herramientas disponibles

### Consultar solicitud por ID
```bash
mcporter call mi-servidor-mcp.estado_solicitud_por_id request_id:12345
```
Usar cuando el usuario da un número de solicitud.

### Ver historial de usuario
```bash
mcporter call mi-servidor-mcp.listar_solicitudes_por_dni dni_usuario:12345678
```
Usar cuando el usuario quiere ver todas sus solicitudes.

### Consultar última solicitud de un trámite
```bash
mcporter call mi-servidor-mcp.estado_ultima_solicitud_usuario dni_usuario:12345678 nombre_tramite:"Renovación"
```
Usar cuando preguntan "¿cómo va mi licencia?" o similar.

### Ver mensajes de una solicitud
```bash
mcporter call mi-servidor-mcp.consultar_mensajes_solicitud request_id:12345
```

### Reporte del día
```bash
mcporter call mi-servidor-mcp.reporte_solicitudes_hoy
```
Solo para agentes autorizados.

### Estadísticas por estado
```bash
mcporter call mi-servidor-mcp.cantidad_solicitudes_por_estado nombre_estado:"pendiente"
```

### Productividad de agente
```bash
mcporter call mi-servidor-mcp.consultar_atenciones_agente dni_agente:99999999 fecha_inicio:2025-01-01 fecha_fin:2025-01-31
```

### Listar herramientas
```bash
mcporter call mi-servidor-mcp.list_available_reports
```

## Flujo de trabajo

1. Usuario pide información → Identificar herramienta
2. Verificar datos necesarios (DNI: 7-8 dígitos, ID solicitud)
3. Ejecutar comando mcporter
4. Presentar resultados claramente

## Importante

- NUNCA inventar información
- Verificar identidad antes de dar datos sensibles
- Si mcporter falla, informar al usuario