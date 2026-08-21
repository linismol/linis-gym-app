# Supabase — almacenamiento persistente

Reemplaza el estado en memoria (se pierde al recargar) por Postgres real vía
Supabase. El navegador habla **directo** con Supabase (sin proxy tipo
Azure/APIM) — la protección viene de Row Level Security (RLS), no de esconder
una key.

```
app (linismol.github.io) ──fetch/SDK──► Supabase (Postgres + REST vía RLS)
```

## Qué persiste vs. qué se queda como está

| Dato | Se guarda en Supabase |
|---|---|
| Pesos, reps, RIR por ejercicio | ✅ `app_state` |
| Checkboxes de "completado" | ✅ `app_state` |
| Ejercicio seleccionado en la gráfica de Seguimiento | ✅ `app_state` |
| Historial de mediciones InBody | ✅ `inbody_measurements` |
| Historial real por sesión (para detectar estancamiento) | ✅ `exercise_logs` (migración 002) |
| Chat con /gym-coach y el análisis semanal | ❌ se queda solo en memoria — es barato regenerarlo, no aporta guardarlo |

## Paso a paso (tú)

1. **Crea el proyecto:** [supabase.com](https://supabase.com) → inicia sesión o crea cuenta → **New project**.
   - **Name:** `linis-gym-app` · elige una **Database Password** (guárdala, no la necesitas para la app) · **Region:** la más cercana.
   - Espera ~2 minutos mientras se aprovisiona.
2. **Crea las tablas:** en el proyecto → menú **SQL Editor** → **New query** → pega **todo** el contenido de [`supabase/schema.sql`](schema.sql) → **Run**.
   - Verifica que corrió sin errores y que aparecen las tablas `app_state` e `inbody_measurements` en **Table Editor**.
3. **Copia tus credenciales:** menú **Project Settings** (⚙️) → **API** → copia:
   - **Project URL** (algo como `https://xxxxxxxx.supabase.co`)
   - **anon public** key (⚠️ la marcada como **`anon` `public`** — **nunca** la `service_role`, esa sí es secreta y no debe ir en el cliente)
4. **Pásame esos dos valores** (URL + anon key) y yo conecto la app: cargo el estado desde Supabase al abrir, guardo cambios automáticamente (con un pequeño *debounce* para no golpear la base en cada clic del stepper), e inserto cada medición InBody nueva como fila real.

## Migración 002 — historial real por sesión (detección de estancamiento)

`app_state` solo guarda el **último** valor de cada serie (se sobrescribe cada vez que
ajustas un peso) — no sirve para comparar "esta semana vs. la anterior". La tabla
`exercise_logs` guarda una fila por serie **por día calendario**, así que la pestaña
**Chequeo** puede comparar tus últimas sesiones reales en vez de usar datos de ejemplo.

**Para activarlo:** SQL Editor → pega **todo** el contenido de
[`supabase/migration_002_exercise_logs.sql`](migration_002_exercise_logs.sql) → **Run**.
No reemplaza nada de la migración 001 — es una tabla nueva, adicional.

- ⚠️ **No hay forma de rellenar historial de antes de esta migración** (esos datos
  nunca se guardaron por sesión). La detección necesita al menos 3 sesiones reales
  registradas por ejercicio *después* de correr la migración — se irá llenando sola
  a medida que sigas entrenando con la app. Hasta entonces, Chequeo te avisa
  explícitamente que aún no hay suficiente historial (no dice "todo bien" por defecto).
- Si no corres esta migración, Chequeo simplemente muestra un aviso de que no pudo
  cargar el historial — el resto de la app sigue funcionando igual.

## Nota de privacidad

Igual que con el resto de la app pública: la `anon` key **no es secreta** — está diseñada para ir en el código del cliente — pero con la política RLS `allow all` de este esquema, **cualquiera con la URL de tu proyecto y esa key podría leer o escribir** en estas dos tablas. Es el mismo nivel de exposición que ya aceptaste para la app en sí (sin login, con tus datos de InBody reales). Si más adelante quieres restringirlo (ej. un PIN simple antes de guardar), se puede agregar sin rehacer el esquema.
