# Johda

An online delivery Rails app allowing users to search and mock-order from restaurants.

Production hosting is currently offline.

## Run locally (Docker Desktop)

Prereqs: Docker Desktop installed and running.

1) Build the image
```bash
docker build -t johda:v1 .
```

2) Start the server (port 3000)
```bash
docker run --name johda-dev -p 3000:3000 -d johda:v1 bash -lc "bundle exec rake db:schema:load && exec bundle exec rails s -b 0.0.0.0 -p 3000"
```

3) Open the app
```bash
http://localhost:3000
```

4) Logs / stop
```bash
docker logs -f johda-dev
docker rm -f johda-dev
```

## Notes
- Legacy stack: Ruby 2.3.8, Rails 4.2.0, sqlite (dev)
- OmniAuth delivery provider is gated by secrets; not required for core flows
- Known historical misspelling corrected in code: "catagories" → "categories" (DB renames planned)
- See `docs/PROJECT_AUDIT.md`, `docs/REVIVAL_PLAN.md`, and `docs/MODERNIZATION_ROADMAP.md` for details
