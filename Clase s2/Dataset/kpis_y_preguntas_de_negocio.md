# KPIs y preguntas de negocio · Central Perk Global

Este documento responde la pregunta: **¿qué le pediría un comité ejecutivo a este dataset?**

---

## KPIs ejecutivos del negocio

### Financieros (los del CEO)

| KPI | Cálculo | Umbral aceptable |
|-----|---------|------------------|
| **Total Ventas** | `SUM(importe)` | crece YoY |
| **Margen %** | `(Ventas − Costo) / Ventas` | ≥ 45% |
| **Cumplimiento de meta %** | `Ventas / Meta` | ≥ 95% (verde), 80–95% (amarillo), <80% (rojo) |
| **Crecimiento YoY %** | `(Ventas año actual − año anterior) / año anterior` | ≥ +10% |
| **Ticket promedio** | `Ventas / # transacciones únicas` | crece o estable |

### Comerciales (la del Director Comercial)

| KPI | Cálculo |
|-----|---------|
| **Top 10 productos por venta** | filtro N principales sobre `Total Ventas` |
| **Top 10 productos por unidades** | filtro N principales sobre `Cantidad Vendida` |
| **Productos con margen bajo** | filtrar `Margen %` < 30% |
| **Mix por categoría** | `% del Total por Categoría` (suma 100%) |
| **Mix por canal** | `% del Total por Canal` |

### Operacionales (la del COO)

| KPI | Cálculo |
|-----|---------|
| **Ventas por m² (eficiencia tienda)** | `Total Ventas / metros_cuadrados` |
| **Ventas por vendedor** | `Total Ventas / # vendedores activos` |
| **Tasa de devolución %** | `Total Devoluciones / Total Ventas` |
| **Tiempo entrega promedio** | `AVG(fecha_entrega − fecha_venta)` (solo 2025) |
| **Cumplimiento por tienda** | meta ÷ venta a nivel tienda |

### Marketing/CRM (la del CMO)

| KPI | Cálculo |
|-----|---------|
| **Clientes Friends Plus %** | `# clientes Friends Plus / # clientes total` |
| **Frecuencia de compra Friends Plus** | `# transacciones / # clientes Friends Plus` |
| **Friends Plus ticket vs Regular** | comparación de ticket promedio |
| **Conversión por canal** | (requiere datos de tráfico — discusión: ¿cómo lo modelaríamos si los tuviéramos?) |
| **Cohortes de retención** | clientes que vuelven en mes M+1, M+3, M+6 |

---

## Preguntas de negocio (las del comité ejecutivo)

### Las 12 que cualquier C-level haría

> Cada pregunta se puede responder con el dataset. Algunas son sencillas, otras requieren combinar múltiples medidas.

1. **¿Estamos cumpliendo nuestras metas mensuales? ¿En qué canal estamos fallando?**
   - Visual: barras canal × cumplimiento %, línea horizontal en 100%.
   - Medidas: Cumplimiento %, Variación vs Meta.

2. **¿Cuál es nuestro mejor producto? ¿Y el peor en margen?**
   - Visual: tabla productos ordenada por Total Ventas, con Margen % y semáforo.
   - Medidas: Total Ventas, Margen %, Ranking Producto.

3. **¿En qué meses crecemos y en cuáles caemos? ¿Es estacional?**
   - Visual: línea de Ventas mensual con comparativa YoY.
   - Medidas: Ventas, Ventas YoY, Crecimiento % YoY.

4. **¿Qué tienda subutilizada deberíamos repensar?**
   - Visual: scatter plot ventas/m² × ventas absolutas.
   - Medidas: Ventas por m², Total Ventas, Cumplimiento por Tienda.

5. **¿Qué país está creciendo más? ¿Cuál estancado?**
   - Visual: mapa o barras por país con crecimiento YoY.
   - Medidas: Ventas, Ventas YoY, Crecimiento % YoY filtrado por país.

6. **¿La tasa de devolución está en niveles aceptables? ¿Qué motivos predominan?**
   - Visual: KPI Tasa Devolución + treemap por motivo.
   - Medidas: Tasa Devolución %, # devoluciones por motivo.

7. **¿Friends Plus está moviendo la aguja? ¿Vale la pena el descuento?**
   - Visual: comparativa ticket promedio + frecuencia entre segmentos.
   - Medidas: Ticket Promedio por segmento, # transacciones por cliente.

8. **¿Qué canal tiene mejor margen? ¿Estamos invirtiendo en el correcto?**
   - Visual: tabla canal × Total Ventas × Margen % × Cumplimiento.
   - Medidas: Margen % por canal.

9. **¿Cuál es el mejor vendedor? ¿Y el equipo top?**
   - Visual: ranking vendedor con filtros por país y equipo.
   - Medidas: Ventas por vendedor, Ranking Vendedor.

10. **¿Las suscripciones están reemplazando ventas únicas o sumando?**
    - Visual: línea de Ventas Suscripciones vs Ventas Otras categorías.
    - Análisis: cohorte — ¿clientes Friends Plus reducen sus compras one-off?

11. **¿La temporada de Halloween/Navidad/Verano vale el esfuerzo?**
    - Visual: contribución % de productos "Temporada" al total mensual.
    - Medidas: Total Ventas filtrado por categoría = Temporada.

12. **¿Cuánto tardamos en entregar? ¿Estamos mejorando?**
    - Solo aplicable a 2025 (multi-fecha).
    - Visual: tiempo entrega promedio mensual.
    - Medidas: AVG(fecha_entrega − fecha) usando USERELATIONSHIP.

---

## Hallazgos esperados (intencionales en el dataset)

Los datos sintéticos están diseñados para que aparezcan estos patrones cuando los exploren bien:

1. **Estacionalidad fuerte:** diciembre +60%, verano (jun-ago) +25%, febrero -15%.
2. **Friends Plus genera ~18% de los clientes pero ~30% de las ventas.**
3. **Tienda física sigue siendo el canal #1** (~42%), pero **App móvil crece más rápido** (porcentaje creciente año a año).
4. **El tipo Drive-thru tiene mayor ticket promedio** que Express pero **menor que Flagship**.
5. **Las devoluciones son ~1.8%**, mayoría por "Producto defectuoso" o "Sabor incorrecto".
6. **Los productos de Suscripciones tienen ticket alto pero menor frecuencia.**
7. **Las tiendas Flagship tienen mejor venta absoluta pero peor venta/m²** que las Express bien ubicadas.

Estos son los hallazgos a los que un alumno bien orientado debería llegar al final del curso.

---

## Validaciones esperadas tras limpieza

| Validación | Valor esperado |
|------------|----------------|
| Filas en `fact_ventas` consolidado | 48.500 – 49.500 |
| Filas únicas por `id_venta` | = total filas |
| Filas con `id_producto` válido | ≥ 99.4% |
| Filas con `id_cliente` válido (después de imputar anónimos) | 100% |
| Suma Total Ventas (en COP) | $ 12.000 – 18.000 millones |
| Distribución por canal | Tienda física 40-45%, App 20-24%, Web 16-20%, Marketplace 8-12%, Corporativo 6-10% |
| Tasa devolución | 1.5% – 2.2% |
| Margen % | 42% – 55% |
| % Friends Plus de clientes | ~18% |
| % Friends Plus de ventas | 25% – 32% |
| Tiendas con venta | 50/50 |
| Productos con venta | ≥ 110 / 120 (algunos productos inactivos no venden) |

---

## Pregunta para arrancar el curso

> "Tienes 3 archivos Excel sucios con 50.000 transacciones, 5 países, 5 canales y 3 años de operación. El CEO de Central Perk Global tiene una reunión en 6 horas y quiere saber **cuál es nuestro mejor producto, qué tienda cerrar y si estamos cumpliendo metas**. Tienes 6 horas. ¿Por dónde empiezas?"

Esa pregunta es el hilo conductor del curso. Cada sesión te acerca a poder responderla con confianza.
