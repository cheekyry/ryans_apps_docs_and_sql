-- Gherkin redesign, 28 Aug 2026: generates for a whole set of Requirements/Workflow
-- Steps via a real Batch API job, not a live single-story expansion. Needs two small
-- additions:

-- 1. baps_batch_jobs needs to know whether a persisted job is a full Agile Backlog
--    job or a Gherkin-from-set job, so resuming after a page reload retrieves and
--    saves it correctly (agile_backlog vs gherkin_only content_type).
alter table baps_batch_jobs
  add column if not exists job_type text default 'agile'; -- 'agile' | 'gherkin'
alter table baps_batch_jobs
  add column if not exists source_type text; -- 'requirements' | 'workflow', Gherkin only
alter table baps_batch_jobs
  add column if not exists source_detail_level text; -- which tier the Gherkin set was generated from

-- 2. baps_agile_backlog needs to record which detail-level tier of Requirements/
--    Workflow a stored Gherkin set was actually generated from — same "keep every
--    tier independently retrievable" principle already applied to Requirements and
--    Workflow themselves, now extended to Gherkin's source provenance.
alter table baps_agile_backlog
  add column if not exists source_detail_level text;
