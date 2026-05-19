# Contributing

Thanks for your interest in improving the JGraphT algorithm visualizations.

## Where to discuss

Before opening a non-trivial PR, please post a short heads-up to the
[`jgrapht-dev` Google Group](https://groups.google.com/g/jgrapht-dev) with a
link to your branch. This is the same convention used by the main
[JGraphT][jgrapht] repository — it keeps the contributor pool small enough that
async review on the list works well.

For bug reports and small fixes, a GitHub issue or PR is fine.

We follow the [JGraphT Code of Conduct](CODE_OF_CONDUCT.md).

[jgrapht]: https://github.com/jgrapht/jgrapht

## What fits in this repository

This repo hosts **interactive teaching visualizations** of algorithms that are
implemented (or being proposed) in JGraphT. Good fits:

- A new algorithm pair (baseline vs. variant) that can be stepped through
  side by side and explained event-by-event.
- A new graph example that exposes a subtle correctness or performance edge
  case in an existing visualization.
- UX polish: clearer per-step explanations, glossary entries, accessibility
  fixes, layout improvements.

What does **not** fit:

- Full Java/JGraphT algorithm code — that belongs in
  [`jgrapht/jgrapht`](https://github.com/jgrapht/jgrapht).
- Pure benchmarking infrastructure — also belongs in the main repository.
- Animations of algorithms that are not in (or proposed for) JGraphT.

## Design constraints

The page is intentionally a single self-contained HTML file (HTML + inline CSS
+ inline JS, no external dependencies, no build step). This keeps the deploy
surface tiny. PRs that add external runtime
dependencies will need a strong motivation; please raise on the mailing list
first.

It is acceptable for the file to grow, but please:

- Keep all event-driven animation work behind a step queue (don't `setTimeout`
  ad-hoc) — match the existing pattern.
- Keep per-step explanations short and accurate; if an explanation is wrong
  on any example, that's a correctness bug.
- Match the existing colour / pane / glossary conventions so that modes feel
  consistent.

## Pull request checklist

- [ ] I posted a heads-up on `jgrapht-dev` for non-trivial changes.
- [ ] The page still opens cleanly in modern Chrome / Firefox / Safari from a
      plain `file://` path **and** via `python -m http.server`.
- [ ] All animation steps display a non-empty, accurate explanation.
- [ ] If I added a new algorithm pair, the two panes agree on optimal-path
      sets (with the documented Yen tie-break caveat) on every supplied
      example.
- [ ] No new external runtime dependencies (or I've discussed them on
      `jgrapht-dev` first).
- [ ] My commit messages follow Conventional Commits
      (`feat: ...`, `fix: ...`, `docs: ...`, `chore: ...`, `refactor: ...`).
      Scope is optional but should be the algorithm or mode when it helps
      (e.g. `feat(eppstein): ...`, `fix(forward-pruning): ...`).

## License

By contributing, you agree that your contributions will be dual-licensed under
the same terms as the project itself:

- GNU Lesser General Public License (LGPL) 2.1
- Eclipse Public License (EPL) 2.0

`SPDX-License-Identifier: LGPL-2.1-or-later OR EPL-2.0`
