---
name: crear-roadmap
description: >
  Usar cuando el usuario tenga una idea de producto, app o herramienta y
  quiera definir QUÉ construir y EN QUÉ ORDEN: diga "roadmap", "por dónde
  empiezo", "en qué orden desarrollo esto", "qué features hago primero",
  o pase el contexto de una idea nueva antes de construirla.
  NO usar para escribir el spec de una feature (para eso está crear-specs),
  ni para priorizar tareas del día a día.
---

# Crear roadmap de desarrollo

## Objetivo

Convertir una idea (y su contexto) en un `roadmap.md`: la lista ordenada de features por fases, decidiendo qué se construye primero y por qué. El resultado alimenta al skill `crear-specs`: cada fase del roadmap se convierte después en un spec.

## Instrucciones

1. **Lee primero el contexto que pase el usuario** (archivos, investigación, notas de brainstorming). No preguntes lo que ya está respondido ahí.
2. **Entrevista con preguntas de opción múltiple** (AskUserQuestion), una a la vez, máximo 8. Cubre lo que falte de:
   - El objetivo: ¿qué cambia en la vida del usuario si esto existe?
   - El usuario principal: ¿quién lo usa primero? (uno, no tres)
   - El brain dump: ¿qué features imagina? Pídele que suelte TODAS, sin filtrar.
   - La acción core: de todo eso, ¿cuál es la única acción que entrega el valor? (si el producto solo tuviera un botón, ¿cuál sería?)
   - Restricciones: tiempo disponible, nivel técnico, con qué herramientas cuenta.
   - Validación: ¿qué señal le diría más rápido que esto vale la pena?
3. **Prioriza con tres criterios, en este orden:**
   - **Valor:** ¿qué tan cerca está la feature de la acción core?
   - **Dependencias:** ¿qué necesita existir antes? (no hay ranking sin usuarios, no hay notificaciones sin datos)
   - **Esfuerzo:** entre dos features de valor similar, primero la más simple.
4. **Agrupa en fases.** Cada fase debe ser algo **usable y completo por sí solo**:
   - **Fase 1 — el lanzamiento:** el camino más corto al primer usuario contento. Máximo 3-4 features.
   - **Fase 2 — la mejora:** lo que se gana con lo aprendido de la Fase 1.
   - **Backlog:** todo lo demás. Nada se pierde, pero nada de aquí bloquea el lanzamiento.
5. **Cuestiona las features de vanidad.** Si algo suena impresionante pero no acerca al usuario a la acción core (dashboards, gamificación, IA "porque sí"), muévelo al backlog y di por qué.
6. Guarda el resultado como `roadmap.md` en la carpeta del proyecto.
7. **Cierra con el siguiente paso:** "La Fase 1 está lista para convertirse en spec — usa /crear-specs y pásale este roadmap como contexto."

## Formato de salida (roadmap.md)

```
# Roadmap: [nombre del proyecto]
Fecha: [fecha]

## La idea en una frase
[Qué es y para quién.]

## La acción core
[La única acción que entrega el valor. Todo lo demás la sirve.]

## Fase 1 — Lanzamiento
| # | Feature | Por qué va primero | Depende de |
|---|---------|--------------------|------------|
| 1 | ...     | ...                | —          |
| 2 | ...     | ...                | #1         |

## Fase 2 — Mejora
[Features con su porqué, en orden.]

## Backlog
[Todo lo recortado, sin orden. Aquí viven las ideas de vanidad
y lo que necesita datos de la Fase 1 para decidirse.]

## Siguiente paso
Convertir la Fase 1 en spec con /crear-specs, usando este roadmap
como contexto.
```

## Reglas

- El roadmap ordena QUÉ construir; nunca incluye decisiones técnicas ni tiempos de desarrollo (eso sale del plan, después del spec).
- Si el usuario insiste en meter 6+ features en la Fase 1, muéstrale el costo: cada feature extra aleja la fecha en que alguien usa el producto.
- El roadmap es un documento vivo: después de lanzar cada fase, se revisa con lo aprendido.