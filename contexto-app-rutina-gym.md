# Contexto: App de rutina de gimnasio (Lina)

## Objetivo
Construir una app interactiva (navegador, celular, asume buena conexión — no necesita funcionar offline) que muestre el detalle de una rutina de gimnasio con enfoque en pierna y glúteo, con alternativas por ejercicio y explicaciones. No es un documento estático tipo PDF: debe permitir consultar alternativas y explicaciones sobre la marcha.

## Perfil y contexto de Lina
- Entrena en Bodytech Usaquén, más de 7 años de experiencia en gimnasio.
- Objetivos: crecimiento de glúteo, desarrollo general de pierna, mejora de composición corporal (ganancia muscular + reducción de grasa).
- Entrena 5 días por semana, sexto día opcional de cardio (caminadora inclinada) o boxeo.
- Condición articular: evita alto impacto y evita profundidad completa de flexión de rodilla (no sentadilla/hack squat/leg press a rango completo, rango controlado en lunges y sentadilla búlgara). No hay un ángulo exacto definido, es una restricción práctica ("evito mucha profundidad e impacto").
- Exclusiones explícitas: sin ejercicios de pecho, sin ejercicios de pantorrilla.
- Suplementación: proteína whey isolate y creatina.

## Equipo disponible (Bodytech Usaquén)
Máquinas Panatta: Booty Builder / hip thrust machine, hack squat, leg press, leg curl sentado y acostado. Además: Smith Machine, cables, mancuernas. (Hay fotos del equipo disponibles en el proyecto "Gym routine" de Claude — carpeta de archivos adjuntos, útiles para verificar variantes exactas de cada máquina antes de seleccionar ejercicios).

## Datos de composición corporal (InBody)
Tres mediciones registradas hasta ahora, todas dentro de rango normal y con cambios pequeños (progreso estable, no estancamiento):

| Fecha | Peso | MME (músculo esquelético) | PGC (% grasa) | Cintura-cadera | Puntuación InBody |
|---|---|---|---|---|---|
| 27.04.2026 | 67.0 kg | 28.5 kg | 23.4% | 0.83 | 84/100 |
| 11.06.2026 | 66.6 kg | 28.6 kg | 23.1% | 0.85 | 84/100 |
| 21.07.2026 | 67.8 kg | 28.9 kg | 23.2% | 0.84 | 85/100 |

**InBody nuevo ya registrado (21.07.2026).** Los cambios frente a la medición anterior son pequeños (+1.2 kg peso, +0.3 kg MME, +0.1 pp PGC, puntuación 84→85): no hay señal de estancamiento, desbalance ni plateau, así que por la regla de la sección "Decisiones de alcance" (punto 2) esto NO dispara un rediseño completo del programa una vez que exista. Pero como todavía no existe una versión real del programa (solo el v1 de ejemplo), este dato es el que dispara el diseño real de la rutina por primera vez — ver punto 1 de "Decisiones de alcance". Se actualiza como historial; la app debe reflejar esta fila más reciente si en algún punto muestra datos de InBody.

## Metodología y fuentes
Programación basada en el sistema de Bret Contreras (Glute Lab), complementada con otras fuentes evidence-based de entrenamiento de glúteo/pierna. Categorías de Contreras a usar en la selección de ejercicios:
- **Activators**: carga pesada, posición acortada del glúteo (ej. hip thrust con barra).
- **Stretchers**: carga en posición elongada (ej. peso muerto rumano, sentadilla búlgara, back extension).
- **Pumpers**: alto número de repeticiones, rango corto (ej. abducciones, frog pump, kickback).

Técnicas de referencia ya validadas con Lina en programas anteriores: back extension con espalda redondeada y pies a 45° hacia afuera, hip thrust en B-stance para corrección unilateral, variar posición de pies en hip thrust entre series, pausa en el pico de contracción de glúteo. Evitar duplicar el mismo ejercicio (ej. back extension) en más de un día de la semana.

## Estructura de la rutina
5 días: 3 de tren inferior (con distintos énfasis — ej. glúteo/patrón de empuje, dominante de cuádriceps, cadena posterior/abducción) + 2 de tren superior (pull: espalda y bíceps / push: hombro y tríceps, bien diferenciados entre sí para no repetir cobertura muscular).

## Decisiones de alcance (de la sesión de brainstorming)
1. **La rutina actual de la app es un v1 de ejemplo**, construido para validar formato y contenido de la app. No es la versión definitiva. El InBody nuevo ya está registrado (21.07.2026) y es el dato que debe usarse para diseñar la versión real de la rutina. Esto debe quedar explícito dentro de la app para que no se confunda con la versión final.
2. **Cadencia de rediseño futura**: el programa corre en mesociclos de 6-8 semanas con progresión de carga dentro del bloque. Un InBody nuevo se registra como historial, pero NO dispara automáticamente un rediseño completo — el rediseño completo solo ocurre si hay una señal real: estancamiento, desbalance entre lados, o plateau de fuerza. Esto es así porque cambios de composición corporal de 0.1-0.4 kg entre mediciones son ruido de medición, no señal de que el programa deba cambiar, y rediseñar todo con esa frecuencia rompe la continuidad de cargas necesaria para trackear progressive overload.
3. **Propósito de las alternativas de ejercicio**: mostrar alternativas quiere resolver dos casos — máquina ocupada en el gym (plan B inmediato sin perder el enfoque del día) y variedad para no aburrirse. No es principalmente un mecanismo de manejo de dolor puntual (aunque la restricción de rodilla/impacto sigue siendo un filtro base para toda la selección de ejercicios).
4. **Formato de la app**: se abre desde el navegador del celular, Lina tiene buena conexión de datos, así que puede depender de carga en vivo sin problema — no hace falta que funcione offline.
5. **Fase de entrenamiento confirmada: acumulación.** Al armar la rutina de 5 días con /gym-coach, Lina había elegido inicialmente "mantenimiento", lo cual contradecía su objetivo de crecer masa muscular en tren inferior — mantenimiento no genera crecimiento por diseño. Confirmó que su enfoque es crecimiento y que la fase correcta es acumulación (volumen alto, prioridad construir masa). La rutina de `rutina-5-dias.md` está diseñada bajo esta fase, no mantenimiento.

## Riesgos identificados a tener en cuenta
1. Que el v1 de ejemplo se quede como versión definitiva por inercia si no se marca como provisional.
2. La restricción de rodilla no tiene un ángulo o límite exacto definido — la selección de rango en hack squat, leg press, sentadilla búlgara y lunges depende de una estimación razonable, con riesgo de generar molestia si el rango elegido es excesivo. Validar con Lina el rango específico en el prototipo antes de aplicarlo a los 5 días.
3. Las alternativas y explicaciones deben anclarse a la metodología de Contreras y al equipo Panatta real disponible — no deben ser contenido genérico de gym.

## Siguiente paso acordado
Construir un solo día de la rutina (ej. el de énfasis en glúteo) como prototipo de la app — con sus ejercicios, alternativas y explicaciones — y validarlo con Lina antes de construir los 5 días completos.
