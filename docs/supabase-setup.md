# Supabase Setup Guide

Complete guide to configure Supabase for ResearchLab.

---

## 1. Create a Supabase project

1. Go to [supabase.com](https://supabase.com) and sign in
2. Click **New project**
3. Choose a name, database password, and region
4. Wait ~2 minutes for the project to initialize

---

## 2. Get your API credentials

In your project dashboard → *Settings → API*:

- **Project URL** → `SUPABASE_URL`
- **anon / public key** → `SUPABASE_ANON_KEY`

Paste these into `public/index.html` replacing the placeholders.

---

## 3. Run the database schema

1. Go to *SQL Editor → New query*
2. Copy the full contents of `sql/schema.sql`
3. Click **Run**

This creates:
- `projects` table
- `investigations` table
- `calculations` table
- Row Level Security policies for all tables
- Auto-update triggers for `updated_at`
- Performance indexes

---

## 4. Configure Auth

### Email/Password
In *Authentication → Providers → Email*: make sure it is **enabled**.

### OAuth Providers

For each provider you want:

#### Google
1. Go to [console.cloud.google.com](https://console.cloud.google.com)
2. *APIs & Services → Credentials → Create OAuth 2.0 Client ID*
3. Application type: **Web application**
4. Authorized redirect URI: `https://YOUR_PROJECT.supabase.co/auth/v1/callback`
5. Copy Client ID + Secret → paste in Supabase → *Authentication → Providers → Google*

#### GitHub
1. Go to [github.com/settings/developers](https://github.com/settings/developers)
2. *New OAuth App*
3. Callback URL: `https://YOUR_PROJECT.supabase.co/auth/v1/callback`
4. Copy Client ID + Secret → paste in Supabase → *Authentication → Providers → GitHub*

#### Microsoft (Outlook/Hotmail)
1. Go to [portal.azure.com](https://portal.azure.com)
2. *Azure Active Directory → App registrations → New registration*
3. Redirect URI: `https://YOUR_PROJECT.supabase.co/auth/v1/callback`
4. *Certificates & secrets → New client secret*
5. Copy Application (client) ID + Secret → paste in Supabase

---

## 5. Configure Redirect URLs

In Supabase → *Authentication → URL Configuration*:

- **Site URL**: your app URL (e.g. `https://SirAxelloid1460.github.io/researchlab`)
- **Redirect URLs**: add all URLs where users land after login

```
https://SirAxelloid1460.github.io/researchlab
https://claude.ai/oauth/consent
http://localhost:3000
```

---

## 6. Verify RLS is working

In *Table Editor*, try viewing a table — you should see 0 rows (because you are not authenticated as a user). This confirms RLS is active and working correctly.
