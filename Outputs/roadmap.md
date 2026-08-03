# Roadmap: App Rutina Gym (Lina) — Glúteo y Pierna
Fecha: 2026-07-28

## La idea en una frase
App web que Lina abre desde el celular en el gym para consultar su rutina de glúteo y pierna: qué ejercicio toca, con qué alternativa si la máquina está ocupada, y por qué se hace así.

## La acción core
Consultar el día de rutina: ver el ejercicio actual, sus series y reps, y su alternativa. Todo lo demás (marcar progreso, registrar peso, historial) sirve a esta acción, no la reemplaza.

## Fase 1 — Lanzamiento
Ya está acordado con Lina que el lanzamiento es un solo día prototipo (el de énfasis en glúteo), no los 5 días. Sirve para validar formato y contenido antes de construir el resto.

**Antes de construir:** el InBody del 21.07.2026 no muestra por sí solo estancamiento (los cambios son pequeños), pero Lina reporta que percibe que no está logrando su objetivo de masa muscular en tren inferior (pierna y glúteo). Esa percepción sí es la señal real que la regla de "Decisiones de alcance" (punto 2) define como disparador de rediseño — a diferencia de un InBody nuevo por sí solo, que no dispara nada. Por eso el contenido del día prototipo (ejercicios, volumen, carga) debe ajustarse para atacar ese estancamiento antes de darlo por listo para validar, no solo actualizarse con los números nuevos.

| # | Feature | Por qué va primero | Depende de |
|---|---------|--------------------|------------|
| 1 | Detalle del día: ejercicios, series y reps, con contenido ajustado para atacar el estancamiento de tren inferior | Es la acción core, y ya no puede ser el contenido de ejemplo — la señal de estancamiento la reemplaza por una versión pensada para producir resultado. | — |
| 2 | Alternativa por ejercicio (máquina ocupada) | Lina lo mencionó primero al soltar ideas — es el caso real que le pasa en el gym, no un extra. | #1 |
| 3 | Explicación de técnica por ejercicio | Ancla el contenido a Contreras y evita que la app sea genérica; resuelve el "cómo" una vez resuelto el "qué". | #1 |
| 4 | Aviso de "esto es un prototipo, no la versión final" | Riesgo explícito ya identificado: si no se marca, el v1 se queda como definitivo por inercia. Sigue aplicando aunque el contenido ya sea el ajustado, porque falta validar con Lina. | #1 |

## Fase 2 — Mejora
Se construye después de validar el prototipo con Lina, e incorpora lo aprendido de esa validación (incluido el rango de movimiento real para rodilla).

- **Los 5 días completos de la rutina** (3 tren inferior + 2 tren superior). Es la extensión directa del prototipo validado — sin este paso la app solo cubre un día de cinco.
- **Marcar series/reps completadas.** Mejora la sesión en vivo una vez que ya se usa la app en el gym; no bloquea el lanzamiento porque el prototipo se valida mirando contenido, no marcando progreso.
- **Registrar peso usado por ejercicio.** Tiene sentido cuando ya hay 5 días en uso real y progresión de carga que trackear dentro del mesociclo de 6-8 semanas — antes de eso no hay nada que registrar.

## Fase 3 — Historial de InBody
Promovida desde el backlog: Lina la priorizó aunque no acerca a la acción core (consultar la rutina). Ver `spec-historial-inbody.md`.

- **Registrar mediciones de InBody y verlas en gráfica de líneas**, en una sección aparte ("Progreso"), con los cambios grandes resaltados visualmente. No sustituye la decisión manual de rediseñar la rutina — solo la informa.

## Fase 4 — Chequeo de progreso
Depende de que existan los datos de Fase 2 (peso/reps por sesión) y Fase 3 (historial de InBody). Ver `spec-chequeo-progreso.md`.

- **Sección "Chequeo"** que avisa cuándo toca InBody nuevo (6-8 semanas desde la última medición) y cuándo hay señal real de estancamiento en la rutina (3 sesiones sin progresar en un compuesto principal, o plateau de MME en 2-3 mediciones seguidas). Solo señala — la decisión de qué hacer sigue siendo de Lina, no automática.

## Backlog
- **Gráficas o dashboard de progreso de peso/reps (de la rutina, no de InBody).** Depende de tener datos reales de la Fase 2 (registro de peso) antes de decidir si vale la pena visualizarlos así.
- **Rediseño automático de la rutina según nuevo InBody.** Contradice una decisión ya tomada: el rediseño completo solo ocurre ante señal real (estancamiento, desbalance, plateau), nunca automático por una medición nueva. Distinto del ajuste de contenido en Fase 1: ese se activó porque Lina reportó la señal real (estancamiento percibido en tren inferior), no porque llegó un InBody nuevo.

## Siguiente paso
Fase 1, Fase 2 y Fase 3 ya tienen spec (`spec.md`, `spec-fase2.md`, `spec-historial-inbody.md`). Siguiente: generar el `plan.md` de la fase que se vaya a construir primero.
