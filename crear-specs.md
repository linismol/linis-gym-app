---
name: crear-specs
description: >
  Usar cuando el usuario quiera crear un spec para construir algo (una app,
  página, herramienta o feature), diga "crea el spec", "hagamos el spec",
  "quiero construir/lanzar X", o esté por empezar un proyecto con Claude Code.
  También usar antes de construir cualquier cosa nueva de más de una sesión.
  NO usar para ajustes pequeños a algo que ya existe, ni para tareas que no
  producen software (documentos, análisis, correos).
---

# Crear specs

## Objetivo

Convertir una idea en un `spec.md` claro que guíe toda la construcción: el documento más importante del proyecto. El spec define QUÉ debe pasar desde el punto de vista del usuario — nunca CÓMO implementarlo.

## Instrucciones

1. **Nunca escribas el spec de una.** Primero entrevista al usuario con preguntas de opción múltiple (AskUserQuestion), una a la vez, máximo 8. Cubre:
   - La idea en una frase: ¿qué quiere construir y para qué?
   - **Usuarios objetivo:** ¿quién lo va a usar? ¿qué problema tiene hoy?
   - **El trabajo principal:** si el proyecto solo hiciera UNA cosa bien, ¿cuál?
   - **Alcance de la v1:** ¿qué hace? Y más importante: ¿qué NO hace? (proponle qué recortar: pagos, login, app móvil, videos suelen sobrar en una v1)
   - **Comportamiento esperado:** ¿qué ve y hace el usuario, paso a paso?
   - **Casos raros y errores:** ¿qué pasa si no hay datos, si algo falla, si alguien lo usa mal?
   - **Éxito medible:** ¿cómo sabe el usuario que funcionó?
2. Si una respuesta es vaga, pide un ejemplo concreto antes de seguir.
3. **Recorta sin piedad.** Si el alcance de la v1 tiene más de 3 funcionalidades, cuestiona cada una: "¿esto es necesario para lanzar, o puede ser v2?". Todo lo recortado va a la sección de V2.
4. Escribe el spec desde el punto de vista del usuario, en lenguaje simple. **Prohibido incluir decisiones técnicas** (base de datos, lenguajes, arquitectura): eso se decide en el plan, no en el spec.
5. Guarda el resultado como `spec.md` en la carpeta del proyecto.
6. Al terminar, ofrece los dos pasos siguientes: (a) generar el `plan.md` (la lista de tareas que sale del spec, para aprobar antes de construir), y (b) recordar la regla del flujo: **si durante la construcción un error se repite, se corrige el spec — no solo el código.**

## Formato de salida (spec.md)

```
# Spec: [nombre del proyecto]
Fecha: [fecha]

## Overview
[Resumen ejecutivo en 3-5 líneas: qué es, para quién, y el objetivo.]

## Usuarios objetivo
[Quiénes son, qué problema tienen hoy, qué usan actualmente.]

## Alcance
### La v1 SÍ hace
[Lista corta, máximo 3-4 funcionalidades.]
### La v1 NO hace
[Lista explícita. Esta sección es la pared de carga del proyecto.]

## Comportamiento esperado
[Paso a paso desde los ojos del usuario: entra, ve X, hace Y, pasa Z.]

## Errores y seguridad
[Qué puede salir mal y cómo se maneja: sin datos, entradas inválidas,
qué información se protege.]

## Éxito
[Cómo se ve que funcionó, medible.]

## V2 (opcional)
[Todo lo recortado de la v1. El futuro vive aquí, no en el alcance.]
```

## Reglas

- Un spec por proyecto o feature grande. Si el usuario mezcla dos ideas, sepáralas en dos specs.
- El spec debe poder leerlo alguien no técnico y entender exactamente qué se va a construir.
- Si el usuario ya tiene investigación o contexto (archivos, notas de Cowork), léelos antes de entrevistar y no preguntes lo que ya está respondido ahí.