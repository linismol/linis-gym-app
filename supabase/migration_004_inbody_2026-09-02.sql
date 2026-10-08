-- Migración 004 — registra el InBody del 02.09.2026 si aún no está en la tabla.
-- Ejecuta en: Supabase Dashboard -> SQL Editor -> New query -> Run.
-- (Alternativa: agrégalo desde la sección Progreso de la app.)
insert into inbody_measurements (measured_on, peso, mme, pgc, cadera, puntuacion)
select '2026-09-02', 67.8, 29.0, 23.0, 0.85, 85
where not exists (select 1 from inbody_measurements where measured_on = '2026-09-02');
