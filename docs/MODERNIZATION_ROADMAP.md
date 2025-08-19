### Modernization roadmap (v2)

Principles
- Prefer supported runtimes; minimize bespoke code; remove dead dependencies
- Keep feature parity first; improve UX incrementally

Runtime/platform
- Upgrade to Ruby 3.3.x and Rails 7.1/7.2
- Replace `sprockets`/asset pipeline usage with Importmap or JS bundler (esbuild or Vite)
- Replace `bootstrap-sass` with npm `bootstrap@5` and SCSS via bundler

Auth/session
- Remove custom session helpers and wire Devise properly (or Authlogic/Sorcery)
- Drop `activerecord-session_store` in favor of cookie store or Redis store if needed

Data model
- Fix naming: migrate `order_catagories` -> `order_categories`; `OrderCatagory` -> `OrderCategory`; `catagory.rb` -> `category.rb` (with data migrations)
- Add migration to rename `catagory_id` to `category_id` and update associations
- Add uniqueness indexes on `restaurants.merchant_id` and/or name+address
- Consider pruning rating-related tables if unused

Controllers/routes
- Replace fragile patterns (`params.key("")`, nested method definitions)
- Extract service objects for `Getrestaurants`, `SortOrder`, and external API clients

External services
- Remove dead OmniAuth strategies (`omniauth-delivery-food`) if API defunct
- If keeping OAuth, upgrade to maintained strategies (Google, GitHub, etc.)

Views/UI
- Bootstrap 5 rewrite; remove glyphicons; use SVG icons
- Replace remote HTTP assets with local or CDN HTTPS; remove inline animation cruft

Testing/quality
- Upgrade RSpec to latest; migrate configuration
- Add RuboCop and StandardRB for style; add Brakeman for security; Bundler Audit

Operations
- Containerize with Docker (dev) or use `bin/setup` scripts
- Add CI (GitHub Actions) to run tests and lint

Migration plan
1) Upgrade to Rails 5.2 (bridge), then 6.1, then 7.x, or do a new Rails 7 app and port features incrementally
2) Rename models/tables with migrations and backfills (categories/order_categories, foreign keys)
3) Replace assets pipeline bits; move to modern JS toolchain
4) Wire Devise and sessions; remove custom auth
5) Sweep controllers/services; add unit/integration tests

De-risking
- Keep v1 branch frozen; create v2 branch; incremental PRs; CI green at each step


