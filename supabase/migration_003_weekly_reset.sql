-- Migración 003 — reinicio semanal automático.
-- Ejecuta esto en: Supabase Dashboard -> SQL Editor -> New query -> Run.
-- No reemplaza nada de schema.sql ni de la migración 002 — solo agrega 2 columnas
-- nuevas a app_state, adicionales.
--
-- Por qué hace falta: cada semana, lo que registraste la semana anterior debe pasar
-- a ser el nuevo "ant." (peso base de referencia) para la semana que empieza, y los
-- campos de peso/reps/RIR/completado deben quedar en blanco otra vez. Antes el "ant."
-- estaba fijo en el código (nunca cambiaba) y nada se reiniciaba solo.
--
-- prev_weights guarda, por serie, el último peso registrado que ahora sirve de "ant.".
-- week_anchor guarda la fecha (lunes) de la semana que se está mostrando — la app la
-- compara contra la fecha real cada vez que abre, y si ya se cruzó un lunes, dispara
-- el reinicio (no hay cron en esta app estática: el reinicio ocurre la primera vez
-- que abres la app después de que empiece el lunes).

alter table app_state
  add column if not exists prev_weights jsonb not null default '{}'::jsonb,
  add column if not exists week_anchor date;
