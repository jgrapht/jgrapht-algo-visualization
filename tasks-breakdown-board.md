# jgrapht-algo-visualization — Tasks Board

Companion teaching/demo site for [JGraphT](https://jgrapht.org/) algorithms. One self-contained
static HTML file per topic, no build step. Mirrors the algorithm roadmap in
`../jgrapht-roadmap.md` (Workstream R).

> **Ownership note:** visualization *code* is authored in a dedicated session. This board is a
> tracking artifact only — update statuses here; do not assume the code state from this file.

Status: `live` (shipped) · `wip` · `planned` (roadmap, not started).

## Topics

| Topic | Folder | Status | Algorithms | Backing JGraphT class |
|-------|--------|--------|------------|------------------------|
| Shortest paths | `/shortest-paths/` | `live` | Yen, Eppstein, Bounded-pruned Yen, Dijkstra, A*, AllDirectedPaths prune | `*ShortestPath`, `AllDirectedPaths` |
| Hamiltonian path | `/hamiltonian/` | `live` | Backtracking (vanilla + pruned), DAG longest-path, Held-Karp | `BacktrackingHamiltonianPath`, `DagHamiltonianPath`, `HeldKarpHamiltonianPath` |
| Minimum spanning tree | `/spanning-tree/` | `live` | Kruskal, Prim, Borůvka | `*MinimumSpanningTree` |
| Maximum flow / min cut | `/max-flow/` | `live` | Edmonds-Karp, Dinic | `EdmondsKarpMFImpl`, `DinicMFImpl` |
| Bipartite matching | `/matching/` | `live` | Greedy, Kuhn augmenting paths, Hopcroft-Karp | `*BipartiteMatching` |
| Strongly connected components | `/connectivity/` | `live` | Kosaraju, Tarjan, Gabow | `*StrongConnectivityInspector` |
| Community detection | `/clustering/` | `live` | Louvain (local-moving + aggregation), Leiden (refinement + connectivity guarantee) | `LouvainClustering`, `LeidenClustering` |
| Graph hashing | `/hashing/` | `live` | Weisfeiler-Lehman colour refinement (labels, subtree sequences, parallel-edge rule) | `org.jgrapht.alg.isomorphism` WL hash |

## Planned (roadmap Workstream R — not started)

| Topic | Folder | Tied to roadmap | Notes |
|-------|--------|-----------------|-------|
| Temporal graphs | `/temporal/` | B1/B2 | snapshot slider; animated earliest-arrival path |
| Dynamic connectivity | `/dynamic/` | C1 | components merge; incremental vs recompute |
| Centrality (landmark) | `/centrality/` | D2 | estimate stabilises with landmark count |
| Similarity | `/similarity/` | G1 | SimRank heatmap + convergence |
| Planar faces / dual | `/planarity/` | I1 | faces highlighted, dual overlay |
| Motifs / triads | `/motifs/` | J1 | triad-type highlighting |
| Shortest-path planner | `/shortest-path-planner/` | L1 | algorithm-selection decision tree |

## Conventions (do not regress)

- Self-contained HTML per topic; **no external JS/CSS, no build step**.
- Mobile-friendly; dark theme via the shared CSS variables (`--bg`, `--panel`, `--accent`, …).
- Graph state must match the corresponding JGraphT algorithm exactly (replay real algorithm output).
- Each page: pseudocode + glossary + "why this matters".
- New topic ⇒ add a card to the root `index.html` grid.
- Deploy: static (Vercel `vercel.json` / nginx); `.nojekyll` present.
