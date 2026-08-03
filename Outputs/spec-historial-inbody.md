# Spec: App Rutina Gym (Lina) — Fase 3: Historial de InBody
Fecha: 2026-07-30

## Overview
Sección aparte dentro de la app ("Progreso") donde Lina registra cada medición de InBody y ve su tendencia en una gráfica de líneas. No es parte de la acción core de consultar la rutina; es un feature de seguimiento personal que Lina decidió sacar del backlog.

## Usuarios objetivo
Lina, la misma usuaria única de las Fases 1 y 2. Hoy transcribe sus mediciones de InBody a mano en un documento de texto cada vez que actualiza el contexto del proyecto; quiere verlas como tendencia dentro de la misma app que ya usa para su rutina.

## Alcance

### La v1 SÍ hace
1. Un formulario para agregar una medición nueva: fecha, peso, MME, PGC, cintura-cadera y puntuación InBody.
2. Una gráfica de líneas con la tendencia de peso, MME y PGC a lo largo del tiempo, en una sección aparte llamada "Progreso", separada del flujo del día de rutina.
3. Resalta visualmente los puntos donde el cambio frente a la medición anterior supera un umbral (propuesta: más de 0.5 kg en peso o MME, más de 0.5 puntos porcentuales en PGC, o cintura-cadera fuera de 0.80-0.85) — validar este umbral con Lina antes de construir, porque hoy no hay uno definido con precisión, solo la referencia de que cambios de 0.1-0.4 kg son ruido.
4. Al tocar un punto de la gráfica, muestra el valor exacto de esa medición (fecha, peso, MME, PGC, cintura-cadera, puntuación).

### La v1 NO hace
- No decide ni sugiere si toca rediseñar la rutina — esa decisión sigue siendo manual de Lina, según la regla ya establecida (rediseño solo ante señal real de estancamiento, desbalance o plateau).
- No importa datos automáticamente desde el dispositivo InBody; Lina los transcribe a mano.
- No se conecta ni depende de los 5 días de rutina de la Fase 2 — funciona independiente.
- No compara contra el rango "normal" del reporte InBody (eso es V2).
- No tiene login (mismo uso personal sin autenticación del resto de la app).

## Comportamiento esperado
1. Lina entra a la sección "Progreso" desde el menú principal de la app.
2. Ve la gráfica de líneas con la tendencia de peso, MME y PGC.
3. Los puntos donde el cambio frente a la medición anterior supera el umbral se ven resaltados (ej. color distinto).
4. Toca cualquier punto y ve el valor exacto de esa medición.
5. Toca "agregar medición", llena fecha, peso, MME, PGC, cintura-cadera y puntuación, y la gráfica se actualiza con el dato nuevo.

## Errores y seguridad
- Si un campo queda vacío o el valor no es numérico donde debería serlo, la app no guarda la medición y señala el campo específico a corregir.
- Si solo hay una medición registrada, no hay nada que comparar: se muestra el punto único sin resaltar cambios ni tendencia.
- No hay datos sensibles de terceros — son datos personales de Lina, con el mismo nivel de privacidad del resto de la app (uso personal, sin login).

## Éxito
Lina puede ver, sin abrir el reporte de InBody, si su tendencia de peso, MME y PGC va en la dirección esperada, y la app le hace notar visualmente cuándo un cambio es grande de verdad — sin que tenga que comparar los números a mano cada vez.

## V2
- Comparar el historial contra el rango "normal" que trae cada reporte de InBody (ej. 51.6-69.8 kg de peso).
- Exportar o compartir la gráfica.
- Vincular un cambio grande detectado con un recordatorio de revisar si toca rediseñar la rutina (hoy esa decisión la toma Lina manualmente, sin ayuda de la app).
