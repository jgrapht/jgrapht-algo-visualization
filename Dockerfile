# JGraphT algorithm visualizations: navigation homepage + per-topic
# self-contained HTML pages (shortest paths, Hamiltonian path).
# Served by nginx-alpine.
FROM nginx:1.27-alpine

# Run as non-root for safer deployment.
RUN addgroup -S app && adduser -S -G app app \
    && touch /var/run/nginx.pid \
    && chown -R app:app /var/cache/nginx /var/run/nginx.pid /usr/share/nginx/html /etc/nginx/conf.d

# Nav homepage + favicons at root.
COPY --chown=app:app index.html /usr/share/nginx/html/index.html
COPY --chown=app:app favicon.ico /usr/share/nginx/html/favicon.ico
COPY --chown=app:app apple-touch-icon.png /usr/share/nginx/html/apple-touch-icon.png

# Per-topic visualization pages (one self-contained HTML each).
COPY --chown=app:app shortest-paths /usr/share/nginx/html/shortest-paths
COPY --chown=app:app hamiltonian   /usr/share/nginx/html/hamiltonian

COPY --chown=app:app nginx.conf /etc/nginx/conf.d/default.conf

USER app

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -q --spider http://127.0.0.1:8080/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
