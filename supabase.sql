-- ADDA chat — Supabase setup (run once in Supabase SQL Editor)
-- Creates one small key-value table that stores accounts, block list and
-- login sessions permanently. Messages are NOT stored here (they auto-delete
-- after 30 minutes by design).

create table if not exists public.adda_kv (
  k text primary key,
  v jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

-- Lock the table down: only the server's service_role key can read/write.
-- (service_role bypasses RLS; anon/public gets no access.)
alter table public.adda_kv enable row level security;

-- Done. Now copy your Project URL + service_role key into Render env vars:
--   SUPABASE_URL = https://xxxx.supabase.co
--   SUPABASE_SERVICE_ROLE_KEY = eyJ... (service_role, NOT anon)
