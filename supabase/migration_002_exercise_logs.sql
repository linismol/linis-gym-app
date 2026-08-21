-- Migración 002 — historial real por sesión, para detección de estancamiento en Chequeo.
-- Ejecuta esto en: Supabase Dashboard -> SQL Editor -> New query -> Run.
-- No reemplaza nada de schema.sql (la migración 001) — es una tabla nueva, adicional.
--
-- Por qué hace falta: app_state solo guarda el ÚLTIMO valor de cada serie (se sobrescribe
-- cada vez que ajustas un peso), así que nunca hubo un historial real por sesión para
-- comparar semana contra semana. La pestaña "Chequeo" usaba datos de ejemplo hardcodeados
-- para la detección de estancamiento. Esta tabla guarda una fila por serie, por día
-- calendario — a partir de ahora, cada vez que registres un peso/rep/RIR se guarda aquí,
-- y "Chequeo" compara tus últimas sesiones reales.
--
-- Importante: no hay forma de rellenar el historial de semanas anteriores a esta
-- migración (esos datos nunca se guardaron). La detección de estancamiento necesita
-- al menos 3 sesiones reales registradas por ejercicio DESPUÉS de correr esto — se irá
-- llenando sola a medida que sigas entrenando con la app.

create table if not exists exercise_logs (
  id bigint generated always as identity primary key,
  logged_on date not null,
  day_index integer not null,
  exercise_index integer not null,
  set_index integer not null,
  is_alt boolean not null default false,
  weight numeric,
  reps numeric,
  rir numeric,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint exercise_logs_unique_set unique (logged_on, day_index, exercise_index, set_index, is_alt)
);

alter table exercise_logs enable row level security;

drop policy if exists "exercise_logs anon full access" on exercise_logs;
create policy "exercise_logs anon full access"
  on exercise_logs
  for all
  to anon
  using (true)
  with check (true);

create index if not exists exercise_logs_lookup on exercise_logs (day_index, exercise_index, logged_on desc);
