-- ═══════════════════════════════════════════════════════════════
-- ResearchLab — Project Sharing
-- Run in Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════════

-- Add public_slug to projects
ALTER TABLE projects ADD COLUMN IF NOT EXISTS public_slug TEXT UNIQUE;
ALTER TABLE projects ADD COLUMN IF NOT EXISTS is_public BOOLEAN DEFAULT FALSE;

-- Index for fast slug lookup
CREATE INDEX IF NOT EXISTS idx_projects_public_slug ON projects(public_slug) WHERE public_slug IS NOT NULL;

-- Allow anyone to read public projects (no auth required)
CREATE POLICY "Anyone can read public projects"
  ON projects FOR SELECT
  USING (is_public = TRUE);

CREATE POLICY "Anyone can read investigations of public projects"
  ON investigations FOR SELECT
  USING (
    project_id IN (SELECT id FROM projects WHERE is_public = TRUE)
  );

CREATE POLICY "Anyone can read calculations of public projects"
  ON calculations FOR SELECT
  USING (
    project_id IN (SELECT id FROM projects WHERE is_public = TRUE)
  );
