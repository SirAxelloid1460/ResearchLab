-- ═══════════════════════════════════════════════════════════════
-- ResearchLab — Investigation Versions
-- Run in Supabase SQL Editor after schema.sql
-- ═══════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS investigation_versions (
  id               UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  investigation_id UUID NOT NULL REFERENCES investigations(id) ON DELETE CASCADE,
  user_id          UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  messages         JSONB NOT NULL,
  summary          TEXT,
  trigger_msg      TEXT,   -- the user message that triggered this version
  version_num      INTEGER NOT NULL DEFAULT 1,
  created_at       TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE investigation_versions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users see own versions"
  ON investigation_versions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users create own versions"
  ON investigation_versions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users delete own versions"
  ON investigation_versions FOR DELETE USING (auth.uid() = user_id);

CREATE INDEX IF NOT EXISTS idx_versions_investigation_id
  ON investigation_versions(investigation_id);
CREATE INDEX IF NOT EXISTS idx_versions_user_id
  ON investigation_versions(user_id);
