# Datasets para parcial corto de Power BI

Esta carpeta contiene cinco bases de datos pequenas, cada una con un tema distinto. Cada estudiante debe escoger o recibir una base, importarla en Power BI, limpiar los datos, crear el modelo, construir una tabla calendario, proponer sus propias metricas DAX y responder la pregunta asignada.

## Entregable esperado

- Archivo `.pbix` con el modelo de datos.
- Relaciones creadas correctamente entre tablas.
- Tabla calendario creada en Power BI, relacionada con la columna de fecha principal del dataset.
- Limpieza aplicada en Power Query con cambios pequenos pero justificados.
- Medidas DAX minimas del dataset y, ademas, las metricas extra que el estudiante considere utiles.
- Al menos una medida de inteligencia de tiempo usando la tabla calendario.
- Una pagina de dashboard disenada por el estudiante, con visuales apropiados para responder la pregunta y con una historia clara.
- Respuesta escrita a la pregunta del dataset, usando cifras del dashboard.

## Criterios de evaluacion sugeridos

| Criterio | Evidencia | Puntos |
|---|---|---:|
| Carga y limpieza | Tipos de datos correctos, nulos tratados, categorias estandarizadas y cambios pequenos en Power Query | 20 |
| Modelo | Relaciones correctas, tabla calendario creada y modelo sin ambiguedades | 20 |
| DAX | Metricas minimas, metrica de inteligencia de tiempo y medidas sensibles a filtros | 25 |
| Visualizacion | Dashboard claro, filtrable y con storytelling coherente | 25 |
| Analisis | Respuesta sustentada con datos | 10 |

## Reglas generales

- No hay hoja de calendario en los archivos. Cada estudiante debe crearla en Power BI, por ejemplo con `CALENDAR`, `CALENDARAUTO` o una tabla calculada equivalente.
- La tabla calendario debe incluir, como minimo: fecha, anio, mes, nombre del mes y trimestre.
- Cada dataset tiene metricas minimas obligatorias. El estudiante puede agregar metricas extra si ayudan a responder mejor la pregunta.
- La medida de inteligencia de tiempo debe usar la tabla calendario creada por el estudiante. Ejemplos: acumulado a la fecha, variacion contra mes anterior, promedio movil o cambio porcentual por periodo.
- En Power Query se esperan cambios pequenos y razonables: corregir tipos de datos, limpiar espacios, unificar categorias, reemplazar nulos o crear columnas simples si son utiles.
- El diseno del dashboard es libre, pero debe contar una historia: contexto inicial, hallazgo principal, comparacion o detalle, y cierre con una conclusion accionable.
- El dashboard no debe ser una coleccion de graficos sueltos. Debe guiar al lector hacia la respuesta de la pregunta.

## Preguntas por dataset

### 1. `01_ventas_retail_powerbi.xlsx`

**Pregunta:** Que categoria, canal y ciudad explican mejor la utilidad neta del negocio?

Relaciones sugeridas:

- `Ventas[ProductoID]` -> `Productos[ProductoID]`
- `Ventas[ClienteID]` -> `Clientes[ClienteID]`
- `Ventas[Fecha]` -> tabla calendario creada por el estudiante

Metricas minimas:

- Ventas netas
- Costo total
- Utilidad
- Margen %
- Unidades vendidas
- Ventas netas acumuladas por mes o variacion de ventas vs mes anterior

Errores intencionales:

- `Canal` aparece como `Online`, `online`, `Tienda` y `Tienda fisica`.
- `Descuento` tiene valores nulos.
- Algunas ventas tienen `Cantidad` negativa porque representan devoluciones.

### 2. `02_citas_clinica_powerbi.xlsx`

**Pregunta:** Que especialidad y sede presentan mayores problemas de inasistencia o espera?

Relaciones sugeridas:

- `Citas[PacienteID]` -> `Pacientes[PacienteID]`
- `Citas[MedicoID]` -> `Medicos[MedicoID]`
- `Citas[Fecha]` -> tabla calendario creada por el estudiante

Metricas minimas:

- Total de citas
- Citas asistidas
- Tasa de inasistencia
- Tiempo promedio de espera
- Valor total de consultas
- Citas acumuladas por mes o variacion mensual de inasistencia

Errores intencionales:

- `Estado` aparece como `Asistio`, `Asistio `, `Cancelada` y `No asistio`.
- `TiempoEsperaMin` tiene valores nulos.
- La prioridad de urgencia debe analizarse como categoria, no como numero.

### 3. `03_rendimiento_academico_powerbi.xlsx`

**Pregunta:** Que cursos o programas concentran mayor riesgo academico y como se relaciona con asistencia?

Relaciones sugeridas:

- `Notas[EstudianteID]` -> `Estudiantes[EstudianteID]`
- `Notas[CursoID]` -> `Cursos[CursoID]`
- `Notas[FechaEvaluacion]` -> tabla calendario creada por el estudiante

Metricas minimas:

- Promedio de nota
- Porcentaje de aprobacion
- Estudiantes en riesgo
- Promedio de asistencia
- Conteo de entregas tardias o no entregadas
- Promedio de nota acumulado o variacion del promedio por periodo de evaluacion

Errores intencionales:

- `Nota` tiene algunos valores nulos.
- La asistencia baja puede explicar perdida academica.
- `EstadoEntrega` incluye entregas tarde y no entregadas.

### 4. `04_logistica_entregas_powerbi.xlsx`

**Pregunta:** Que zonas y tipos de vehiculo generan mas retrasos y mayor costo logistico?

Relaciones sugeridas:

- `Envios[ZonaID]` -> `Zonas[ZonaID]`
- `Envios[VehiculoID]` -> `Vehiculos[VehiculoID]`
- `Envios[FechaDespacho]` -> tabla calendario creada por el estudiante

Metricas minimas:

- Total de envios
- Paquetes entregados
- Costo logistico total
- Costo promedio por paquete
- Tasa de entregas con retraso
- Envios acumulados por mes o variacion mensual del costo logistico

Errores intencionales:

- `Estado` aparece como `Entregado` y `entregado`.
- `FechaEntrega` puede estar vacia.
- `CostoExtra` tiene valores nulos.

### 5. `05_marketing_digital_powerbi.xlsx`

**Pregunta:** Que canal y campana tienen mejor retorno frente a la inversion realizada?

Relaciones sugeridas:

- `Resultados[CampanaID]` -> `Campanas[CampanaID]`
- `Resultados[Fecha]` -> tabla calendario creada por el estudiante

Metricas minimas:

- Inversion total
- Clics totales
- Tasa de conversion
- CPA
- ROAS
- ROAS acumulado por mes o variacion mensual de conversiones

Errores intencionales:

- `Canal` aparece como `Meta` y `meta`.
- `Conversiones` puede ser 0, por lo que se debe usar `DIVIDE` en DAX.
- `Costo` tiene valores nulos puntuales.

## Nota para docentes

Si se quiere que el parcial sea mas corto, asigne un solo dataset por estudiante o grupo. Si se quiere medir comparacion entre contextos, asigne dos datasets y pida que comparen las decisiones de limpieza y las medidas DAX usadas.

## Storytelling esperado

La pagina del dashboard debe tener una secuencia entendible:

1. **Contexto:** mostrar el volumen general del caso con 2 o 3 KPI principales.
2. **Hallazgo:** evidenciar el principal problema u oportunidad relacionado con la pregunta.
3. **Comparacion:** contrastar categorias, canales, sedes, cursos, zonas o campanas segun corresponda.
4. **Tiempo:** usar la tabla calendario para mostrar evolucion, acumulado o variacion.
5. **Conclusion:** incluir una frase corta o visual que responda la pregunta con datos.
