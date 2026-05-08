# Ejercicios sugeridos por módulo · Central Perk Global

Cada módulo del curso aprovecha aspectos específicos del dataset. Esta guía está organizada para que el docente pueda seleccionar ejercicios según la sesión y profundidad.

---

## MÓDULO 1 — BI y modelado dimensional

### Ej 1.1 — Identificar hechos vs dimensiones
**Objetivo:** practicar la distinción granularidad fina vs gruesa.
- Sin abrir Power BI, lee los nombres de los archivos.
- Para cada uno, decide: ¿es tabla de hechos o de dimensión? Justifica.
- Resultado esperado: hechos = `ventas_*`, `metas_cross`, `devoluciones`. Dim = `productos`, `clientes`, `tiendas`, `vendedores`, `calendario`.

### Ej 1.2 — Diseñar el esquema en estrella
**Objetivo:** dibujar el modelo antes de implementarlo.
- En papel/Miro/Lucidchart: dibuja `fact_ventas` al centro y conecta las dimensiones.
- Marca cardinalidades (1:N) y dirección de filtro.
- ¿Qué relaciones serían inactivas? (Pista: 3 fechas en `ventas_2025`).

### Ej 1.3 — KPI vs métrica
**Objetivo:** identificar cuáles métricas son KPI ejecutivos.
- De esta lista, marca cuáles son KPI: total ventas, ticket promedio, ventas/m², tasa devolución, Friends Plus % de clientes, NPS, churn, MoM growth.
- Para cada KPI marca su umbral aceptable (acompaña con tu intuición de negocio).

---

## MÓDULO 2 — Power Query (limpieza)

### Ej 2.1 — Cargar `ventas_2023.xlsx` y diagnosticar
**Objetivo:** practicar column profiling.
- Conecta a `ventas_2023.xlsx`. Activa Calidad, Distribución y Perfil de columnas.
- Cambia muestreo a "todo el conjunto de datos".
- Lista los 5 problemas más graves.

### Ej 2.2 — Limpiar fechas en 2 formatos (2023)
**Objetivo:** unificar formatos.
- Estrategia 1: cambiar tipo con configuración regional Español (Colombia).
- Estrategia 2: columna a partir de ejemplos.
- Verifica: 100% válido en `fecha`, rango entre 2023-01-01 y 2023-12-31.

### Ej 2.3 — Cargar `ventas_2024.xlsx` y renombrar columnas
**Objetivo:** preparar tablas para append cuando los esquemas difieren.
- Renombra todas las columnas para que coincidan con `ventas_2023`.
- Elimina `campo_temporal_no_usar` y `zona_horaria`.
- Resuelve los 5+ variantes de `canal` con reemplazos.

### Ej 2.4 — Limpiar fechas en 3 formatos (2024)
**Objetivo:** misma técnica con dificultad mayor.
- Usa "Columna a partir de ejemplos" porque los 3 formatos confunden a los algoritmos automáticos.
- Verifica.

### Ej 2.5 — Cargar `ventas_2025.xlsx` y manejar fechas serial
**Objetivo:** entender que Excel guarda fechas como números.
- ~55% de `fecha` viene como entero (ej. 45292).
- Solución: si es número, convertir con `Date.From(Number.From(...) - 25569)` o "Cambiar tipo → Fecha" después de identificar el formato.
- En M, `Date.From()` interpreta números como días desde 1900-01-01 (con offset Excel).

### Ej 2.6 — Multi-currency en 2025
**Objetivo:** normalizar moneda antes de modelar.
- Crea una columna calculada `importe_cop` que multiplique `importe` por la tasa de cambio según `moneda`.
- Tasas (ficticias): USD = 4000, MXN = 230, COP = 1, EUR = 4400, ARS = 1.18.
- Reemplaza `importe` por `importe_cop`.

### Ej 2.7 — Append de los 3 años
**Objetivo:** consolidar `fact_ventas`.
- Después de limpiar y renombrar, haz append de las 3 consultas.
- Resultado: ~50.000 filas. Verifica con conteo.
- Estrategia recomendada: dejar las 3 consultas individuales como "no cargar", solo cargar el append final.

### Ej 2.8 — Eliminar duplicados
**Objetivo:** detectar y quitar duplicados por PK lógica.
- Después del append, quita duplicados de `id_venta`.
- Cuenta antes y después.

### Ej 2.9 — Unpivot de `metas_cross.xlsx`
**Objetivo:** transformar wide → long.
- Carga `metas_cross.xlsx`.
- Filtra para quitar las filas "TOTAL" y "Notas: ...".
- Unpivot las 12 columnas de meses → 2 columnas: `anio_mes` y `meta`.
- Parsea `anio_mes` para extraer mes y año.
- Resultado: 60 filas (5 canales × 12 meses).

### Ej 2.10 — Merge para validación de huérfanos
**Objetivo:** detectar referencias inválidas.
- Merge `fact_ventas` con `productos` por `id_producto` (left outer).
- Filtra dónde `productos.nombre = null`.
- Cuenta y elimina las filas huérfanas (~0.6% del total).

### Ej 2.11 — Limpiar `devoluciones.csv`
**Objetivo:** normalización avanzada de texto.
- Normaliza `motivo`: trim + clean + capitalización consistente + reemplazos de sinónimos ("sabor malo" → "Sabor incorrecto").
- Detecta devoluciones con `fecha_devolucion < fecha_venta` (merge con ventas para validar).
- Detecta devoluciones con `importe_devuelto > importe` (merge + comparación).
- Decide: ¿descartar, marcar, mantener?

### Ej 2.12 — Limpiar `clientes.csv` (acentos y variantes)
**Objetivo:** aplicar normalización de texto a una dimensión.
- Normaliza `ciudad`: trim + capitalización + reemplazo de acentos quitados ("Bogota" → "Bogotá", etc.).
- Verifica que tras limpieza, los valores únicos cuadran con los de `tiendas.ciudad`.

---

## MÓDULO 3 — Power Query (avanzado)

### Ej 3.1 — Pivot inverso (long → wide)
**Objetivo:** practicar el inverso de unpivot, útil para reportes.
- A partir de `fact_ventas`, agrupa por categoría y mes.
- Pivot mes → columnas para tener una matriz tipo Excel.
- Comentario: este formato es FEO para Power BI; sirve solo para exportar a usuarios que prefieren matrices.

### Ej 3.2 — Conectarse a Azure SQL (tabla `vendedores`)
**Objetivo:** experiencia con conector SQL Server real contra una BD en la nube.
- Conector: **Base de datos SQL Server**.
- Servidor: `dataviz2026.database.windows.net`
- Base de datos: `free-sql-db-1889055`
- Auth: SQL Server (credenciales entregadas en clase).
- Cargar tabla `vendedores`, renombrar a `dim_vendedores` en Power Query.
- Validar 100 filas y tipos correctos.
- Si la conexión falla por firewall/credenciales: cargar `vendedores_referencia.csv` como fallback.

📘 Paso a paso completo: `conexion_azure_sql.md`

### Ej 3.3 — Parámetros y queries reutilizables
**Objetivo:** parametrizar la ruta del archivo.
- Crear parámetro `RutaDatos` con la carpeta de los datasets.
- Modificar todas las consultas para usar `RutaDatos & "/ventas_2023.xlsx"` etc.
- Compartir el `.pbix` con otro alumno y cambiar solo el parámetro.

### Ej 3.4 — Query folding (con la tabla Azure SQL)
**Objetivo:** identificar qué pasos se traducen a SQL (folding) y cuáles no.
- Sobre `dim_vendedores` (Azure SQL), aplicar pasos en este orden:
  1. Filtrar `activo = TRUE`
  2. Quitar columna `supervisor`
  3. Filtrar `pais = "Colombia"`
  4. Agregar columna a partir de ejemplos: extraer iniciales de `nombre`
- Después de cada paso, clic derecho → **Ver consulta nativa**.
- ¿En qué paso se vuelve gris la opción? Ese rompe el folding.
- Discutir: ¿qué transformaciones son seguras vs cuáles fuerzan a Power Query a traer todo y procesar localmente?

---

## MÓDULO 4 — Modelado

### Ej 4.1 — Crear las 3 relaciones a calendario
**Objetivo:** relaciones múltiples y activas/inactivas.
- En `fact_ventas` (consolidado), conectar `fecha` → `dim_calendario` (activa).
- Conectar `fecha_envio` y `fecha_entrega` → `dim_calendario` como inactivas.
- Verificar en vista de modelo: una línea sólida + dos punteadas.

### Ej 4.2 — Marcar `dim_calendario` como tabla de fechas
**Objetivo:** habilitar Time Intelligence.
- Clic derecho → Marcar como tabla de fechas.
- Validar con TOTALYTD.

### Ej 4.3 — Jerarquías
**Objetivo:** drill-down en visuales.
- Crear jerarquía Tiempo: año → trimestre → mes → día.
- Crear jerarquía Geo: país → región → ciudad → tienda.
- Crear jerarquía Producto: categoría → subcategoría → marca → producto.
- Ordenar `mes_nombre` por `mes_num`.

### Ej 4.4 — Star schema completo
**Objetivo:** llegar al modelo final.
- Verificar que las 3 hechos (ventas, metas, devoluciones) se conecten coherentemente.
- `fact_devoluciones` se conecta a `fact_ventas` por `id_venta` (en algunos modelos se desnormaliza directamente como hechos relacionados a las dimensiones).
- Discutir: ¿es mejor mantener devoluciones como tabla separada o agregar columnas a ventas?

### Ej 4.5 — Row-level security por país
**Objetivo:** RLS práctico.
- Crear rol "Gerente Colombia": filtro DAX `dim_tiendas[pais] = "Colombia"`.
- Probar con "View as".
- Verificar que las medidas de ventas se filtran al país.

---

## MÓDULO 5 — DAX básico

### Ej 5.1 — Medidas fundamentales
```dax
Total Ventas = SUM ( fact_ventas[importe] )
Cantidad Vendida = SUM ( fact_ventas[cantidad] )
Total Devoluciones = SUM ( fact_devoluciones[importe_devuelto] )
Ventas Netas = [Total Ventas] - [Total Devoluciones]
Tasa Devolucion % = DIVIDE ( [Total Devoluciones], [Total Ventas] )
```

### Ej 5.2 — Ticket promedio y márgenes
```dax
Ticket Promedio = DIVIDE ( [Total Ventas], DISTINCTCOUNT ( fact_ventas[id_venta] ) )

Total Costo =
SUMX (
    fact_ventas,
    RELATED ( dim_productos[costo] ) * fact_ventas[cantidad]
)

Margen $ = [Total Ventas] - [Total Costo]
Margen % = DIVIDE ( [Margen $], [Total Ventas] )
```

### Ej 5.3 — Distinct counts
```dax
Clientes Activos = DISTINCTCOUNT ( fact_ventas[id_cliente] )
Productos Vendidos = DISTINCTCOUNT ( fact_ventas[id_producto] )
Tiendas con Venta = DISTINCTCOUNT ( fact_ventas[id_tienda] )
```

---

## MÓDULO 6 — DAX avanzado

### Ej 6.1 — % del total con CALCULATE + ALL
```dax
% del Total por Categoria =
DIVIDE (
    [Total Ventas],
    CALCULATE ( [Total Ventas], ALL ( dim_productos[categoria] ) )
)
```
Validar que suma 100% al agregar.

### Ej 6.2 — Ranking
```dax
Ranking Producto =
RANKX ( ALL ( dim_productos[nombre] ), [Total Ventas],, DESC, DENSE )

Ranking Vendedor =
RANKX ( ALL ( dim_vendedores[nombre] ), [Total Ventas],, DESC, DENSE )
```

### Ej 6.3 — Time Intelligence
```dax
Ventas YoY = CALCULATE ( [Total Ventas], SAMEPERIODLASTYEAR ( dim_calendario[fecha] ) )
Crecimiento % YoY = DIVIDE ( [Total Ventas] - [Ventas YoY], [Ventas YoY] )
Ventas YTD = TOTALYTD ( [Total Ventas], dim_calendario[fecha] )
Ventas MTD = TOTALMTD ( [Total Ventas], dim_calendario[fecha] )
Ventas MoM = CALCULATE ( [Total Ventas], DATEADD ( dim_calendario[fecha], -1, MONTH ) )
```

### Ej 6.4 — USERELATIONSHIP (relaciones inactivas)
```dax
Ventas por Fecha de Envio =
CALCULATE (
    [Total Ventas],
    USERELATIONSHIP ( fact_ventas[fecha_envio], dim_calendario[fecha] )
)
```

### Ej 6.5 — Cumplimiento de meta
```dax
Meta Mensual =
SUM ( fact_metas[meta] )

Cumplimiento % =
DIVIDE ( [Total Ventas], [Meta Mensual] )

-- Visual: gráfico de barras canal × cumplimiento, con línea de 100%
```

### Ej 6.6 — ALLEXCEPT y filtros parciales
```dax
% Ventas Categoria en Pais =
DIVIDE (
    [Total Ventas],
    CALCULATE ( [Total Ventas], ALLEXCEPT ( dim_tiendas, dim_tiendas[pais] ) )
)
-- Calcula el % de la categoría manteniendo el filtro de país pero quitando otros
```

---

## MÓDULO 7 — Storytelling y dashboards

### Ej 7.1 — Dashboard ejecutivo (1 página)
**Objetivo:** comunicar lo esencial en un vistazo.
- KPIs grandes arriba: Total Ventas, Margen %, Cumplimiento %, Tasa Devolución.
- Tendencia mensual con línea de meta.
- Top 5 productos.
- Mapa o tabla por país.

### Ej 7.2 — Dashboard operacional por tienda (drill-through)
- Página principal: tabla de tiendas con KPIs.
- Drill-through a página de detalle: histórico, productos top, vendedores, devoluciones.

### Ej 7.3 — Dashboard de marketing (segmentación de clientes)
- Friends Plus vs Regular vs Corporativo: comportamiento.
- Cohortes por mes de alta.
- LTV (lifetime value) aproximado.

### Ej 7.4 — Storytelling: 3 hallazgos no obvios
**Objetivo:** ir más allá de los KPIs.
- Encontrar 3 patrones no triviales en los datos. Ejemplos:
  - "Los Drive-thru en México venden el doble los lunes que el promedio".
  - "Las suscripciones Friends Plus tienen 4x menos devolución".
  - "Diciembre depende 35% del merchandising; sin merch, la temporada cae 18%".
- Presentar cada hallazgo con: visual + número + acción recomendada.

---

## MÓDULO 8 — Optimización y profesionalización

### Ej 8.1 — DAX Studio: identificar medidas lentas
- Conectar DAX Studio al `.pbix`.
- Habilitar Server Timings.
- Ejecutar las medidas más complejas (Cumplimiento %, Margen %).
- Identificar tiempo Storage Engine (rápido) vs Formula Engine (lento).

### Ej 8.2 — VertiPaq Analyzer
- Revisar tamaño del modelo.
- Identificar columnas más pesadas.
- Discutir: ¿hay columnas que se podrían quitar sin perder análisis?

### Ej 8.3 — Refresh incremental
- Configurar política de refresh incremental en `fact_ventas`: refrescar solo últimos 6 meses, almacenar 3 años.
- Discutir cuándo aplica y cuándo no.

---

## MÓDULO 9 — Comparativa con otras herramientas (S4)

### Ej 9.1 — Replicar dashboard ejecutivo en Tableau o Looker
- Conectar a los mismos CSV.
- Construir las mismas visualizaciones.
- Comparar: tiempo de desarrollo, flexibilidad visual, performance.

### Ej 9.2 — Tabla comparativa
| Aspecto | Power BI | Tableau / Looker |
|---------|----------|--------------------|
| Modelado | ... | ... |
| Cálculos | DAX | LOD / cálculos calculados |
| Time intelligence | Nativo | Manual |
| ... | ... | ... |

---

## MÓDULO 10 — Proyecto final

### Idea de proyecto recomendada
**"Comité ejecutivo de Central Perk Global — Reunión de cierre fiscal 2025"**

Cada equipo construye el dashboard que llevarían a una reunión real de C-level con:
1. Una pregunta de negocio central (de las 12 sugeridas en `kpis_y_preguntas_de_negocio.md`).
2. KPIs ejecutivos.
3. Un hallazgo no obvio respaldado por datos.
4. Una recomendación accionable.

Presentación de 10 min + 5 Q&A en S5.
