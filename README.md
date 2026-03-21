# ResearchLab 🔬

> AI-powered research and data analysis platform. Create investigation projects, run AI-assisted research with real-time web search, and generate cross-dataset calculations — all in one place.

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?logo=supabase&logoColor=white)](https://supabase.com)
[![Claude AI](https://img.shields.io/badge/Claude-AI-orange)](https://anthropic.com)

---

## ✨ Features

- **Authentication** — Email/password + OAuth (Google, GitHub, Twitter, Discord)
- **Projects** — Organize research into named projects with descriptions
- **Investigations** — AI-powered chat sessions with real-time web search per project
- **Calculations** — Cross-dataset analysis engine with 4 modes:
  - 🔀 Cross data from multiple investigations
  - 📈 Projections & trend analysis
  - 📊 Statistical correlations
  - 🧮 Custom user formulas
- **Persistent storage** — All data saved to Supabase (PostgreSQL)
- **Row Level Security** — Each user only sees their own data

---

## 🚀 Quick Start

### 1. Clone the repo

```bash
git clone https://github.com/SirAxelloid1460/researchlab.git
cd researchlab
npm install
```

### 2. Configure environment

```bash
cp .env.example .env
```

Edit `.env` with your credentials:

```env
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your_anon_key_here
```

Then update `public/index.html` — replace `YOUR_SUPABASE_URL` and `YOUR_SUPABASE_ANON_KEY` with your values (or use the deploy script below).

### 3. Set up Supabase database

1. Go to your [Supabase SQL Editor](https://supabase.com/dashboard/project/_/sql/new)
2. Copy and run the contents of `sql/schema.sql`
3. All tables, RLS policies and indexes will be created automatically

### 4. Configure OAuth providers (optional)

In Supabase → *Authentication → Providers*:

| Provider | Required fields | Callback URL |
|----------|----------------|--------------|
| Google | Client ID + Secret | `https://YOUR_PROJECT.supabase.co/auth/v1/callback` |
| GitHub | Client ID + Secret | `https://YOUR_PROJECT.supabase.co/auth/v1/callback` |
| Twitter | API Key + Secret | `https://YOUR_PROJECT.supabase.co/auth/v1/callback` |
| Discord | Client ID + Secret | `https://YOUR_PROJECT.supabase.co/auth/v1/callback` |

Also add your app URL to *Authentication → URL Configuration → Redirect URLs*.

### 5. Run locally

```bash
npm run dev
# App available at http://localhost:3000
```

---

## 🌐 Deploy to GitHub Pages

```bash
npm run deploy
```

This uses `gh-pages` to publish the `/public` folder to the `gh-pages` branch.

Make sure GitHub Pages is enabled in your repo settings (*Settings → Pages → Branch: gh-pages*).

Your app will be live at: `https://SirAxelloid1460.github.io/researchlab`

---

## 📁 Project Structure

```
researchlab/
├── public/
│   └── index.html          # Main app (React + Supabase, single file)
├── sql/
│   └── schema.sql          # Supabase database schema + RLS policies
├── docs/
│   └── (future documentation)
├── src/
│   └── (future modular source files)
├── .env.example            # Environment variables template
├── .gitignore
├── package.json
├── CHANGELOG.md
├── CONTRIBUTING.md
└── README.md
```

---

## 🛠 Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | React 18 (via CDN, no build step) |
| Styling | Vanilla CSS with CSS variables |
| Auth | Supabase Auth (email + OAuth) |
| Database | Supabase (PostgreSQL) |
| AI | Claude API (claude-sonnet-4) |
| Web Search | Claude web_search tool |
| Hosting | GitHub Pages |

---

## 🗺 Roadmap

- [ ] Migrate to Vite + proper React modules
- [ ] Supabase Realtime — live collaboration on investigations
- [ ] Export investigations as PDF/Markdown
- [ ] Embed charts as SVG in results
- [ ] Custom calculation templates
- [ ] Public project sharing

---

## 📄 License

ResearchLab — Copyright (C) 2025 SirAxelloid1460

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

See [LICENSE](./LICENSE) for the full text.
