### Revival plan (v1: make it run)

Status: in progress — updated with decisions and completed steps.

#### Goals
- Boot locally on macOS with native toolchain
- Run `rails server` and access root page without 500s
- Seed minimal data path to exercise main flows
- Get RSpec suite to at least boot (passing optional)

#### Decisions (v1)
- Keep Rails 4.2.0; do not upgrade framework in v1
- Run via Docker Desktop using linux/amd64 base (Ruby 2.3.8 on Debian Stretch) for reproducible legacy runtime
- Use sqlite3 for dev/test; skip prod concerns
- Keep custom auth/session approach (Devise present but unused)
- Gate OmniAuth provider init on secrets presence

#### Steps
1) Tooling/setup
   - [x] Add Dockerfile and `.dockerignore` for legacy runtime
   - [x] Build image with Ruby 2.3.8 (Debian Stretch) and Bundler 1.17.3
   - [x] Run server in container; expose port 3000
   - [ ] Add `bin/dev` script for one-line run (optional)
2) Gemfile fixes
   - [x] Switch source to `https://rubygems.org`
   - [x] Replace git protocol for `activerecord-session_store` with released gem `0.1.2`
3) Secrets/config
   - [x] Add `config/secrets.yml` with placeholder dev/test values
   - [x] Gate OmniAuth `:delivery` provider on secret presence
4) Autoloading/naming (code-level)
   - [x] Rename `app/models/catagory.rb` -> `category.rb`
   - [x] Fix misspelling usages: `catagories` → `categories` in menu flow and `SortOrder`
   - [x] Temporary alias for `Menu#catagories` to preserve old calls
   - [ ] Full DB/table renames deferred to v2 (see roadmap)
5) Sessions table
   - [x] Load schema in container at boot; `sessions` table present
6) Assets cleanup (v1 scope)
   - [ ] Audit/remove any hacked vendor assets (kept gem-provided bootstrap for now)
7) Boot and smoke test
   - [x] Server boots in container; root `/` renders and menu flow loads (with known fragile areas)
8) External integrations
   - [x] OmniAuth `delivery` gated; not required for core flows
   - [ ] Delivery::Client API key (`DELIVERY_KEY`) may be required for full menu fidelity; stub/guard as needed
9) Tests (optional for v1)
   - [ ] Ensure `rspec` boots; fix trivial requires

#### Nice-to-have fixes (still v1)
- [ ] Replace `params.key("")` usage with explicit param names
- [ ] Avoid defining methods within controller actions
- [ ] Add uniqueness validation/index for `restaurants.name` or `merchant_id` to reduce dupes

#### Runbook (commands)
- Native path:
  - Install ruby: `rbenv install 2.2.0` (with legacy openssl flags) or use `ruby-install`
  - Install bundler: `gem install bundler -v 1.17.3`
  - Bundle: `bundle _1.17.3_ install`
  - DB: `bin/rake db:setup` or `bin/rake db:schema:load db:seed`
  - Server: `bin/rails s`
- Docker path (Docker Desktop):
  - Build: `docker build -t johda:v1 .`
  - Run: `docker run --name johda-dev -p 3000:3000 -d johda:v1 bash -lc "bundle exec rake db:schema:load && exec bundle exec rails s -b 0.0.0.0 -p 3000"`
  - Logs: `docker logs -f johda-dev`
  - Stop: `docker rm -f johda-dev`

#### Exit criteria
- App boots via Docker and renders search page
- Menu flow renders; misspelling corrections applied; remaining fragile areas noted


