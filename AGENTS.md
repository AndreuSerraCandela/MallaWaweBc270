# Malla Wave 2.0 — guía para el agente

Extensión **Business Central OnPrem** (BC 27) — app base **Malla Wave 2.0**. Publisher: Grupo Malla by Andreu.

## Repos relacionados

| Repo | Ruta local | Rol |
|------|------------|-----|
| **Malla Wave 2.0** (este) | `C:\Users\Andres\Source\Bc\MallaWaweBc270` | App base: tablas, objetos core |
| **Funciones** | `C:\Users\Andres\Source\Bc\Funciones` | Extensiones, páginas, informes sobre tablas Malla |
| **Utilidades** | `C:\Users\Andres\Source\Bc\Utilidades` | Utilidades Malla |
| **MyBeLic** | `C:\Users\Andres\Source\Python\MyBeLic` | Panel y API en `https://license.malla.es` |
| **MyBeLic Publish Runner** | `C:\Users\Andres\Source\Python\MyBeLicPublishRunner` | Demonio bandeja → crea tareas publish/upgrade |
| **MgtExtBc** | `C:\Users\Andres\Source\Bc\MgtExtBc` | Codeunit OData para publicar en BC on-prem |
| **Objetos BC** | `C:\Users\Andres\Source\Python\Objetos` | Reserva IDs en `objetos.malla.es` |

App id Malla Wave 2.0: `7a7d3479-e693-4f3d-8336-aac424523182`  
Cliente MyBeLic Malla (por defecto): `4e27c722-48a2-4228-81c6-3317d20f98b1`

## Cuando el usuario pida compilar, subir versión o publicar en license

Interpretar frases como: *compila*, *sube versión*, *publica en license*, *copia a Malla*, *deploy MyBeLic*.

### 1. Subir versión

- Editar `aapp.json` → campo `version` (patch: `1.0.4.8` → `1.0.4.9`).
- Si cambian las dependencias, actualizar también su versión en `dependencies` y el `.app` en `.alpackages/`.

### 2. Compilar

Usar `alc.exe` (extensión AL de VS Code/Cursor):

```powershell
$alc = "$env:USERPROFILE\.cursor\extensions\ms-dynamics-smb.al-*\bin\win32\alc.exe"
$alc = (Get-Item $alc | Sort-Object LastWriteTime -Descending | Select-Object -First 1).FullName
& $alc /project:"C:\Users\Andres\Source\Bc\MallaWaweBc270" /packagecachepath:"C:\Users\Andres\Source\Bc\MallaWaweBc270\.alpackages"
```

El `.app` se genera en la raíz: `Grupo Malla by Andreu_Malla Wave 2.0_{version}.app`.

### 3. Publicar (elegir **una** vía — nunca ambas)

**Regla crítica:** el **MyBeLic Publish Runner** vigila el buzón (p. ej. `C:\apps\Malla`). **Cada copia de un `.app` al buzón dispara tareas de publicación.** No copiar dos veces el mismo fichero ni combinar buzón + API para el mismo despliegue.

#### Vía A — Buzón (actual, script existente)

Una sola copia con `.vscode/Build-And-CopyAppToMalla.ps1`:

```powershell
powershell -ExecutionPolicy Bypass -File ".vscode\Build-And-CopyAppToMalla.ps1" -WorkspaceFolder "C:\Users\Andres\Source\Bc\MallaWaweBc270"
```

- Destino: `C:\apps\Malla`
- El runner crea tarea **publish** (`auto_schedule`) y, si la versión es mayor que el catálogo MyBeLic (on-prem), **upgrade** +5 min después.
- **No** volver a copiar si el script ya respondió OK. **No** hacer copia manual de verificación.

#### Vía B — API MyBeLic (alternativa, sin buzón)

Documentación: `Python\MyBeLic\API.md`. Misma lógica que el runner (`processor.py`).

1. Cabecera: `X-MyBeLic-Token` (valor en `mybelic.env` / `publish_runner.env`; **no commitear**).
2. `POST /api/v1/admin/customers/{customer_id}/tasks` — `action=publish`, `auto_schedule=true`, multipart `app_file`.
3. Si versión nueva y cliente on-prem: `POST` — `action=upgrade`, mismo `.app`, `run_at` = publish + 5 min.
4. Opcional: `PATCH .../applications/{record_id}` con la nueva versión en catálogo.
5. Verificar: `GET /api/v1/admin/customers/{customer_id}/tasks`.

Si se usa la API, **no** copiar al buzón.

### 4. Orden si hay más apps

1. **Malla Wave 2.0** (este) — compilar, publicar.
2. Extensiones dependientes (**Funciones**, **Utilidades**, etc.) — actualizar dependencia en su `app.json`, compilar, publicar.

### 5. Cambios en tablas base

Este repositorio **es** la app base. Tras subir versión y publicar, copiar el `.app` a `.alpackages/` de las extensiones dependientes antes de compilarlas.

## IDs de objetos nuevos

Ver `.cursor/rules/bc-object-ids.mdc`. No inventar IDs; reservar en `objetos.malla.es`. Extensión en URL: `Malla Wave 2.0` (name de `aapp.json`).

## Convenciones de código

- Responder al usuario en **español**.
- Cambios mínimos; no commitear salvo petición explícita.
- No subir `.app`, `.alpackages` ni tokens al repositorio sin que lo pidan.
- Preprocessor: `CLEAN27`.

## Comandos útiles

| Acción | Comando / archivo |
|--------|-------------------|
| Copiar .app al buzón | `.vscode/Build-And-CopyAppToMalla.ps1` |
| Tarea VS Code | *Copiar .app a Malla* en `tasks.json` |
| Debug BC local | `.vscode/launch.json` → `local` (BC270) |
| API tareas MyBeLic | `GET .../api/v1/admin/customers/{id}/tasks` |

## Pendiente / mejora futura

Script `Schedule-AppToMyBeLic.ps1` (API directa + comprobación de tareas) y regla `.cursor/rules/mybelic-publish.mdc` — aún no creados; priorizar buzón único hasta entonces.
