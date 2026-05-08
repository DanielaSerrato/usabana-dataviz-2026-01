# Central Perk Global · Caso corporativo del curso

> **Empresa ficticia:** cadena multinacional de cafeterías premium y retail lifestyle, inspirada en la cafetería de *Friends* y reimaginada como un negocio del 2026 con presencia en 5 países.

Este ecosistema de datos es el **caso transversal del curso** *Herramientas de Visualización de Datos* (Maestría en Analítica Aplicada). Diseñado para enseñar TODO el ciclo de Power BI: Power Query, modelado dimensional, DAX, time intelligence, storytelling, KPIs y dashboards.

---

## Narrativa del caso

**Central Perk Global** es una compañía multinacional fundada en 2018 (en este universo). Opera **50 tiendas** en:

| País           | Regiones                                     | Tipo de operación                         |
|----------------|----------------------------------------------|-------------------------------------------|
| Estados Unidos | Noreste · Oeste · Medio Oeste · Sur · Sureste | Tiendas flagship + estándar               |
| México         | Centro · Occidente · Norte · Sureste         | Mix flagship + drive-thru                 |
| Colombia       | Andina · Caribe · Pacífica                   | Mayoría estándar, algunas express         |
| España         | Centro · Cataluña · Levante · Andalucía · Norte | Estándar + flagship en Madrid/Barcelona |
| Argentina      | Centro · Litoral · Cuyo                      | Estándar y express                        |

Vende:
- **Bebidas calientes:** café espresso, café con leche, té, chocolate
- **Bebidas frías:** café frío, smoothies, limonadas
- **Comida:** sándwiches, bowls, postres, snacks
- **Merchandising:** vasos térmicos, textil, accesorios
- **Productos de temporada:** ediciones Navidad, Verano, Halloween
- **Suscripciones:** plan de café mensual, membresía Friends Plus

A través de 5 canales:
- Tienda física · App móvil · Web · Marketplace · Corporativo (B2B)

Período cubierto: **2023, 2024 y 2025**.

---

## Archivos generados

### Tablas de hechos (sucias a propósito — para Power Query)

| Archivo               | Filas    | Errores que enseña                                          |
|-----------------------|----------|--------------------------------------------------------------|
| `ventas_2023.xlsx`    | ~14.000  | **Básicos**: fechas en 2 formatos · espacios · case · duplicados · nulos leves |
| `ventas_2024.xlsx`    | ~17.000  | **Intermedios**: nombres de columnas distintos · columna basura · 5 variantes de canal · ID inválidos · 3 formatos de fecha |
| `ventas_2025.xlsx`    | ~19.000  | **Avanzados**: fechas serial Excel · multi-currency · multi-fecha (venta/envío/entrega) · decimales con coma · canal nuevo no esperado · `notas` ausente |

### Dimensiones (limpias o casi limpias)

| Archivo                | Filas  | Notas                                          |
|------------------------|--------|------------------------------------------------|
| `productos.csv`        | 120    | 6 categorías × subcategorías × marcas Friends |
| `clientes.csv`         | 5.000  | 5 países, 4 segmentos. Ciudades con leves variantes (acentos, espacios) |
| `tiendas.csv`          | 50     | 5 países, 4 tipos de tienda                    |
| `calendario.csv`       | 1.096  | 2023–01–01 a 2025–12–31 (incluye bisiesto 2024) |
| `vendedores.sql`       | 100    | Script SQL Server (CREATE + INSERTs). **Tabla viva en Azure SQL** — ver `conexion_azure_sql.md` |
| `vendedores_referencia.csv` | 100 | El mismo dataset en CSV (fallback si la conexión Azure falla) |

> **Tabla `vendedores` en vivo en Azure SQL Database**
> Servidor: `dataviz2026.database.windows.net`
> Base de datos: `free-sql-db-1889055`
> Tabla: `vendedores`
> Conector: SQL Server Authentication. Credenciales se entregan en clase.
> Guía paso a paso: [`conexion_azure_sql.md`](conexion_azure_sql.md)

### Tablas auxiliares

| Archivo               | Notas                                                     |
|-----------------------|-----------------------------------------------------------|
| `metas_cross.xlsx`    | **Wide format intencional**. 1 fila por canal, 12 columnas (ene-dic 2025). Para enseñar **UNPIVOT**. |
| `devoluciones.csv`    | ~1.8% de las ventas. Motivos inconsistentes, devoluciones > venta, fechas imposibles, IDs inválidos. |

---

## Diseño esperado del modelo (esquema en estrella)

```
                       ┌────────────────────┐
                       │    dim_calendario  │
                       │  (fecha PK)        │
                       └──────────┬─────────┘
                                  │ 1:N
                                  │
   ┌────────────────┐    ┌────────▼────────┐    ┌────────────────┐
   │ dim_productos  │1:N │   fact_ventas   │N:1 │  dim_clientes  │
   │  (id_producto) │────│   (consolidado  │────│   (id_cliente) │
   └────────────────┘    │    de 3 años)   │    └────────────────┘
                         │                 │
                         │   id_venta PK   │
                         └─┬─────────────┬─┘
                           │N:1          │N:1
                           │             │
                  ┌────────▼──────┐  ┌───▼────────────┐
                  │  dim_tiendas  │  │ dim_vendedores │
                  │  (id_tienda)  │  │  (id_vendedor) │
                  └───────────────┘  └────────────────┘

  + fact_metas (por canal × mes × año, después del unpivot)
  + fact_devoluciones (por id_venta, conectado a fact_ventas)

  Relación inactiva (USERELATIONSHIP):
    dim_calendario → fact_ventas[fecha_envio]   (inactiva)
    dim_calendario → fact_ventas[fecha_entrega] (inactiva)
```

**Tres relaciones a `dim_calendario` desde `fact_ventas`** (solo en 2025 hay multi-fecha):
- `fecha` → relación **activa** (default)
- `fecha_envio` → **inactiva**, se activa con `USERELATIONSHIP`
- `fecha_entrega` → **inactiva**, se activa con `USERELATIONSHIP`

---

## Cobertura pedagógica

Cada archivo está diseñado para enseñar conceptos específicos. Detalle completo en:

- **`diccionario_de_datos.md`** — campo a campo, qué tipo, qué errores tiene
- **`ejercicios_por_modulo.md`** — taller dividido por temas del curso
- **`kpis_y_preguntas_de_negocio.md`** — qué preguntas responde el modelo

Resumen rápido:

| Tema del curso | Archivo(s) clave | Concepto que enseña |
|----------------|-------------------|----------------------|
| Power Query — fechas | `ventas_2023/2024/2025` | 4 formatos distintos: ISO, dd/mm/yyyy, MMM d yyyy, Excel serial |
| Power Query — limpieza texto | `ventas_2024`, `clientes` | Variantes de canal, acentos, espacios, mayúsculas |
| Power Query — tipos | `ventas_2024/2025` | Cantidad como texto, decimales con coma, IDs inválidos |
| Power Query — append | `ventas_2023/2024/2025` | Apilar 3 archivos con esquemas levemente distintos |
| Power Query — unpivot | `metas_cross.xlsx` | Wide → long: 12 columnas de meses → filas |
| Power Query — merge | `ventas` + `productos`, `+ devoluciones` | Inner/left/anti, validación de huérfanos |
| Power Query — pivot | (ejercicio inverso opcional) | Long → wide para reportes ejecutivos |
| Modelado — estrella | Toda la estructura | 6 tablas (3 hechos + 3 dim + calendario) |
| Modelado — cardinalidad | `clientes.id_cliente`, `ventas.id_cliente` | 1:N con casos donde hay duplicados ocultos |
| Modelado — relaciones inactivas | `ventas_2025` (3 fechas) | USERELATIONSHIP para fechas alternativas |
| Modelado — RLS | `vendedores.pais` | Row-level security por país |
| DAX — agregaciones | `fact_ventas.importe` | SUM, AVG, COUNT, DISTINCTCOUNT |
| DAX — CALCULATE | varios | Modificar contexto de filtro |
| DAX — Time intelligence | `dim_calendario` | YoY, MoM, MTD, YTD, SAMEPERIODLASTYEAR |
| DAX — RANKX | `dim_productos`, `dim_vendedores` | Top productos, ranking de vendedores |
| DAX — DIVIDE / SUMX | `fact_ventas` | Ticket promedio, margen |
| DAX — ALL/REMOVEFILTERS | varios | % del total por categoría/canal/país |
| Storytelling | Toda la data | KPIs ejecutivos, trends, top performers |
| Dashboards | Toda la data | Ejecutivo · Operacional · Geográfico |

---

## Reproducibilidad

Todo se genera con seed fijo `2026`. Para regenerar:

```bash
python common/scripts/generar_central_perk.py
```

El script usa `pandas`, `numpy` y `Faker`. Los volúmenes están parametrizados al inicio del script.

---

## Volúmenes esperados

- Ventas totales (3 años): ~50.000 transacciones
- Después de limpieza: ~48.500–49.500 (perdemos ~1-2% por duplicados, errores y huérfanos)
- Distribución por canal (objetivo): Tienda física ~42% · App móvil ~22% · Web ~18% · Marketplace ~10% · Corporativo ~8%
- Estacionalidad: pico fuerte en diciembre, alto en verano (jun-ago), bajo en febrero

---

## Notas pedagógicas para el docente

- **El caos está calibrado.** No es un dataset roto al azar — cada error está etiquetado en el diccionario. Si un alumno encuentra un patrón "raro", probablemente está intencional.
- **Los nombres de productos son guiños a *Friends*** (Phoebe's Choice, Joey's Picks, Ross Reserve, etc.). Esto crea adherencia y ayuda a recordar.
- **Las preguntas de negocio del archivo `kpis_y_preguntas_de_negocio.md` son lo que un comité ejecutivo real preguntaría**: ¿cuál es nuestro mejor canal? ¿qué producto crece más? ¿qué tienda subutilizada deberíamos cerrar?
- **Aplicar siempre las reglas del curso:** las propuestas de plazo son guía, no nota estricta. No penalizar entregas tardías.
