# Contributing to ReadBuddy

Thanks for helping improve ReadBuddy! This guide outlines our Codex‑first workflow so changes stay consistent and easy to review.

## Branching
- Use short, kebab-case slugs that describe the work.
- Allowed prefixes:
  - `feature/<slug>` for new functionality
  - `fix/<slug>` for bug fixes
  - `chore/<slug>` for maintenance or non-user-facing changes

Examples:
- `feature/reading-progress-widget`
- `fix/crash-on-open-file`
- `chore/ci-pr-template`

## Commit Messages
- Format: `type(scope): message`
- Keep messages imperative, present tense, and ≤ 72 chars when possible.
- Supported types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`

Examples:
- `feat(import): add epub import with metadata`
- `fix(parser): handle malformed toc entries`
- `chore(ci): speed up macOS build matrix`

## Pull Requests
Include the following sections in your PR (our template provides this):
- Problem: What’s the current behavior or gap?
- Solution: What changed and why?
- Screenshots: Before/after or demos when visual changes apply.
- Acceptance Checks: Bullet list to verify behavior and edge cases.
- Risks: Potential regressions or follow-ups; note any roll-back plan.

### PR Checklist
- [ ] Branch follows `feature/`, `fix/`, or `chore/` naming
- [ ] Commits follow `type(scope): message` format
- [ ] CI passes on macOS
- [ ] Tests added/updated when relevant

## CI
All pushes and PRs to `main` run a macOS build via `xcodebuild -scheme ReadBuddy -destination 'platform=macOS' build`.

## Getting Help
Open a draft PR early for feedback, or start a discussion if the change is large.

