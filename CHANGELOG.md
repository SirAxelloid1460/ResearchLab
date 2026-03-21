# Changelog

All notable changes to ResearchLab will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Planned
- Supabase Realtime for live investigation updates
- PDF/Markdown export for investigations and calculations
- Custom calculation templates
- Public project sharing with read-only links

---

## [0.1.0] — 2025-03-21

### Added
- Initial release of ResearchLab
- User authentication via email/password
- OAuth login: Google, GitHub, Twitter/X, Discord
- Project creation and management dashboard
- AI-powered investigation chat with real-time web search (Claude API)
- Calculation engine with 4 analysis modes:
  - Cross-dataset analysis
  - Projection & trend analysis
  - Statistical correlation
  - Custom formula evaluation
- Data source selector for calculations (cross-referencing investigations)
- Inline chart rendering from AI responses (`[CHART:...]` syntax)
- Markdown rendering in AI responses (tables, bold, code, lists)
- Row Level Security via Supabase — users only access their own data
- localStorage fallback when Supabase is not configured
- Demo mode for exploring without authentication
- GPL v3 license
