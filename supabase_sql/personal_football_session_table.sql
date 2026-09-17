-- Cross-device state persistence for personalsuite's Football tab
-- (Scout through Build's Verdict/Stake Plan stage). One row only, always
-- id = 'current' — this deliberately holds a single in-progress session,
-- not a history. Run this once in the Supabase SQL editor before the
-- state-saving feature in app.js will work.

CREATE TABLE IF NOT EXISTS personal_football_session (
  id TEXT PRIMARY KEY,
  data JSONB NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE personal_football_session ENABLE ROW LEVEL SECURITY;

-- Same "allow all" pattern as every other personal_* table (single user,
-- no auth layer on Personal Suite yet).
CREATE POLICY "Allow all" ON personal_football_session FOR ALL USING (true) WITH CHECK (true);
