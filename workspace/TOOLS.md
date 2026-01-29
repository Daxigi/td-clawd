# Herramientas Externas

## Servidor MCP - Trámites Municipales

Este agente está conectado a un servidor MCP que proporciona acceso a la base de datos de trámites municipales.

### Conexión

- **URL**: http://host.docker.internal:8876/sse
- **Protocolo**: MCP sobre SSE (Server-Sent Events)

### Herramientas Disponibles

#### 1. `estado_solicitud_por_id`
Consulta el estado de una solicitud específica.

**Parámetros:**
- `request_id` (integer): Número de la solicitud

**Ejemplo de uso:**
- Usuario: "¿Cómo va mi solicitud 12345?"
- Acción: Llamar `estado_solicitud_por_id(request_id=12345)`

---

#### 2. `estado_ultima_solicitud_usuario`
Consulta la última solicitud de un trámite para un usuario.

**Parámetros:**
- `dni_usuario` (string): DNI del ciudadano
- `nombre_tramite` (string): Nombre exacto del trámite

**Ejemplo de uso:**
- Usuario: "Soy DNI 12345678, ¿cómo va mi renovación de licencia?"
- Acción: Llamar `estado_ultima_solicitud_usuario(dni_usuario="12345678", nombre_tramite="Renovación de Licencias de Conducir para Particulares")`

---

#### 3. `listar_solicitudes_por_dni`
Lista todas las solicitudes de un usuario.

**Parámetros:**
- `dni_usuario` (string): DNI del ciudadano

**Ejemplo de uso:**
- Usuario: "¿Qué trámites tengo? Mi DNI es 12345678"
- Acción: Llamar `listar_solicitudes_por_dni(dni_usuario="12345678")`

---

#### 4. `consultar_mensajes_solicitud`
Obtiene los mensajes de una solicitud.

**Parámetros:**
- `request_id` (integer): Número de la solicitud

---

#### 5. `reporte_solicitudes_hoy`
Genera reporte de solicitudes del día actual.

**Parámetros:** Ninguno

**Restricción:** Solo para agentes municipales autorizados.

---

#### 6. `cantidad_solicitudes_por_estado`
Cuenta solicitudes por estado.

**Parámetros:**
- `nombre_estado` (string): Estado a buscar (ej: "Pendiente", "En Revisión")
- `nombre_tramite` (string, opcional): Filtrar por trámite específico

---

#### 7. `consultar_atenciones_agente`
Productividad de un agente en un período.

**Parámetros:**
- `dni_agente` (string): DNI del agente
- `fecha_inicio` (string): Fecha inicio (YYYY-MM-DD)
- `fecha_fin` (string): Fecha fin (YYYY-MM-DD)

**Restricción:** Solo para agentes municipales autorizados.

---

#### 8. `consultar_atenciones_agente_por_tramite`
Productividad filtrada por trámite.

**Parámetros:**
- `dni_agente` (string): DNI del agente
- `nombre_tramite` (string): Nombre del trámite
- `fecha_inicio` (string): Fecha inicio
- `fecha_fin` (string): Fecha fin

---

### Nombres de Trámites Válidos

Para usar las herramientas que requieren `nombre_tramite`, usar estos nombres exactos:

1. Licencia de conducir primera vez para Particulares
2. Renovación de Licencias de Conducir para Particulares
3. Renovación Licencia de Conducir para profesionales
4. Duplicado de Licencia de Conducir
5. Duplicado con cambio de datos de Licencia de Conducir
6. Ampliación de Licencia de Conducir
7. Renovación con ampliación de Licencia de Conducir
8. Libreta Sanitaria
9. Habilitación de vehículos de transporte por plataforma electrónica
10. Renovación de habilitación de remises
11. Renovación de habilitación de taxis
12. Cambio de chofer para servicio de remis