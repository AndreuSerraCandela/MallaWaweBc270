# Manual de Lista de Espera - MallaWawe2

## Índice
1. [Introducción](#introducción)
2. [Conceptos Básicos](#conceptos-básicos)
3. [Estructura de Datos](#estructura-de-datos)
4. [Funcionalidades Principales](#funcionalidades-principales)
5. [Procesos de Trabajo](#procesos-de-trabajo)
6. [Páginas y Acciones](#páginas-y-acciones)
7. [Configuración](#configuración)
8. [Casos de Uso](#casos-de-uso)
9. [Troubleshooting](#troubleshooting)

---

## Introducción

La **Lista de Espera** es una funcionalidad del sistema MallaWawe2 que permite gestionar las solicitudes de recursos cuando estos no están disponibles inmediatamente. Esta funcionalidad es especialmente útil en el sector de la publicidad exterior, donde los recursos (vallas publicitarias, marquesinas, etc.) pueden estar ocupados o bloqueados por diferentes motivos.

### Objetivos
- Gestionar solicitudes de recursos no disponibles
- Mantener un registro de clientes interesados en recursos específicos
- Facilitar la asignación de recursos cuando se liberan
- Mejorar la satisfacción del cliente mediante seguimiento de solicitudes

---

## Conceptos Básicos

### ¿Qué es la Lista de Espera?
La Lista de Espera es un sistema de gestión de solicitudes que permite:
- Registrar clientes interesados en recursos específicos
- Mantener un historial de solicitudes
- Notificar cuando un recurso se libera
- Convertir solicitudes en reservas reales

### Tipos de Motivos de Incidencia
El sistema maneja diferentes tipos de motivos para las incidencias de recursos:

| Valor | Descripción | Tipo de Bloqueo |
|-------|-------------|-----------------|
| 0 | Baja | Bloqueo |
| 1 | Reparación | Bloqueo |
| 2 | Bloqueo | Bloqueo |
| 3 | Fin Concesión | Bloqueo |
| 4 | Obras | Bloqueo |
| **5** | **Lista de espera** | **Información** |
| 6 | Otros | Bloqueo |
| 7 | Sin Incidencia | - |

**Nota**: La "Lista de espera" es el único motivo que se clasifica como "Información" en lugar de "Bloqueo".

---

## Estructura de Datos

### Tabla Principal: Incidencias Recursos (7001178)

#### Campos Clave
```al
field(1; "Nº Incidencia"; Integer) // Clave primaria
field(5; "Fecha inicio"; Date) // Fecha de inicio de la solicitud
field(10; "Fecha fin"; Date) // Fecha de fin de la solicitud
field(6; Motivo; Enum "Motivo Incidencia") // Tipo de incidencia
field(15; "Nº Recurso"; Code[20]) // Código del recurso
field(20; Descripción; Text[100]) // Descripción del recurso
field(30; "Cód. Cliente"; Code[20]) // Cliente solicitante
field(35; "Nº Proyecto"; Code[20]) // Proyecto asociado
field(47; Vendedor; Code[20]) // Vendedor responsable
field(48; "Fecha cancelación"; Date) // Fecha de cancelación
field(49; "Observaciones"; Text[250]) // Observaciones adicionales
```

#### Claves de Búsqueda
- **Principal**: Nº Incidencia (clustered)
- **Proyecto**: Nº Proyecto, Cód. fase, Cód. subfase, Cód. tarea, Tipo (presupuesto), Nº (presupuesto)
- **Recurso**: Nº Recurso, Fecha inicio, Fecha fin
- **Fase**: Nº Proyecto, Cód. subfase, Fecha inicio
- **Fecha**: Nº Proyecto, Fecha inicio
- **Proy_Res**: Nº Proyecto, Nº Recurso, Fecha inicio
- **Agrupado**: Nº Proyecto, Recurso Agrupado

### Tabla de Diario: Diario Incidencias Recursos
Esta tabla mantiene un registro diario de todas las incidencias, permitiendo consultas por fecha específica.

---

## Funcionalidades Principales

### 1. Creación de Solicitudes de Lista de Espera

#### Desde la Lista de Recursos
```al
// Acción: "Añadir a Lista Espera"
action("Añadir a Lista Espera")
{
    // Permite añadir un recurso a la lista de espera
    // Requiere seleccionar cliente y vendedor
    // Crea automáticamente una incidencia con motivo "Lista de espera"
}
```

#### Desde Líneas de Proyecto
```al
// Función: Crear ListaEspera
PROCEDURE "Crear ListaEspera"(VAR rLinPresup: Record 1003; RecursoAgrupado: Code[20]; Linea: Integer; EsAgrupado: Boolean);
```

### 2. Gestión de Solicitudes

#### Visualización
- **Página Principal**: Lista Espera Recursos (50108)
- **Filtros por defecto**: Solo solicitudes no canceladas
- **Filtro automático**: Motivo = "Lista de espera"

#### Acciones Disponibles
- **Cancelar Solicitud**: Marca la solicitud como cancelada
- **Asignar Recurso**: Convierte la solicitud en una reserva real
- **Ver Fichas**: Acceso directo a fichas de recurso, cliente y vendedor

### 3. Conversión a Reserva

#### Proceso de Asignación
```al
action(Asignar)
{
    // 1. Verifica que existe un proyecto asociado
    // 2. Crea una línea de planificación de proyecto
    // 3. Marca la solicitud como asignada
    // 4. Actualiza observaciones con fecha de asignación
}
```

---

## Procesos de Trabajo

### Flujo Típico de Lista de Espera

1. **Detección de Recurso No Disponible**
   - Cliente solicita un recurso
   - Sistema verifica disponibilidad
   - Recurso está ocupado o bloqueado

2. **Creación de Solicitud**
   - Se crea una incidencia con motivo "Lista de espera"
   - Se registra cliente, vendedor y fechas
   - Se añaden observaciones automáticas

3. **Seguimiento**
   - La solicitud aparece en la lista de espera
   - Se puede consultar desde múltiples puntos del sistema
   - Se mantiene actualizada la información

4. **Liberación del Recurso**
   - Cuando el recurso se libera, se puede asignar
   - Sistema permite convertir la solicitud en reserva
   - Se actualiza el estado de la incidencia

5. **Finalización**
   - Solicitud se marca como cancelada o asignada
   - Se mantiene el historial para consultas futuras

### Integración con Otros Módulos

#### Comerciales
```al
// Acción en ficha de comercial
action("Ver Lista Espera")
{
    // Muestra lista de espera filtrada por vendedor
    // Rango de fechas: -3 meses a +3 meses desde hoy
}
```

#### Recursos
```al
// Indicador visual en lista de recursos
// Los recursos en lista de espera se muestran con color especial
if ListaEspera.FindSet then Color := 'StandardAccent';
```

---

## Páginas y Acciones

### Página Principal: Lista Espera Recursos (50108)

#### Características
- **Tipo**: Lista editable
- **Tabla origen**: Incidencias Recursos
- **Filtro automático**: Motivo = "Lista de espera"
- **Filtro por defecto**: Solo no canceladas

#### Campos Mostrados
- Nº Incidencia
- Nº Recurso
- Descripción
- Fecha inicio
- Cód. Cliente
- Vendedor
- Fecha cancelación
- Observaciones

#### Acciones de Navegación
- **Ficha Recurso**: Acceso directo a la ficha del recurso
- **Ficha Cliente**: Acceso directo a la ficha del cliente
- **Ficha Vendedor**: Acceso directo a la ficha del vendedor

#### Acciones de Procesamiento
- **Cancelar Solicitud**: Marca como cancelada
- **Asignar Recurso**: Convierte en reserva

### Extensiones de Páginas

#### Lista de Recursos
```al
// Acción para añadir a lista de espera
action("Añadir a Lista Espera")
{
    // Requiere selección de cliente y vendedor
    // Crea incidencia automáticamente
}

// Acción para ver lista de espera
action("Ver Lista Espera")
{
    // Abre la página de lista de espera
}
```

#### Ficha de Comercial
```al
// Acción para ver lista de espera del comercial
action("Ver Lista Espera")
{
    // Filtra por vendedor y rango de fechas
    // Rango: -3 meses a +3 meses desde hoy
}
```

---

## Configuración

### Configuración de Motivos
Los motivos de incidencia se configuran en el enum `Motivo Incidencia` (7001148):

```al
Enum 7001148 "Motivo Incidencia"
{
    value(5; "Lista de espera")
    {
        Caption = 'Lista de espera';
    }
}
```

### Configuración de Bloqueos
El tipo de bloqueo se configura automáticamente según el motivo:

```al
Motivo::"Lista de espera":
begin
    "Incidencia de Bloqueo" := "Incidencia de Bloqueo"::Informacion;
end;
```

### Configuración de Triggers
La tabla de incidencias incluye triggers automáticos:

#### OnInsert
- Crea entradas en el diario de incidencias para cada día del rango
- Registra información completa de la solicitud

#### OnModify
- Actualiza el diario de incidencias
- Mantiene sincronización entre tabla principal y diario

#### OnDelete
- Elimina entradas relacionadas en el diario de incidencias
- Mantiene integridad referencial

---

## Casos de Uso

### Caso 1: Cliente Solicita Recurso Ocupado

**Escenario**: Un cliente solicita una valla publicitaria que está ocupada hasta el próximo mes.

**Proceso**:
1. Comercial verifica disponibilidad del recurso
2. Recurso no está disponible en las fechas solicitadas
3. Comercial selecciona "Añadir a Lista Espera"
4. Sistema solicita información del cliente y proyecto
5. Se crea incidencia con motivo "Lista de espera"
6. Cliente queda registrado para notificación

**Resultado**: Cliente queda en lista de espera y será notificado cuando el recurso se libere.

### Caso 2: Liberación de Recurso

**Escenario**: Un recurso se libera antes de lo previsto.

**Proceso**:
1. Sistema detecta liberación del recurso
2. Se consulta lista de espera para ese recurso
3. Se notifica a los clientes en orden de prioridad
4. Se puede asignar directamente desde la lista de espera
5. Se convierte la solicitud en reserva real

**Resultado**: Cliente obtiene el recurso y se crea la reserva correspondiente.

### Caso 3: Seguimiento por Comercial

**Escenario**: Un comercial quiere revisar todas sus solicitudes pendientes.

**Proceso**:
1. Comercial accede a su ficha
2. Selecciona "Ver Lista Espera"
3. Sistema muestra solicitudes filtradas por vendedor
4. Rango de fechas: -3 meses a +3 meses
5. Comercial puede gestionar cada solicitud

**Resultado**: Comercial tiene visibilidad completa de sus solicitudes pendientes.

---

## Troubleshooting

### Problemas Comunes

#### 1. Solicitud no aparece en la lista
**Causa posible**: Filtro de fecha cancelación
**Solución**: Verificar que el campo "Fecha cancelación" esté vacío

#### 2. Error al asignar recurso
**Causa posible**: Proyecto no especificado
**Solución**: Asegurar que el campo "Nº Proyecto" esté completado

#### 3. Recurso no se muestra como disponible
**Causa posible**: Incidencia de bloqueo activa
**Solución**: Verificar diario de incidencias para el recurso y fechas

#### 4. Duplicación de solicitudes
**Causa posible**: Múltiples inserciones
**Solución**: Verificar triggers de la tabla y validaciones

### Validaciones del Sistema

#### Validaciones Automáticas
- **Fechas**: Fecha inicio debe ser menor o igual a fecha fin
- **Recurso**: Debe existir en la tabla de recursos
- **Cliente**: Debe existir en la tabla de clientes
- **Vendedor**: Debe existir en la tabla de comerciales

#### Validaciones de Negocio
- **Disponibilidad**: Verificación de bloqueos existentes
- **Proyecto**: Requerido para asignación
- **Permisos**: Verificación de permisos de usuario

### Logs y Auditoría

#### Información Registrada
- **Usuario creación**: Se registra automáticamente
- **Fecha creación**: Timestamp de creación
- **Observaciones**: Historial de cambios
- **Diario**: Entrada diaria para cada día del rango

#### Consultas de Auditoría
```sql
-- Solicitudes por vendedor
SELECT Vendedor, COUNT(*) 
FROM "Incidencias Rescursos" 
WHERE Motivo = 5 AND "Fecha cancelación" = 0D
GROUP BY Vendedor;

-- Solicitudes por recurso
SELECT "Nº Recurso", COUNT(*) 
FROM "Incidencias Rescursos" 
WHERE Motivo = 5 AND "Fecha cancelación" = 0D
GROUP BY "Nº Recurso";
```

---

## Conclusión

La funcionalidad de Lista de Espera en MallaWawe2 proporciona una solución completa para la gestión de solicitudes de recursos no disponibles. Su integración con el sistema de reservas y la gestión de proyectos permite un flujo de trabajo eficiente que mejora la satisfacción del cliente y optimiza la utilización de recursos.

### Beneficios Clave
- **Gestión centralizada** de solicitudes pendientes
- **Seguimiento automático** de disponibilidad
- **Integración completa** con el sistema de reservas
- **Visibilidad** para comerciales y gestores
- **Historial completo** de solicitudes y asignaciones

### Mejoras Futuras Sugeridas
- Notificaciones automáticas por email
- Dashboard de métricas de lista de espera
- Integración con calendario de recursos
- Reportes de eficiencia de asignación 