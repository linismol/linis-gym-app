# Linis Gym App — Rutina de glúteo y pierna

App web para consultar, en vivo desde el celular en el gym, una rutina de entrenamiento con enfoque en glúteo y pierna: qué ejercicio toca, sus series y reps, una **alternativa** por si la máquina está ocupada, y la **explicación de técnica** de cada ejercicio. Diseñada para Lina (Bodytech Usaquén), basada en la metodología de glúteo de Bret Contreras (Activators / Stretchers / Pumpers) y respetando su restricción de rodilla (rango controlado, sin impacto) y sus exclusiones (sin pecho ni pantorrilla).

## Apps

| Archivo | Qué es |
|---|---|
| [`Rutina Gym - 5 Días.html`](Rutina%20Gym%20-%205%20D%C3%ADas.html) | **App completa (Fase 2)** — 5 días de rutina con pestañas, checkbox para marcar ejercicios, registro de peso por serie, alternativas con foto y video, e historial de mediciones InBody con formulario para agregar nuevas. |
| [`Rutina Gym - Día Glúteo.html`](Rutina%20Gym%20-%20D%C3%ADa%20Gl%C3%BAteo.html) | **Prototipo de un día (Fase 1)** — el día de glúteo aislado, usado para validar formato y contenido antes de construir los 5 días. |

Ambas son archivos HTML autónomos: se abren directamente en el navegador del celular (tipografía Inter Tight vía Google Fonts, asume buena conexión). No requieren build ni servidor.

### Cómo abrirla
Abre el archivo `.html` en cualquier navegador moderno, o publícalo en un hosting estático (GitHub Pages, Netlify, etc.).

## Diseño
La UI está construida sobre el **Nimbus Design System** (paleta rosa/navy/amarillo/naranja + Inter Tight), importado desde un proyecto de Claude Design. Los tokens (color, tipografía, espaciado, efectos) y los componentes (Badge, Tag, Button, Checkbox, Input) están reproducidos como CSS/JS estándar dentro de cada archivo.

## Documentación del proyecto
- [`contexto-app-rutina-gym.md`](contexto-app-rutina-gym.md) — contexto completo (perfil, equipo, metodología, decisiones de alcance).
- [`Outputs/roadmap.md`](Outputs/roadmap.md) — roadmap por fases.
- [`Outputs/spec.md`](Outputs/spec.md) — spec de la Fase 1.

## Estado / pendientes
- Las **fotos de máquina** son imágenes stock de referencia y el botón de **video** abre una búsqueda en YouTube — falta reemplazarlas por las máquinas reales de Bodytech Usaquén y videos grabados.
- El estado (pesos registrados, ejercicios marcados, mediciones nuevas) es **solo en memoria**: se reinicia al recargar. Persistencia con `localStorage` es un siguiente paso opcional.

---
> Nota: la app incluye datos personales de composición corporal (InBody). Manténla en un repositorio privado si no quieres que sean públicos.
