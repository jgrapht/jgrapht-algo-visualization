[![License](https://img.shields.io/badge/license-LGPL%202.1-blue.svg)](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html)
[![License](https://img.shields.io/badge/license-EPL%202.0-blue.svg)](https://www.eclipse.org/legal/epl-2.0)

# JGraphT Algorithm Visualizations

Interactive, step-by-step visualizations of graph algorithms from [JGraphT][jgrapht].

**Live:** https://algo-visualization.jgrapht.org/ &nbsp;·&nbsp; [JGraphT][jgrapht] &nbsp;·&nbsp; [Discussion (jgrapht-dev)][devlist]

A small static site: a navigation homepage at `/` plus one self-contained HTML
page per topic (no external JS, no external CSS, no build step). Each step in
every animation is annotated in plain English; a per-topic glossary covers the
relevant terminology.

[jgrapht]: https://jgrapht.org/
[devlist]: https://groups.google.com/g/jgrapht-dev

## Topics

| Path | Topic | Algorithms |
|------|-------|------------|
| [`/shortest-paths/`](shortest-paths/) | **Shortest paths** | Yen, Eppstein, Bounded-pruned Yen + A\*, Dijkstra, A\*, `AllDirectedPaths` with forward pruning |
| [`/hamiltonian/`](hamiltonian/) | **Hamiltonian path** | Backtracking (vanilla and with connectivity / degree-1 / cut-vertex / bridge-tree / SCC condensation prechecks + MRV + reachability prune), polynomial DAG longest-path. Coming soon: Held-Karp subset DP |
| [`/spanning-tree/`](spanning-tree/) | **Minimum spanning tree** | Kruskal (global edge sort + union-find), Prim (single tree + Fibonacci heap), Borůvka (parallel component rounds); minimum spanning forest on disconnected input |
| [`/max-flow/`](max-flow/) | **Maximum flow / min cut** | Edmonds-Karp (BFS shortest augmenting paths), Dinic (level graph + blocking flow); residual graph and max-flow min-cut duality |
| [`/matching/`](matching/) | **Bipartite matching** | Greedy (maximal, ½-approx), augmenting-path method (Kuhn), Hopcroft-Karp (batched shortest augmenting paths); maximal vs maximum |
| [`/connectivity/`](connectivity/) | **Strongly connected components** | Kosaraju (two DFS passes + transpose), Tarjan (lowlink), Gabow (two-stack path-based); identical SCC partition, different bookkeeping |

Each topic page reproduces the algorithms exactly as they're implemented in
[JGraphT][jgrapht].

## Running

Any static file server works — there is nothing to build.

### 1. Open files directly (zero infra)

Open `index.html` in a modern browser, then click through to a topic page.
Some Chromium policies disable `file://` cross-directory navigation; if a link
looks broken, use one of the local server options below.

### 2. Local Python HTTP server

```sh
python -m http.server 8080
# then visit http://localhost:8080/
```

### 3. Docker (the "deploy anywhere" option)

A ~20 MB nginx-alpine image is provided.

```sh
docker build -t jgrapht-algo-viz:latest .
docker run --rm -p 8080:8080 --name jgrapht-algo-viz jgrapht-algo-viz:latest
# then visit http://localhost:8080/
```

Stop it with `Ctrl-C` (or `docker stop jgrapht-algo-viz` from another shell).
A `docker-compose.yml` is also provided (`docker compose up -d`). The image
runs nginx as a non-root user on port 8080, has a basic healthcheck
(`HEAD /`), no persistent volumes, no network egress.

### 4. GitHub Pages (canonical hosting)

The site is published from `main` via GitHub Pages' built-in branch source
(Settings → Pages → Source: *Deploy from a branch* → `main` / `/` root). No
build step, no workflow — every push to `main` is picked up by GitHub's
static builder. `.nojekyll` is committed at the root so Jekyll is skipped.

Canonical URL: <https://algo-visualization.jgrapht.org/>.

## Repository layout

| Path | Purpose |
|------|---------|
| `index.html` | Navigation homepage (cards linking to each topic). |
| `shortest-paths/index.html` | The shortest-paths visualization (single self-contained HTML). |
| `hamiltonian/index.html` | The Hamiltonian-path visualization (Backtracking vanilla + full and DAG longest-path live; Held-Karp coming). |
| `spanning-tree/index.html` | The minimum-spanning-tree visualization (Kruskal, Prim, Borůvka; spanning forest on disconnected input). |
| `max-flow/index.html` | The maximum-flow / min-cut visualization (Edmonds-Karp and Dinic; residual graph, blocking flow, min-cut finale). |
| `matching/index.html` | The bipartite-matching visualization (greedy, augmenting-path / Kuhn, Hopcroft-Karp; maximal vs maximum). |
| `connectivity/index.html` | The strongly-connected-components visualization (Kosaraju, Tarjan, Gabow; same partition, different bookkeeping). |
| `favicon.ico`, `apple-touch-icon.png` | Site icons (referenced as `/favicon.ico` etc. from every page). |
| `CNAME` | Custom-domain claim for `algo-visualization.jgrapht.org`. |
| `.nojekyll` | Empty marker so GitHub Pages skips Jekyll. |
| `Dockerfile`, `docker-compose.yml`, `nginx.conf`, `.dockerignore` | Self-host via nginx-alpine. |
| `vercel.json` | Static-routing config for matching Vercel deployments. |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Discussion happens on [jgrapht-dev][devlist].
We follow the JGraphT [Code of Conduct](CODE_OF_CONDUCT.md).

## License

Dual-licensed under either:

- GNU Lesser General Public License (LGPL) 2.1 &nbsp;[`license-LGPL.txt`](license-LGPL.txt)
- Eclipse Public License (EPL) 2.0 &nbsp;[`license-EPL.txt`](license-EPL.txt)

`SPDX-License-Identifier: LGPL-2.1-or-later OR EPL-2.0`

Matches the license terms of [JGraphT][jgrapht] itself.
