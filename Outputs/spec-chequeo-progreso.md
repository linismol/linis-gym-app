# Spec: App Rutina Gym (Lina) — Fase 4: Chequeo de progreso
Fecha: 2026-07-30

## Overview
Sección "Chequeo" dentro de la app donde Lina revisa, cuando quiera, dos recomendaciones automáticas: si toca tomarse un InBody nuevo (por tiempo transcurrido) y si hay señal real de que conviene revisar la rutina (por estancamiento de carga o plateau de InBody). La app no decide ni ejecuta ningún cambio — solo lo señala; Lina decide qué hacer con esa información. Depende de que ya existan los datos de Fase 2 (peso/reps por sesión) y Fase 3 (historial de InBody).

## Usuarios objetivo
Lina, misma usuaria de las fases anteriores. Hoy calcula esto mentalmente o lo revisa en conversación; quiere que la app se lo recuerde con base en los datos que ya registra.

## Alcance

### La v1 SÍ hace
1. **Recordatorio de InBody:** cuenta las semanas desde la última medición registrada en Fase 3 y avisa cuando pasaron 6-8 semanas.
2. **Aviso de estancamiento de carga:** revisa el peso/reps registrado en Fase 2 para los compuestos principales de cada día (hip thrust, prensa, hack squat, RDL, press de hombro, jalón) y avisa si alguno no subió peso ni reps en 3 sesiones seguidas.
3. **Aviso de plateau de InBody:** revisa si el MME no cambió en las últimas 2-3 mediciones seguidas mientras Lina está en fase de acumulación, y lo señala como posible plateau.
4. Todo vive en una sección aparte llamada "Chequeo", que Lina revisa cuando quiere — no interrumpe el flujo de consultar el día de rutina.

### La v1 NO hace
- No decide ni ejecuta un rediseño de rutina — solo lo señala; Lina decide qué hacer.
- No detecta desbalance entre lados en ejercicios unilaterales (búlgara, remo a una mano) — Lina decidió dejarlo fuera porque requeriría registrar peso/reps por lado en Fase 2, más registro manual del que quiere hacer por ahora.
- No manda notificaciones push fuera de la app — Lina debe entrar a la sección "Chequeo" para verlo.
- No cambia el criterio de descarga de cada día (eso ya está definido por ejercicio en `rutina-5-dias.md` y sigue siendo una decisión manual de Lina).

## Comportamiento esperado
1. Lina entra a la sección "Chequeo" desde el menú principal.
2. Ve dos bloques: "InBody" y "Rutina".
3. En "InBody": si pasaron 6-8 semanas o más desde la última medición, ve un aviso de "toca InBody nuevo" con la fecha de la última medición y las semanas transcurridas. Si no, ve cuántas semanas faltan.
4. En "Rutina": si algún compuesto principal lleva 3 sesiones seguidas sin subir peso ni reps, aparece listado con su nombre y el día al que pertenece. Si el MME lleva 2-3 mediciones seguidas sin cambio, también aparece señalado. Si no hay ninguna señal, ve un estado de "todo progresando, sin señales de estancamiento".

## Errores y seguridad
- Si no hay suficientes datos todavía (menos de 3 sesiones registradas de un ejercicio, o menos de 2 mediciones de InBody), esa sección no muestra ningún aviso — no es un error, es falta de datos.
- Si Lina no ha registrado peso en Fase 2 para algún ejercicio, ese ejercicio no entra al cálculo de estancamiento — no se asume ni se inventa un dato.
- No hay datos sensibles de terceros; mismo nivel de privacidad que el resto de la app (uso personal, sin login).

## Éxito
Lina revisa "Chequeo" y en menos de 10 segundos sabe si toca InBody nuevo o si hay alguna señal real de estancamiento que valga la pena revisar con calma, sin tener que comparar sesiones o fechas a mano.

## V2
- Notificación dentro de la app (no push) cuando aparece una señal nueva, sin que Lina tenga que entrar a revisar por su cuenta.
- Detectar desbalance entre lados, si en el futuro Lina decide registrar peso/reps por lado.
- Sugerencia concreta de qué cambiar en la rutina cuando hay señal de estancamiento (hoy solo señala que existe, no qué hacer con ella).
