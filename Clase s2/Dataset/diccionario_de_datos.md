# Diccionario de datos · Central Perk Global

Detalle campo a campo de cada archivo. Para cada campo: tipo esperado, tipo real (si difiere), nulos esperados, errores que enseña.

---

## 1. `ventas_2023.xlsx` (hoja: `Ventas`)

**Volumen:** ~14.000 filas. **Período:** 2023–01–01 a 2023–12–31.

| Columna | Tipo esperado | Tipo real | Nulos | Notas pedagógicas |
|---------|---------------|-----------|-------|-------------------|
| `id_venta` | texto | texto | no | PK natural. Formato `V100000`–`V113999`. |
| `fecha` | fecha | **mixto** | no | Dos formatos: `2023-03-15` (~55%) y `15/03/2023` (~45%). |
| `id_producto` | texto | texto | no | FK a `productos.id_producto`. |
| `id_cliente` | texto | texto | no | FK a `clientes.id_cliente`. |
| `id_tienda` | texto | texto | no | FK a `tiendas.id_tienda`. |
| `id_vendedor` | entero | entero | no | FK a `vendedores.id_vendedor`. |
| `canal` | texto | texto | **~3%** | Variantes leves: espacios al inicio/final (~8%), MAYÚSCULAS o minúsculas (~5%). |
| `cantidad` | entero | entero | no | OK en este año. |
| `precio_unit` | decimal | decimal | no | OK. |
| `descuento` | decimal (0–1) | decimal | no | OK. |
| `importe` | decimal | decimal | no | OK (sin negativos). |
| `notas` | texto | texto | mayoría null | 5% no vacíos: comentarios libres. |

**Errores acumulados:**
- ~1.5% de duplicados exactos (~210 filas).
- Variantes en `canal` que requieren normalización.

---

## 2. `ventas_2024.xlsx` (hoja: `Ventas`)

**Volumen:** ~17.000 filas. **Período:** 2024–01–01 a 2024–12–31.

⚠️ **NOMBRES DE COLUMNAS DISTINTOS** respecto al 2023.

| Columna 2024     | Equivale a (en 2023) | Tipo esperado | Notas |
|------------------|----------------------|---------------|-------|
| `id_pedido`      | `id_venta`           | texto | Formato `V200000`–`V216999`. |
| `fecha_pedido`   | `fecha`              | fecha | **3 formatos** mezclados: ISO, dd/mm/yyyy, "Mar 5, 2024". |
| `cod_producto`   | `id_producto`        | texto | ~0.6% inválidos (`P9999`). |
| `cod_cliente`    | `id_cliente`         | texto | OK. |
| `cod_tienda`     | `id_tienda`          | texto | OK. |
| `cod_vendedor`   | `id_vendedor`        | entero | OK. |
| `canal`          | `canal`              | texto | **5+ variantes**: "WEB", "web", "Web ", "Marketplace", "MKT PLC", "App Movil", "App movil", "Tienda fisica". |
| `cantidad`       | `cantidad`           | entero | **~2% como string** ("3", " 5 "). |
| `precio_unitario`| `precio_unit`        | decimal | OK. |
| `descuento`      | `descuento`          | decimal | **~5% nulos** (deben tratarse como 0). |
| `total`          | `importe`            | decimal | OK. |
| `notas`          | `notas`              | texto | Mayoría null. |
| `campo_temporal_no_usar` | (ninguna)    | basura | **Columna sobrante** que hay que descartar. |
| `zona_horaria`   | (ninguna)            | texto | "GMT-5" en todas. **Columna sobrante**. |

**Errores acumulados:**
- ~1% de duplicados.
- 2 columnas que NO deben llegar al modelo.
- Renombre obligatorio de 8 columnas para apilar con 2023.

---

## 3. `ventas_2025.xlsx` (hoja: `Ventas`)

**Volumen:** ~19.000 filas. **Período:** 2025–01–01 a 2025–12–31.

| Columna | Tipo esperado | Tipo real | Notas |
|---------|---------------|-----------|-------|
| `id_venta` | texto | texto | Formato `V300000`–`V318999`. Vuelve al naming original. |
| `fecha` | fecha | **mixto número/texto** | ~55% como **número serial Excel** (ej. 45292 = 2024-01-01), ~45% como ISO. |
| `fecha_envio` | fecha | texto ISO | 1–3 días después de `fecha`. |
| `fecha_entrega` | fecha | texto ISO | 3–7 días después de `fecha`. |
| `id_producto` | texto | texto | OK. |
| `id_cliente` | texto | texto | **~4% nulos** (clientes anónimos). |
| `id_tienda` | texto | texto | OK. |
| `id_vendedor` | entero | entero | OK. |
| `canal` | texto | texto | Variantes similares al 2024 + un canal nuevo `"Drive-thru"` (~0.5%) que NO está en el catálogo oficial. |
| `cantidad` | entero | entero | OK. |
| `precio_unit` | decimal | decimal | OK (en COP). |
| `descuento` | decimal | **mixto string/decimal** | ~15% con **decimales con coma** ("0,15" en vez de "0.15"). |
| `importe` | decimal | decimal | ⚠️ **Multi-currency**. ~40% en moneda local del país (USD/MXN/EUR/ARS), 60% en COP. Ver columna `moneda`. ~0.5% negativos. |
| `moneda` | texto | texto | "USD", "MXN", "COP", "EUR" o "ARS". Necesario para normalizar `importe`. |

**Sin columna `notas`** en 2025 (rompe el append simple — hay que añadirla manualmente con valor nulo en los otros años o dropearla en todos).

**Errores acumulados:**
- Fechas en 2 sistemas (serial + texto).
- 3 columnas de fecha (multi-fecha → relaciones inactivas en el modelo).
- Multi-currency → necesita normalización antes de modelar.
- Decimales con coma → reemplazo en Power Query.
- Esquema distinto de columnas respecto a 2023 y 2024.

---

## 4. `productos.csv`

**Volumen:** 120 filas. Limpio.

| Columna | Tipo | Notas |
|---------|------|-------|
| `id_producto` | texto | PK. Formato `P1000`–`P1119`. |
| `nombre` | texto | Nombres con guiños a *Friends*. |
| `categoria` | texto | 6 valores: Bebidas calientes, Bebidas frías, Comida, Merchandising, Temporada, Suscripciones. |
| `subcategoria` | texto | Anidada bajo categoría. |
| `marca` | texto | 7 marcas: Central Perk Original, Phoebe's Choice, Joey's Picks, Ross Reserve, Rachel Skinny, Monica Clean, Smelly Cat Co. |
| `precio_lista` | decimal | En COP. |
| `costo` | decimal | 35–60% del precio. |
| `activo` | bool | ~92% activos. |
| `lanzamiento` | fecha (texto ISO) | Fecha de lanzamiento del producto. |

**Cálculo de margen:** `(precio_lista - costo) / precio_lista`. Útil para medidas DAX.

---

## 5. `clientes.csv`

**Volumen:** 5.000 filas.

| Columna | Tipo | Notas |
|---------|------|-------|
| `id_cliente` | texto | PK. Formato `C30000`–`C34999`. |
| `nombre` | texto | Persona o empresa según `tipo`. |
| `tipo` | texto | Persona / Empresa / Anónimo. |
| `segmento` | texto | Friends Plus (~18%) / Regular (~55%) / Corporativo (~10%) / Anónimo (~17%). |
| `ciudad` | texto | **Errores leves intencionales:** ~15% de las ciudades tienen variantes (acentos quitados, espacios, mayúsculas). Ej.: "Bogotá" / "BOGOTA" / "Bogota " / " Bogotá". |
| `pais` | texto | 5 valores limpios. |
| `email` | texto | Vacío para clientes Anónimos. |
| `fecha_alta` | fecha (texto ISO) | Antigüedad del cliente. Útil para cohort analysis. |
| `edad` | entero o null | Null para Anónimos. |

---

## 6. `tiendas.csv`

**Volumen:** 50 filas. Limpio.

| Columna | Tipo | Notas |
|---------|------|-------|
| `id_tienda` | texto | PK. Formato `T100`–`T149`. |
| `nombre_tienda` | texto | "Central Perk {Ciudad} #{N}". |
| `tipo_tienda` | texto | Flagship (~10%) / Standard (~55%) / Express (~25%) / Drive-thru (~10%). |
| `ciudad` | texto | Limpio. |
| `region` | texto | Región dentro del país. |
| `pais` | texto | 5 valores. |
| `fecha_apertura` | fecha | Antigüedad de la tienda. |
| `metros_cuadrados` | entero | Tamaño físico. Para análisis de eficiencia (venta/m²). |
| `activa` | bool | True en todas en este dataset. |

---

## 7. `calendario.csv`

**Volumen:** 1.096 filas. Período: 2023–01–01 a 2025–12–31. Limpio.

| Columna | Tipo | Notas |
|---------|------|-------|
| `fecha` | fecha (texto ISO) | PK natural. Continua, sin huecos. |
| `anio` | entero | 2023, 2024, 2025. |
| `trimestre_num` | entero | 1–4. |
| `trimestre` | texto | "T1"–"T4". |
| `mes_num` | entero | 1–12. **Usar para ordenar `mes_nombre`.** |
| `mes_nombre` | texto | "enero"–"diciembre". |
| `anio_mes` | texto | "YYYY-MM". Útil para gráficos de tendencia. |
| `semana` | entero | Número ISO de semana. |
| `dia` | entero | 1–31. |
| `dia_semana_num` | entero | 1=lunes, 7=domingo. |
| `dia_semana` | texto | "lunes"–"domingo". |
| `es_finde` | entero (0/1) | 1 si sábado/domingo. |
| `es_festivo` | entero | Placeholder en 0. El docente puede marcar fechas específicas. |

---

## 8. `vendedores` — tabla viva en Azure SQL Database

**Conexión real para este curso:**

| Campo | Valor |
|-------|-------|
| Servidor | `dataviz2026.database.windows.net` |
| Base de datos | `free-sql-db-1889055` |
| Tabla | `vendedores` |
| Auth | SQL Server Authentication (credenciales en clase) |

📘 **Guía de conexión paso a paso:** ver [`conexion_azure_sql.md`](conexion_azure_sql.md)

**Esquema de la tabla (DDL):**

```sql
CREATE TABLE vendedores (
    id_vendedor   INT NOT NULL PRIMARY KEY,
    nombre        NVARCHAR(120) NOT NULL,
    equipo        NVARCHAR(50) NOT NULL,
    supervisor    NVARCHAR(120) NOT NULL,
    pais          NVARCHAR(50) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    activo        BIT NOT NULL
);
```

**Archivos de respaldo:**
- `vendedores.sql` — script de creación (CREATE + 100 INSERTs). Útil para reproducir la tabla en SQL Server local, PostgreSQL u otro Azure SQL.
- `vendedores_referencia.csv` — el mismo dataset en CSV. Fallback si la conexión a Azure falla durante la clase.

**Datos:** 20 vendedores por país × 5 países = 100. Equipos: Mañana, Tarde, Noche, Fin de semana. ~7% inactivos.

**Por qué se enseña con SQL real:** Power BI distingue conectores nativos (Excel, CSV) de conectores SQL en una capacidad clave: el **query folding**. Con SQL, ciertos pasos de Power Query se traducen a SQL y se ejecutan en el servidor (más rápido, menos memoria local). Con Excel/CSV no es posible. Esto es lo que permite que un dashboard escale a millones de filas.

---

## 9. `metas_cross.xlsx` (hoja: `Metas 2025`)

**Wide format intencional**. Para enseñar UNPIVOT.

```
| canal           | ene_2025      | feb_2025      | mar_2025      | ... | dic_2025      |
|-----------------|---------------|---------------|---------------|-----|---------------|
| Tienda física   | 280.000.000   | 238.000.000   | 280.000.000   | ... | 420.000.000   |
| App móvil       | 145.000.000   | 123.000.000   | 145.000.000   | ... | 218.000.000   |
| Web             | 110.000.000   |  94.000.000   | 110.000.000   | ... | 165.000.000   |
| Marketplace     |  60.000.000   |  51.000.000   |  60.000.000   | ... |  90.000.000   |
| Corporativo     |  45.000.000   |  38.000.000   |  45.000.000   | ... |  68.000.000   |
| TOTAL           |  640.000.000  |  544.000.000  |  640.000.000  | ... |  961.000.000  |
| Notas: ...      |               |               |               | ... |               |
```

**Errores intencionales:**
1. **Wide format** → necesita UNPIVOT para ser usable en el modelo.
2. **Fila TOTAL** que no debe ir al modelo.
3. **Fila de notas** que rompe los tipos.

**Esperado tras limpieza:**

```
| canal         | mes_num | anio | meta        |
|---------------|---------|------|-------------|
| Tienda física |   1     | 2025 | 280.000.000 |
| Tienda física |   2     | 2025 | 238.000.000 |
| ...           |   ...   | ...  |  ...        |
```

5 canales × 12 meses = 60 filas resultantes.

---

## 10. `devoluciones.csv`

**Volumen:** ~900 filas (1.8% de las ventas + 1% inválidos).

| Columna | Tipo | Notas |
|---------|------|-------|
| `id_devolucion` | texto | PK. Formato `D50000`+. |
| `id_venta` | texto | FK a `fact_ventas.id_venta`. ~1% inválidos (no existen). |
| `fecha_devolucion` | fecha | Típicamente 1–14 días después de la venta. **~2% imposibles** (anteriores a la venta). |
| `motivo` | texto | 9 motivos base + variantes (mayúsculas, espacios, sinónimos como "sabor malo" vs "Sabor incorrecto"). |
| `importe_devuelto` | decimal | ~3% **mayor que el importe de la venta original** (error de captura, debe detectarse). |

**Validación:** una buena medida DAX `Tasa de devolución %` debería estar entre 1.5% y 2.5% del total. Si sale más alto, algo se está contando dos veces.
