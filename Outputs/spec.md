# Spec: App Rutina Gym (Lina) — Fase 1: Prototipo de un día
Fecha: 2026-07-28

## Overview
App web que Lina abre desde el navegador del celular para consultar, en vivo y dentro del gym, un solo día de su rutina de glúteo y pierna: qué ejercicio toca, con qué alternativa si la máquina está ocupada, y por qué se hace así. Este es el prototipo que valida formato y contenido antes de construir los 5 días completos. El contenido del día ya no es el ejemplo de v1: está ajustado para atacar el estancamiento que Lina percibe en su objetivo de masa muscular de tren inferior.

## Usuarios objetivo
Una sola usuaria: Lina, más de 7 años entrenando en Bodytech Usaquén. Hoy consulta su rutina en un documento estático (PDF): no le permite ver alternativas ni explicaciones sobre la marcha cuando una máquina está ocupada o cuando duda de la técnica de un ejercicio.

## Alcance

### La v1 SÍ hace
1. Muestra la lista de ejercicios del día de énfasis en glúteo, con sus series y reps, con contenido ajustado para atacar el estancamiento de tren inferior (no el ejemplo genérico original).
2. Por cada ejercicio, ofrece una alternativa (para cuando la máquina está ocupada), con opción de ver foto de la máquina real de Bodytech y un video de la ejecución.
3. Muestra una explicación de técnica por ejercicio, anclada a la metodología de Contreras (Activators/Stretchers/Pumpers) y a las técnicas ya validadas con Lina (ej. back extension con espalda redondeada, hip thrust en B-stance).
4. Muestra un aviso visible de que esta es una versión prototipo de un solo día, pendiente de validación, no la versión final del programa de 5 días.

### La v1 NO hace
- No incluye los otros 4 días de la rutina (solo el día de énfasis en glúteo).
- No permite marcar series/reps como completadas durante el entrenamiento.
- No registra el peso usado por ejercicio.
- No muestra historial de InBody dentro de la app.
- No funciona offline (asume buena conexión de datos, como siempre la tiene Lina).
- No tiene login ni ninguna forma de autenticación (uso personal, una sola usuaria).
- No rediseña nada automáticamente cuando llegue un InBody futuro.

## Comportamiento esperado
1. Lina abre la app desde el navegador de su celular.
2. Ve una lista con los ejercicios del día, en el orden en que los va a hacer.
3. Toca un ejercicio y se expande mostrando: series y reps, explicación de técnica, y la opción de ver su alternativa.
4. Si toca "ver alternativa", ve el ejercicio alternativo con su propia foto de máquina, video y explicación.
5. En todo momento ve un aviso fijo (banner) que dice que esta es una versión prototipo de un día, pendiente de validación.

## Errores y seguridad
- **Ejercicio sin alternativa cargada:** se muestra un aviso explícito ("este ejercicio no tiene alternativa registrada") en vez de ocultar la sección sin explicación.
- **Restricción de rodilla:** ningún ejercicio ni alternativa del día puede requerir rango completo de flexión de rodilla ni alto impacto (aplica a hack squat, leg press, lunges, sentadilla búlgara). Si un ejercicio no puede ajustarse a esta restricción, no se incluye ni como principal ni como alternativa.
- **Exclusiones:** ningún ejercicio de pecho ni de pantorrilla aparece en el día, ni como principal ni como alternativa.
- **Sin conexión:** no se maneja como caso especial — la app depende de carga en vivo, no hace falta modo offline.
- No hay datos sensibles que proteger más allá del uso personal de Lina; no aplica cifrado ni permisos adicionales.

## Éxito
El prototipo funciona si se cumplen, en este orden:
1. Lina revisa el contenido completo del día (ejercicios, alternativas, explicaciones) desde la app y confirma que es correcto y que ataca el objetivo de tren inferior.
2. Lina entrena ese día en el gym usando la app desde el celular, sin volver al PDF viejo y sin quedarse con dudas en ningún ejercicio.

Si ambos pasos se cumplen, hay luz verde para construir los 5 días completos (Fase 2 del roadmap).

## V2
- Los 5 días completos de la rutina (3 tren inferior + 2 tren superior).
- Marcar series/reps completadas durante el entrenamiento.
- Registrar el peso usado por ejercicio, para trackear progresión de carga en el mesociclo.
- Historial de InBody dentro de la app (en backlog: no acerca a la acción core de consultar la rutina).
