# Datasets para parcial corto de Power BI

Esta carpeta contiene cinco bases de datos pequenas, cada una con un tema distinto. Cada estudiante debe escoger o recibir una base, importarla en Power BI, limpiar los datos, crear el modelo, construir medidas DAX y responder la pregunta asignada.

## Entregable esperado

- Archivo `.pbix` con el modelo de datos.
- Relaciones creadas correctamente entre tablas.
- Limpieza aplicada en Power Query.
- Minimo 5 medidas DAX.
- Una pagina de dashboard con KPI, grafico temporal, ranking, matriz y segmentadores.
- Respuesta escrita a la pregunta del dataset, usando cifras del dashboard.

## Criterios de evaluacion sugeridos

| Criterio | Evidencia | Puntos |
|---|---|---:|
| Carga y limpieza | Tipos de datos correctos, nulos tratados, categorias estandarizadas | 20 |
| Modelo | Relaciones correctas, modelo sin ambiguedades | 20 |
| DAX | Medidas de total, tasa/promedio, variacion, ranking y cumplimiento | 25 |
| Visualizacion | Dashboard claro, filtrable y coherente con la pregunta | 25 |
| Analisis | Respuesta sustentada con datos | 10 |

## Preguntas por dataset

### 1. `01_ventas_retail_powerbi.xlsx`

**Pregunta:** Que categoria, canal y ciudad explican mejor la utilidad neta del negocio?

Relaciones sugeridas:

- `Ventas[ProductoID]` -> `Productos[ProductoID]`
- `Ventas[ClienteID]` -> `Clientes[ClienteID]`
- `Ventas[Fecha]` -> `Calendario[Fecha]`

Medidas sugeridas:

- Ventas netas
- Costo total
- Utilidad
- Margen %
- Unidades vendidas

Errores intencionales:

- `Canal` aparece como `Online`, `online`, `Tienda` y `Tienda fisica`.
- `Descuento` tiene valores nulos.
- Algunas ventas tienen `Cantidad` negativa porque representan devoluciones.

### 2. `02_citas_clinica_powerbi.xlsx`

**Pregunta:** Que especialidad y sede presentan mayores problemas de inasistencia o espera?

Relaciones sugeridas:

- `Citas[PacienteID]` -> `Pacientes[PacienteID]`
- `Citas[MedicoID]` -> `Medicos[MedicoID]`
- `Citas[Fecha]` -> `Calendario[Fecha]`

Medidas sugeridas:

- Total de citas
- Citas asistidas
- Tasa de inasistencia
- Tiempo promedio de espera
- Valor total de consultas

Errores intencionales:

- `Estado` aparece como `Asistio`, `Asistio `, `Cancelada` y `No asistio`.
- `TiempoEsperaMin` tiene valores nulos.
- La prioridad de urgencia debe analizarse como categoria, no como numero.

### 3. `03_rendimiento_academico_powerbi.xlsx`

**Pregunta:** Que cursos o programas concentran mayor riesgo academico y como se relaciona con asistencia?

Relaciones sugeridas:

- `Notas[EstudianteID]` -> `Estudiantes[EstudianteID]`
- `Notas[CursoID]` -> `Cursos[CursoID]`

Medidas sugeridas:

- Promedio de nota
- Porcentaje de aprobacion
- Estudiantes en riesgo
- Promedio de asistencia
- Conteo de entregas tardias o no entregadas

Errores intencionales:

- `Nota` tiene algunos valores nulos.
- La asistencia baja puede explicar perdida academica.
- `EstadoEntrega` incluye entregas tarde y no entregadas.

### 4. `04_logistica_entregas_powerbi.xlsx`

**Pregunta:** Que zonas y tipos de vehiculo generan mas retrasos y mayor costo logistico?

Relaciones sugeridas:

- `Envios[ZonaID]` -> `Zonas[ZonaID]`
- `Envios[VehiculoID]` -> `Vehiculos[VehiculoID]`
- `Envios[FechaDespacho]` -> `Calendario[Fecha]`

Medidas sugeridas:

- Total de envios
- Paquetes entregados
- Costo logistico total
- Costo promedio por paquete
- Tasa de entregas con retraso

Errores intencionales:

- `Estado` aparece como `Entregado` y `entregado`.
- `FechaEntrega` puede estar vacia.
- `CostoExtra` tiene valores nulos.

### 5. `05_marketing_digital_powerbi.xlsx`

**Pregunta:** Que canal y campana tienen mejor retorno frente a la inversion realizada?

Relaciones sugeridas:

- `Resultados[CampanaID]` -> `Campanas[CampanaID]`
- `Resultados[Fecha]` -> `Calendario[Fecha]`

Medidas sugeridas:

- Inversion total
- Clics totales
- Tasa de conversion
- CPA
- ROAS

Errores intencionales:

- `Canal` aparece como `Meta` y `meta`.
- `Conversiones` puede ser 0, por lo que se debe usar `DIVIDE` en DAX.
- `Costo` tiene valores nulos puntuales.

## Nota para docentes

Si se quiere que el parcial sea mas corto, asigne un solo dataset por estudiante o grupo. Si se quiere medir comparacion entre contextos, asigne dos datasets y pida que comparen las decisiones de limpieza y las medidas DAX usadas.
