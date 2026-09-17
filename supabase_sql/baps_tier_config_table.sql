-- baps_tier_config — Phase 1 tier/feature gating (11 Sep 2026)
-- Run once in the Supabase SQL editor for project rhayes-suite
-- (qnpxprxhaciwtchrdqzn). One row per gateable tab/sub-tool, matching
-- the FEATURE_REGISTRY constant in both baps_app.html and
-- customer_baps_app.html. The app's Settings > Tier Configuration
-- screen reads/writes this table directly — no rows need to be
-- inserted manually here, the app will create them on first "Save
-- Changes" click.

create table if not exists baps_tier_config (
  feature_id   text primary key,
  standard     boolean not null default true,
  advanced     boolean not null default true,
  professional boolean not null default true,
  updated_at   timestamptz not null default now()
);

alter table baps_tier_config enable row level security;

create policy "anon select baps_tier_config"
  on baps_tier_config for select
  to anon
  using (true);

create policy "anon insert baps_tier_config"
  on baps_tier_config for insert
  to anon
  with check (true);

create policy "anon update baps_tier_config"
  on baps_tier_config for update
  to anon
  using (true)
  with check (true);

create policy "anon delete baps_tier_config"
  on baps_tier_config for delete
  to anon
  using (true);
