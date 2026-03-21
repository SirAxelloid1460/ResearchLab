# Contributing to ResearchLab

Thank you for your interest in contributing! This document explains how to get involved.

---

## Code of Conduct

Be respectful, constructive, and inclusive. We're here to build something useful together.

---

## How to Contribute

### Reporting Bugs

1. Check [existing issues](https://github.com/SirAxelloid1460/researchlab/issues) first
2. Open a new issue with:
   - A clear title
   - Steps to reproduce
   - Expected vs actual behavior
   - Browser and OS

### Suggesting Features

Open an issue with the `enhancement` label. Describe:
- What problem it solves
- How you imagine it working
- Any alternatives you considered

### Submitting Code

1. Fork the repository
2. Create a branch: `git checkout -b feature/your-feature-name`
3. Make your changes
4. Test locally: `npm run dev`
5. Commit with a clear message (see below)
6. Push and open a Pull Request

---

## Commit Message Format

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): short description

Examples:
feat(auth): add Microsoft OAuth provider
fix(calc): handle empty investigation sources gracefully
docs(readme): update deploy instructions
style(ui): improve mobile layout for project cards
refactor(chat): extract message rendering to helper function
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

---

## Development Setup

```bash
git clone https://github.com/SirAxelloid1460/researchlab.git
cd researchlab
npm install
cp .env.example .env
# Fill in .env with your Supabase credentials
npm run dev
```

The app runs at `http://localhost:3000`. No build step needed — it's a static HTML file with CDN dependencies.

---

## Project Architecture Notes

- **Single file app** — `public/index.html` contains all React, CSS and JS. This is intentional for the current phase (easy to deploy anywhere, no build tooling required).
- **Future** — the `src/` folder is reserved for when we migrate to a proper Vite + modules setup.
- **Supabase** — all DB logic uses the Supabase JS client directly in the browser. RLS handles security at the DB level.
- **Claude API** — called directly from the browser using the Anthropic API. Available natively within claude.ai deployments.

---

## License

By contributing, you agree that your contributions will be licensed under GPL v3, the same license as this project.
