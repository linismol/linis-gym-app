-- Linis Gym App — esquema de Supabase para almacenamiento persistente.
-- Ejecuta este archivo completo en: Supabase Dashboard -> SQL Editor -> New query -> Run.
--
-- Diseño: app personal de un solo usuario, sin login. Dos tablas:
--   1. app_state             — fila única con el progreso de la semana actual
--                               (pesos, reps, RIR, checkboxes completados, gráfica seleccionada)
--   2. inbody_measurements   — historial de mediciones InBody (una fila por medición)
--
-- Seguridad: RLS (Row Level Security) queda activado en ambas tablas con una
-- política "allow all" para el rol anon — es decir, cualquiera con la URL del
-- proyecto y la anon key puede leer/escribir. Esto es equivalente al mismo
-- modelo de privacidad que ya aceptaste para la app pública (sin login, datos
-- de InBody visibles): la anon key NO es secreta, está pensada para ir en el
-- cliente; RLS es la única barrera real. Si en el futuro quieres restringirlo
-- (ej. un PIN), se puede agregar sin rehacer el esquema.

-- ============================================================
-- 1. app_state — progreso de la semana (fila única, id fijo = 1)
-- ============================================================
create table if not exists app_state (
  id integer primary key default 1,
  weights jsonb not null default '{}'::jsonb,
  reps jsonb not null default '{}'::jsonb,
  rir jsonb not null default '{}'::jsonb,
  completed jsonb not null default '{}'::jsonb,
  chart_exercise_key text not null default '0-0',
  updated_at timestamptz not null default now(),
  constraint app_state_single_row check (id = 1)
);

insert into app_state (id)
values (1)
on conflict (id) do nothing;

alter table app_state enable row level security;

drop policy if exists "app_state anon full access" on app_state;
create policy "app_state anon full access"
  on app_state
  for all
  to anon
  using (true)
  with check (true);

-- ============================================================
-- 2. inbody_measurements — historial de mediciones InBody
-- ============================================================
create table if not exists inbody_measurements (
  id bigint generated always as identity primary key,
  measured_on date not null,
  peso numeric not null,
  mme numeric not null,
  pgc numeric not null,
  cadera numeric not null,
  puntuacion numeric not null,
  created_at timestamptz not null default now()
);

alter table inbody_measurements enable row level security;

drop policy if exists "inbody anon full access" on inbody_measurements;
create policy "inbody anon full access"
  on inbody_measurements
  for all
  to anon
  using (true)
  with check (true);

-- Semilla: tu historial InBody ya conocido (se puede omitir si prefieres
-- empezar la tabla vacía y dejar que la app la puebla desde su INBODY_SEED
-- local en el primer guardado).
insert into inbody_measurements (measured_on, peso, mme, pgc, cadera, puntuacion)
values
  ('2026-04-27', 67.0, 28.5, 23.4, 0.83, 84),
  ('2026-06-11', 66.6, 28.6, 23.1, 0.85, 84),
  ('2026-07-21', 67.8, 28.9, 23.2, 0.84, 85)
on conflict do nothing;
