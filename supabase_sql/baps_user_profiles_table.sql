-- baps_user_profiles — Phase 2 auth (14 Sep 2026)
-- Run once in the Supabase SQL editor for project rhayes-suite
-- (qnpxprxhaciwtchrdqzn).
--
-- Links a Supabase Auth user (auth.users) to their tier. Deliberately
-- locked down: a logged-in user can SELECT only their own row, and
-- has NO insert/update/delete access at all — otherwise a customer
-- could rewrite their own tier via browser dev tools, the same
-- self-upgrade risk already flagged for the tier config matrix.
-- Rows are only ever written by the create-user serverless function,
-- which uses the service_role key (bypasses RLS entirely) — never by
-- the browser.

create table if not exists baps_user_profiles (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  email      text not null,
  tier       text not null check (tier in ('standard','advanced','professional')),
  is_admin   boolean not null default false,
  created_at timestamptz not null default now()
);

alter table baps_user_profiles enable row level security;

-- A logged-in user may read only their own profile row.
create policy "user reads own profile"
  on baps_user_profiles for select
  to authenticated
  using (auth.uid() = user_id);

-- Deliberately no insert/update/delete policy for anon or
-- authenticated — those only happen via the service_role key in the
-- create-user gateway function, which bypasses RLS.

-- ── Bootstrap step — run manually, once, for Ryan's own admin account ──
-- 1. Create your own login first, either via the Supabase dashboard
--    (Authentication > Users > Add user) or via the in-app "Create
--    User" screen once it's built (tier doesn't matter, you're about
--    to override it below).
-- 2. Find your new user's UUID (Authentication > Users, or
--    `select id, email from auth.users;`).
-- 3. Run this once, with your actual UUID and email:
--
-- insert into baps_user_profiles (user_id, email, tier, is_admin)
-- values ('YOUR-USER-UUID-HERE', 'ryan.hayes@bapowersuite.com', 'professional', true)
-- on conflict (user_id) do update set is_admin = true, tier = 'professional';
