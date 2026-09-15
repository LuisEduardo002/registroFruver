-- ============================================================
-- GeoTurnos · Esquema Supabase
-- Cómo usar: Supabase Dashboard → SQL Editor → New query →
-- pega este archivo completo → Run
-- ============================================================

create table if not exists public.turnos (
  id text primary key,
  worker text not null,
  event text not null check (event in ('ENTRADA','SALIDA')),
  ts timestamptz not null,
  lat double precision not null,
  lon double precision not null,
  accuracy integer,
  maps_url text,
  created_at timestamptz not null default now()
);

alter table public.turnos enable row level security;

-- La app ficha sin login: se permite insertar y leer con la anon key.
drop policy if exists "turnos_insert_anon" on public.turnos;
create policy "turnos_insert_anon"
  on public.turnos for insert to anon with check (true);

drop policy if exists "turnos_select_anon" on public.turnos;
create policy "turnos_select_anon"
  on public.turnos for select to anon using (true);

-- Índice para ordenar el historial por fecha (más recientes primero)
create index if not exists turnos_ts_idx on public.turnos (ts desc);
