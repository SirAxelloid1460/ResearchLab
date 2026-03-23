-- ═══════════════════════════════════════════════════════════════
-- ResearchLab — Forum / Community Feed
-- ═══════════════════════════════════════════════════════════════

-- Add forum fields to investigations
ALTER TABLE investigations ADD COLUMN IF NOT EXISTS forum_public BOOLEAN DEFAULT TRUE;
ALTER TABLE investigations ADD COLUMN IF NOT EXISTS forum_likes INTEGER DEFAULT 0;
ALTER TABLE investigations ADD COLUMN IF NOT EXISTS forum_dislikes INTEGER DEFAULT 0;

-- Votes table
CREATE TABLE IF NOT EXISTS investigation_votes (
  id               UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  investigation_id UUID NOT NULL REFERENCES investigations(id) ON DELETE CASCADE,
  user_id          UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  vote             SMALLINT NOT NULL CHECK (vote IN (1, -1)),
  created_at       TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(investigation_id, user_id)
);

ALTER TABLE investigation_votes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users see all votes" ON investigation_votes FOR SELECT USING (true);
CREATE POLICY "Users manage own votes" ON investigation_votes FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users update own votes" ON investigation_votes FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users delete own votes" ON investigation_votes FOR DELETE USING (auth.uid() = user_id);

-- Index for performance
CREATE INDEX IF NOT EXISTS idx_votes_investigation ON investigation_votes(investigation_id);
CREATE INDEX IF NOT EXISTS idx_votes_user ON investigation_votes(user_id);
CREATE INDEX IF NOT EXISTS idx_inv_forum ON investigations(forum_public, forum_likes DESC);

-- Function to update like/dislike counts atomically
CREATE OR REPLACE FUNCTION update_vote_counts(inv_id UUID)
RETURNS VOID AS $$
BEGIN
  UPDATE investigations SET
    forum_likes    = (SELECT COUNT(*) FROM investigation_votes WHERE investigation_id = inv_id AND vote = 1),
    forum_dislikes = (SELECT COUNT(*) FROM investigation_votes WHERE investigation_id = inv_id AND vote = -1)
  WHERE id = inv_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Allow public read of forum investigations
CREATE POLICY "Anyone reads forum investigations"
  ON investigations FOR SELECT
  USING (forum_public = TRUE);

-- Allow public read of profiles for forum author display
CREATE POLICY "Anyone reads profiles for forum"
  ON profiles FOR SELECT USING (true);
