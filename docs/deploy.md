# Deployment Guide

---

## GitHub Pages (recommended)

### Automatic deploy via npm script

```bash
npm run deploy
```

This runs `gh-pages -d public` which pushes the `/public` folder to the `gh-pages` branch.

First time setup:
1. Run `npm install` to install `gh-pages`
2. In your GitHub repo → *Settings → Pages → Branch: gh-pages → / (root)*
3. Run `npm run deploy`
4. App live at `https://SirAxelloid1460.github.io/researchlab`

### Manual deploy

1. Go to your repo on GitHub
2. Upload `public/index.html` (with your Supabase credentials already replaced)
3. *Settings → Pages → Deploy from branch → main → / (root)*

---

## Netlify (easiest for first deploy)

1. Go to [app.netlify.com/drop](https://app.netlify.com/drop)
2. Drag and drop the `public/` folder
3. Netlify gives you a URL instantly (e.g. `https://random-name.netlify.app`)
4. Add that URL to Supabase → *Authentication → URL Configuration → Redirect URLs*

To set a custom domain later: *Site settings → Domain management*.

---

## Vercel

```bash
npm install -g vercel
vercel --prod
```

Set output directory to `public` when prompted.

---

## Self-hosted (any static server)

The app is a single HTML file. Any static file server works:

```bash
# Python
python -m http.server 8080 --directory public

# Node
npm run preview

# Nginx — point root to /path/to/researchlab/public
```
