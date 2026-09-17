-- Fix for: 401 / 42501 "permission denied for table baps_tier_config"
-- RLS policies alone aren't enough — Postgres also needs the base
-- table-level grant to the anon role. Run once, same SQL editor.

grant select, insert, update, delete on public.baps_tier_config to anon;
