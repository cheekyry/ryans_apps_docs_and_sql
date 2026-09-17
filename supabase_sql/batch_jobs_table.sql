-- baps_batch_jobs: tracks Anthropic Batch API jobs for Full Agile Backlog generation
-- so a job survives a page reload/browser close and can be checked/resumed later.

create table if not exists baps_batch_jobs (
  id bigint generated always as identity primary key,
  batch_id text not null unique,          -- Anthropic's msgbatch_... id
  vertical text not null,
  product text not null,
  status text not null default 'submitted', -- submitted | in_progress | ended | failed
  epic_stubs jsonb not null,              -- the epic list from discovery, for reassembly
  story_stubs jsonb not null,             -- the story stubs (keyed by STORY_ID = custom_id), for reassembly
  request_counts jsonb,                   -- last known {succeeded, errored, processing, ...}
  final_result jsonb,                     -- populated once retrieved + reassembled
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  completed_at timestamptz
);

-- Same grant pattern already proven necessary for baps_agile_backlog — apply it
-- up front this time rather than discovering the 401 again.
grant select, insert, update, delete on table public.baps_batch_jobs to anon, authenticated;
grant usage on all sequences in schema public to anon, authenticated;

alter table baps_batch_jobs enable row level security;

create policy "anon full access" on baps_batch_jobs
  for all
  to anon
  using (true)
  with check (true);

notify pgrst, 'reload schema';
