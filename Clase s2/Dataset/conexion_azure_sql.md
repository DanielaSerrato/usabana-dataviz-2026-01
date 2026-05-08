# Conexión a Azure SQL Database — tabla `vendedores`

La dimensión `vendedores` está alojada en **Azure SQL Database** para que practiquen el conector SQL real de Power BI Desktop.

## Datos de conexión

| Campo | Valor |
|-------|-------|
| **Servidor** | `dataviz2026.database.windows.net` |
| **Base de datos** | `free-sql-db-1889055` |
| **Tabla** | `vendedores` |
| **Tipo de autenticación** | SQL Server Authentication |
| **Usuario / contraseña** | (los entrega la docente en clase) |

> ⚠️ Las credenciales NUNCA se versionan en este repo. La docente las comparte por canal interno del curso al inicio del Bloque 1 y se rotan después de la sesión.

---

## Paso a paso desde Power BI Desktop

### 1. Iniciar la conexión

1. Abre **Power BI Desktop**.
2. **Inicio → Obtener datos → Más…**
3. En la búsqueda, escribe **SQL Server**.
4. Selecciona **Base de datos SQL Server** y haz clic en **Conectar**.

### 2. Configurar servidor y base de datos

En el diálogo:

| Campo | Qué poner |
|-------|-----------|
| **Servidor** | `dataviz2026.database.windows.net` |
| **Base de datos** (opcional) | `free-sql-db-1889055` |
| **Modo de conectividad de datos** | **Importar** (no DirectQuery — el dataset es chico) |

Despliega **Opciones avanzadas** y verifica:
- **Tiempo de espera de comando:** dejar vacío (default).
- **Instrucción SQL:** vacía. Vamos a usar el navegador para elegir tabla.

Clic en **Aceptar**.

### 3. Autenticarse

Aparece un diálogo lateral con 3 opciones de auth.

1. Selecciona **Base de datos** (es **SQL Server Authentication**, NO "Windows" ni "Cuenta Microsoft").
2. Ingresa:
   - **Nombre de usuario:** (la docente lo entrega)
   - **Contraseña:** (la docente la entrega)
3. Marca **Aplicar a este nivel:** `dataviz2026.database.windows.net`.
4. Clic en **Conectar**.

### 4. Aprobar el certificado (si aparece)

La primera vez puede salir un mensaje "*El proveedor no admite el cifrado*" o algo similar. Acepta para continuar — Azure SQL fuerza cifrado TLS y Power BI lo respeta.

### 5. Seleccionar la tabla en el navegador

1. Se abre el panel **Navegador**.
2. Despliega `free-sql-db-1889055` → `Tablas`.
3. Marca el checkbox de **`vendedores`**.
4. **Vista previa** a la derecha: deberías ver columnas `id_vendedor`, `nombre`, `equipo`, `supervisor`, `pais`, `fecha_ingreso`, `activo` y 100 filas.
5. Clic en **Transformar datos** (NO "Cargar" — pasamos por Power Query como con los Excel).

### 6. Renombrar la consulta

En el Editor de Power Query, en el panel **Consultas** (izquierda), renombra `vendedores` → `dim_vendedores` para mantener convención del modelo (`fact_*` para hechos, `dim_*` para dimensiones).

---

## Validaciones

Antes de cerrar y aplicar, verifica:

- [ ] La consulta `dim_vendedores` aparece con ícono de SQL Server.
- [ ] **100 filas** en el conteo inferior.
- [ ] Columnas tipadas correctamente:
  - `id_vendedor` → Número entero
  - `nombre`, `equipo`, `supervisor`, `pais` → Texto
  - `fecha_ingreso` → Fecha
  - `activo` → Verdadero/Falso (lógico)
- [ ] Sin errores de tipo en ninguna columna.
- [ ] Distribución por país (perfilado): 5 países × 20 vendedores cada uno.

---

## Query folding (concepto avanzado)

Una ventaja de SQL sobre Excel/CSV: Power Query puede "doblar" (folding) algunos pasos a SQL, ejecutándolos en el servidor en vez de localmente.

**Ejercicio:** después de cargar `dim_vendedores`, agrega un paso para filtrar `activo = TRUE`. Luego clic derecho en el último paso → **Ver consulta nativa**.

- Si la opción está activa → el paso se folding (se traduce a `SELECT ... WHERE activo = 1`).
- Si está gris → el paso NO se folding y Power Query trae todos los datos y filtra localmente.

**Pregunta de discusión:** ¿qué pasos rompen el folding? (Pista: transformaciones específicas de M, columnas a partir de ejemplos, ciertos tipos de merge.)

---

## Si la conexión falla

| Error | Causa probable | Solución |
|-------|----------------|----------|
| `Could not open a connection to SQL Server` | Firewall de Azure no permite tu IP | Decirle a la docente para que agregue la IP. En clase ya está abierto a la red del aula. |
| `Login failed for user '...'` | Usuario/contraseña mal escrita o credenciales rotadas | Verificar credenciales. Pega-las desde el chat sin espacios. |
| `Cannot connect — server name or DB invalid` | Typo en servidor o BD | Servidor exacto: `dataviz2026.database.windows.net` (todo en minúsculas). BD exacta: `free-sql-db-1889055`. |
| `SSL/TLS error` | Política de cifrado | Aceptar el diálogo "El proveedor no admite cifrado". |

---

## Para los curiosos: ejecutar SQL puro

Si quieres ejecutar consultas directas (sin Power BI):

**Opciones de cliente SQL:**
- **Azure Data Studio** (gratis, multi-plataforma) — recomendado.
- **SQL Server Management Studio (SSMS)** — Windows.
- **DBeaver** (gratis, multi-plataforma).
- **Visual Studio Code + extensión SQL Server**.

**Connection string (para `sqlcmd` u otros):**

```
Server=tcp:dataviz2026.database.windows.net,1433;
Initial Catalog=free-sql-db-1889055;
Persist Security Info=False;
User ID=<usuario>;
Password=<contraseña>;
MultipleActiveResultSets=False;
Encrypt=True;
TrustServerCertificate=False;
Connection Timeout=30;
```

**Consulta de prueba:**

```sql
SELECT pais, COUNT(*) AS n_vendedores, SUM(CAST(activo AS INT)) AS n_activos
FROM dbo.vendedores
GROUP BY pais
ORDER BY pais;
```

Salida esperada:

```
Argentina | 20 | ~19
Colombia  | 20 | ~19
España    | 20 | ~19
Estados Unidos | 20 | ~18
México    | 20 | ~19
```

(Los activos varían ligeramente por la aleatoriedad del seed: ~93% activos.)

---

## Reproducir esta tabla en otro entorno

Si quieres recrear esta tabla en SQL Server local, Azure SQL nuevo, PostgreSQL, etc., usa el script:

```
s2_powerbi_etl_modelado_dax/datasets/central_perk_global/vendedores.sql
```

(Ajustar tipos `BIT` → `BOOLEAN` para PostgreSQL, etc.)
