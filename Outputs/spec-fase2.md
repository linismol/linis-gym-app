# Spec: App Rutina Gym (Lina) — Fase 2: Los 5 días completos
Fecha: 2026-07-30

## Overview
Extensión de la app validada en Fase 1 (un solo día prototipo) a los 5 días completos de la rutina de glúteo y pierna, con el contenido diseñado por /gym-coach para atacar el estancamiento de tren inferior en fase de acumulación. Además de consultar el día, la app permite marcar series completadas durante el entrenamiento y registrar el peso usado por ejercicio, para trackear la progresión de carga del mesociclo.

## Usuarios objetivo
Lina, la misma usuaria de la Fase 1. Ya validó el formato y contenido con el día prototipo; ahora necesita los 5 días para entrenar la semana completa sin volver al documento viejo, y una forma de dejar registro de lo que levantó para saber si está progresando.

## Alcance

### La v1 SÍ hace
1. Muestra los 5 días completos de la rutina (`rutina-5-dias.md`: Día 1 glúteo, Día 2 espalda/bíceps, Día 3 cuádriceps, Día 4 hombro/tríceps, Día 5 cadena posterior/abducción), cada uno con sus ejercicios, series x reps, intensidad (RIR), descanso y nota técnica, en el mismo formato de lista con tap para expandir validado en Fase 1.
2. Por cada ejercicio, incluye foto de referencia de la máquina/postura y video corto de ejecución correcta, de fuentes públicas (YouTube, sitios de referencia de entrenamiento) — ya no son opcionales como en Fase 1, van por defecto dado que Bodytech Usaquén es un gimnasio bien equipado y los ejercicios usan máquinas y movimientos estándar.
3. Permite marcar cada serie como completada mientras entrena, para saber en qué punto del día va.
4. Permite registrar el peso usado en cada ejercicio, sesión por sesión, para comparar contra la sesión anterior y aplicar la regla de progresión de doble progresión definida en cada día.

### La v1 NO hace
- No calcula automáticamente cuándo tocar descarga — Lina revisa el criterio de cada día (ej. "dos sesiones seguidas sin subir reps") y decide.
- No rediseña la rutina automáticamente con un InBody nuevo — un rediseño completo solo ocurre ante señal real de estancamiento, desbalance o plateau, y lo decide Lina, no la app.
- No lleva historial de InBody dentro de la app.
- No genera gráficas ni dashboards de progreso — solo muestra el peso de la sesión actual y el de la sesión anterior, para comparar.
- No tiene login (uso personal, una sola usuaria).
- No funciona offline.

## Comportamiento esperado
1. Lina abre la app y ve los 5 días de la semana (en el orden Día 1 a Día 5, el orden en que se entrenan, con los días de torso entre los de pierna pesada).
2. Entra al día que le toca y ve la lista de ejercicios de ese día, igual que en Fase 1.
3. Toca un ejercicio y ve: series x reps, RIR, descanso, nota técnica, foto de la máquina/postura, video de ejecución, y su alternativa.
4. Mientras entrena, marca cada serie como completada a medida que la hace.
5. Registra el peso que usó en el ejercicio. La próxima vez que abra ese mismo día, ve el peso de la sesión anterior junto al campo para registrar el de hoy, para saber si debe subir carga según la regla de progresión.

## Errores y seguridad
- Ejercicio sin foto o video disponible en fuente pública: se muestra solo el texto (nombre, series, reps, nota técnica), sin foto ni video — no bloquea el uso del día.
- Ejercicio sin alternativa cargada: mismo comportamiento que Fase 1 — aviso explícito de que no tiene alternativa registrada.
- Si Lina no registra el peso de una sesión, la app simplemente no muestra comparación esa vez; no es un error, no bloquea nada.
- Restricción de rodilla, exclusión de pecho y de pantorrilla: se mantienen como filtro en los 5 días, igual que en Fase 1 — ningún ejercicio ni alternativa de ningún día las viola.
- No hay datos sensibles más allá del uso personal de Lina; no aplica cifrado ni permisos adicionales.

## Éxito
La Fase 2 funciona si, después de 2-3 semanas usando los 5 días completos:
1. Lina entrena su semana completa desde la app, sin volver al documento viejo en ningún día.
2. El registro de peso le permite ver si está progresando (subiendo carga o reps) en al menos los ejercicios compuestos principales de cada día, en vez de depender de la memoria.

## V2
- Gráficas o dashboard de progreso de peso/reps a lo largo del mesociclo.
- Aviso automático cuando el criterio de descarga de un día se cumple (hoy lo revisa Lina manualmente).
- Historial de InBody dentro de la app (backlog original: no acerca a la acción core).
