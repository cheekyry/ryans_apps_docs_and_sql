-- baps_generate_batch_jobs: tracks Anthropic Batch API jobs for the NEW Batch Generate
-- system (Requirements first, Workflow/Agile/Gherkin to follow the same pattern).
-- Generalized version of baps_batch_jobs (which is Agile-Backlog-specific) — this one
-- carries a full "manifest" describing every request in the batch, since a single job
-- here can span multiple products and, eventually, multiple content types at once.

create table if not exists baps_generate_batch_jobs (
  id bigint generated always as identity primary key,
  batch_id text not null unique,
  status text not null default 'submitted', -- submitted | in_progress | ended | retrieved | dismissed
  manifest jsonb not null,                  -- full request list: [{custom_id, vertical, product,
                                             --   content_type, module_name, start_num}, ...]
  request_counts jsonb,
  result_summary jsonb,                     -- populated after retrieval: per-product save results
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  completed_at timestamptz
);

grant select, insert, update, delete on table public.baps_generate_batch_jobs to anon, authenticated;
grant usage on all sequences in schema public to anon, authenticated;

alter table baps_generate_batch_jobs enable row level security;

create policy "anon full access" on baps_generate_batch_jobs
  for all
  to anon
  using (true)
  with check (true);

notify pgrst, 'reload schema';
