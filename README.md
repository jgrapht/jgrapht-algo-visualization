[![License](https://img.shields.io/badge/license-LGPL%202.1-blue.svg)](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html)
[![License](https://img.shields.io/badge/license-EPL%202.0-blue.svg)](https://www.eclipse.org/legal/epl-2.0)

# JGraphT Algorithm Visualizations

Interactive, step-by-step visualizations of graph algorithms from [JGraphT][jgrapht].

**Live:** https://algo-visualization.jgrapht.org/ &nbsp;·&nbsp; [JGraphT][jgrapht] &nbsp;·&nbsp; [Discussion (jgrapht-dev)][devlist]

A single self-contained HTML page (no external JS, no external CSS, no build
step) that animates and compares pairs of graph algorithms side by side. Each
step is annotated in plain English; a built-in glossary covers expansion,
relaxation, heuristics, and admissibility.

Three top-level **modes**:

| Mode | Left pane | Right pane |
|------|-----------|------------|
| **K-shortest paths (Yen)** | Pickable: Yen + Dijkstra, Yen + A\*, BPYen + Dijkstra, BPYen + A\*, or **Eppstein** | Same picker (defaults: Yen + Dijkstra vs BPYen + A\*) |
| **Single shortest path (Dijkstra vs A\*)** | Standard Dijkstra | A\* with reverse-Dijkstra heuristic |
| **All paths — forward pruning (`AllDirectedPaths`)** | Backward-BFS baseline | Forward + backward prune (the "sandwich" gate) |

In Yen mode the two panes are independently configurable, so any pair of the
five Yen-family algorithms can be compared (including Eppstein, which is
step-animated through reverse Dijkstra, the shortest-path tree T\*, the
sidetracks graph, and walk extraction).

The page reproduces the algorithms as implemented in [JGraphT][jgrapht].

[jgrapht]: https://jgrapht.org/
[devlist]: https://groups.google.com/g/jgrapht-dev

## Running

The HTML file is fully self-contained — any static file server works.

### 1. Open the file directly (zero infra)

Open `index.html` in a modern browser. That's it.

Some Chromium policies disable `file://` page features; if anything looks
broken, fall back to one of the local server options below.

### 2. Local Python HTTP server (developer convenience)

```sh
python -m http.server 8080
# then visit http://localhost:8080/
```

### 3. Docker (the "deploy anywhere" option)

A ~20 MB nginx-alpine image is provided.

#### Build

```sh
docker build -t jgrapht-algo-viz:latest .
```

#### Run

```sh
docker run --rm -p 8080:8080 --name jgrapht-algo-viz jgrapht-algo-viz:latest
# then visit http://localhost:8080/
```

Stop it with `Ctrl-C` (or `docker stop jgrapht-algo-viz` from another shell).

#### docker-compose

```sh
docker compose up -d
docker compose down
```

The image runs nginx as a non-root user on port 8080 and exposes a basic
healthcheck (`HEAD /`). No persistent volumes, no network egress.

### 4. GitHub Pages (canonical hosting)

Pushes to `main` are published automatically to GitHub Pages via the workflow
in `.github/workflows/pages.yml`. The canonical URL is
<https://algo-visualization.jgrapht.org/>.

## What's inside

| File | Purpose |
|------|---------|
| `index.html` | The whole visualization (HTML + inline CSS + inline JS, no external deps). |
| `Dockerfile` | nginx-alpine image, runs as non-root on port 8080. |
| `nginx.conf` | Minimal server block: serves the one static file, no autoindex, no server tokens. |
| `docker-compose.yml` | One-service compose file (build + port mapping). |
| `vercel.json` | Static-routing config for matching Vercel deployments. |
| `.github/workflows/pages.yml` | GitHub Pages deployment on push to `main`. |

## Controls (in-app)

- **Mode** — switches between the three modes above.
- **A / B** — per-pane algorithm picker (Yen mode only; five choices each).
- **Example** — graph preset, mode-aware:
  - Yen / Single: *grid 6×5*, *path chain*, *Yen Wikipedia 6-node*.
  - Forward pruning: *layered DAG fan-out*, *highway + orphan chain*,
    *garden (orphan backward branch)*, *tight-budget diamond*.
- **K** — number of paths to enumerate (Yen mode only).
- **Max length** — path-length budget (forward-pruning mode only).
- **Load (⏏)** — build the graph and the event stream.
- **Step-back (⏮) / Play (▶) / Pause (❚❚) / Step (⏭) / Reset (⏹)** — transport.
- **Speed** — animation step interval (60–1200 ms/step).

Each step explains itself in plain English in the box under each canvas (e.g.
"Spur task starts at `1,1` — banned edges shown in red, lower bound is
`prefixCost (3) + h[spurNode] = 7`; the bounded driver only ran it because no
cheaper candidate is known yet.").

## Algorithm correctness

Both panes in every mode produce the same set of optimal paths or the same
decoration outcome on every supplied example. Where the two panes show
different alternates for K ≥ 2 in Yen mode, those alternates are still
equal-cost — the algorithms tie-break differently among multiple optimal
paths, which is a property of Yen with weighted ties, not a bug.

Numerical wins (Chrome verification, weighted grid 6×5, K=3):

| Variant | Spur tasks | Node expansions |
|--------|-----------|------------------|
| Vanilla Yen + Dijkstra | 18 | 280 |
| Bounded-pruned Yen + A\* | 9 | 141 |

Forward-pruning all-paths (`Garden — orphan backward branch` example,
`maxPathLength = 4`):

| Variant | Edges retained | Edges considered | Vertices marked | Edges dropped |
|---------|---------------|------------------|-----------------|---------------|
| Baseline (backward BFS only) | 6 | 6 | 6 (backward) | 0 |
| Forward + backward prune | 4 | 5 | 5 (forward) | 1 |

The forward-pruning variant also avoids ever queueing the orphan branch, so
its total work is strictly less than the considered-count suggests.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Discussion happens on [jgrapht-dev][devlist].
We follow the JGraphT [Code of Conduct](CODE_OF_CONDUCT.md).

## License

Dual-licensed under either:

- GNU Lesser General Public License (LGPL) 2.1 &nbsp;[`license-LGPL.txt`](license-LGPL.txt)
- Eclipse Public License (EPL) 2.0 &nbsp;[`license-EPL.txt`](license-EPL.txt)

`SPDX-License-Identifier: LGPL-2.1-or-later OR EPL-2.0`

Matches the license terms of [JGraphT][jgrapht] itself.
