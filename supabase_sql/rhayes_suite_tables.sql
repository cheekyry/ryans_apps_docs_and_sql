-- ============================================================
-- RHAYES SUITE — Supabase Database Tables
-- Project: rhayes-suite
-- Created: July 2026
-- ============================================================

-- ============================================================
-- BA POWERSUITE TABLES
-- ============================================================

-- Requirements: stores generated requirements per product/vertical
CREATE TABLE IF NOT EXISTS baps_requirements (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  vertical TEXT NOT NULL,
  product TEXT NOT NULL,
  detail_level TEXT NOT NULL,
  requirements JSONB NOT NULL,
  req_count INTEGER,
  project_name TEXT
);

-- Workflows: stores generated workflow steps per product/vertical
CREATE TABLE IF NOT EXISTS baps_workflows (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  vertical TEXT NOT NULL,
  product TEXT NOT NULL,
  detail_level TEXT NOT NULL,
  workflow JSONB NOT NULL,
  step_count INTEGER,
  project_name TEXT
);

-- ============================================================
-- PERSONAL SUITE TABLES
-- ============================================================

-- Shopping: weekly shopping list items
CREATE TABLE IF NOT EXISTS personal_shopping (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  name TEXT NOT NULL,
  category TEXT,
  quantity TEXT,
  checked BOOLEAN DEFAULT FALSE,
  notes TEXT
);

-- Pantry: store cupboard items
CREATE TABLE IF NOT EXISTS personal_pantry (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  name TEXT NOT NULL,
  category TEXT,
  quantity TEXT,
  expiry_date DATE,
  notes TEXT
);

-- Budget: cash flow and spending entries
CREATE TABLE IF NOT EXISTS personal_budget (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  description TEXT NOT NULL,
  amount NUMERIC NOT NULL,
  type TEXT NOT NULL,
  category TEXT,
  date DATE,
  notes TEXT
);

-- Health: medications and vitals
CREATE TABLE IF NOT EXISTS personal_health (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  entry_type TEXT NOT NULL,
  name TEXT,
  value TEXT,
  unit TEXT,
  date DATE,
  time TIME,
  notes TEXT
);

-- Tasks: to-do items and projects
CREATE TABLE IF NOT EXISTS personal_tasks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  title TEXT NOT NULL,
  project TEXT,
  priority TEXT,
  status TEXT DEFAULT 'todo',
  due_date DATE,
  notes TEXT
);

-- Bets: saved bets from the Bet Optimiser
CREATE TABLE IF NOT EXISTS personal_bets (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  bet_type TEXT,
  selections JSONB,
  stake NUMERIC,
  odds TEXT,
  potential_return NUMERIC,
  status TEXT DEFAULT 'pending',
  notes TEXT
);

-- Football: saved football analyses
CREATE TABLE IF NOT EXISTS personal_football (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  match_name TEXT,
  analysis JSONB,
  recommendations JSONB,
  date DATE,
  notes TEXT
);

-- ============================================================
-- Enable Row Level Security on all tables
-- ============================================================
ALTER TABLE baps_requirements ENABLE ROW LEVEL SECURITY;
ALTER TABLE baps_workflows ENABLE ROW LEVEL SECURITY;
ALTER TABLE personal_shopping ENABLE ROW LEVEL SECURITY;
ALTER TABLE personal_pantry ENABLE ROW LEVEL SECURITY;
ALTER TABLE personal_budget ENABLE ROW LEVEL SECURITY;
ALTER TABLE personal_health ENABLE ROW LEVEL SECURITY;
ALTER TABLE personal_tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE personal_bets ENABLE ROW LEVEL SECURITY;
ALTER TABLE personal_football ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- RLS Policies — allow full access for now (single user)
-- These will be tightened when multi-user auth is added
-- ============================================================
CREATE POLICY "Allow all" ON baps_requirements FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON baps_workflows FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON personal_shopping FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON personal_pantry FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON personal_budget FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON personal_health FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON personal_tasks FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON personal_bets FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow all" ON personal_football FOR ALL USING (true) WITH CHECK (true);
