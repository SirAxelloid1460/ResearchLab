-- ═══════════════════════════════════════════════════════════════
-- ResearchLab — Supabase Schema
-- Run this in your Supabase SQL Editor:
-- https://supabase.com/dashboard/project/_/sql/new
-- ═══════════════════════════════════════════════════════════════

-- Enable UUID extension (already enabled in Supabase by default)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ───────────────────────────────────────────
-- PROJECTS
-- ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS projects (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id     UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name        TEXT NOT NULL,
  description TEXT,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ───────────────────────────────────────────
-- INVESTIGATIONS
-- ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS investigations (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  project_id  UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  user_id     UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  topic       TEXT NOT NULL,
  summary     TEXT,
  messages    JSONB DEFAULT '[]'::jsonb,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ───────────────────────────────────────────
-- CALCULATIONS
-- ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS calculations (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  project_id  UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
  user_id     UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  title       TEXT NOT NULL,
  type        TEXT NOT NULL CHECK (type IN ('cross', 'projection', 'correlation', 'formula')),
  prompt      TEXT NOT NULL,
  result      TEXT,
  sources     JSONB DEFAULT '[]'::jsonb,  -- array of investigation IDs used
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ───────────────────────────────────────────
-- AUTO-UPDATE updated_at
-- ───────────────────────────────────────────
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER projects_updated_at
  BEFORE UPDATE ON projects
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER investigations_updated_at
  BEFORE UPDATE ON investigations
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ───────────────────────────────────────────
-- ROW LEVEL SECURITY (RLS)
-- Users can only see and modify their own data
-- ───────────────────────────────────────────
ALTER TABLE projects       ENABLE ROW LEVEL SECURITY;
ALTER TABLE investigations ENABLE ROW LEVEL SECURITY;
ALTER TABLE calculations   ENABLE ROW LEVEL SECURITY;

-- Projects
CREATE POLICY "Users see own projects"
  ON projects FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users create own projects"
  ON projects FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users update own projects"
  ON projects FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users delete own projects"
  ON projects FOR DELETE USING (auth.uid() = user_id);

-- Investigations
CREATE POLICY "Users see own investigations"
  ON investigations FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users create own investigations"
  ON investigations FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users update own investigations"
  ON investigations FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users delete own investigations"
  ON investigations FOR DELETE USING (auth.uid() = user_id);

-- Calculations
CREATE POLICY "Users see own calculations"
  ON calculations FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users create own calculations"
  ON calculations FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users update own calculations"
  ON calculations FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users delete own calculations"
  ON calculations FOR DELETE USING (auth.uid() = user_id);

-- ───────────────────────────────────────────
-- INDEXES for performance
-- ───────────────────────────────────────────
CREATE INDEX IF NOT EXISTS idx_projects_user_id
  ON projects(user_id);
CREATE INDEX IF NOT EXISTS idx_investigations_project_id
  ON investigations(project_id);
CREATE INDEX IF NOT EXISTS idx_investigations_user_id
  ON investigations(user_id);
CREATE INDEX IF NOT EXISTS idx_calculations_project_id
  ON calculations(project_id);
