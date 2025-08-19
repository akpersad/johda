### Project audit (Johda)

#### Overview
- legacy Rails web app to search/mock-order from restaurants
- root route: `johda#search`; primary flows in `JohdaController` and `MenusController`

#### Stack and versions
- Ruby: 2.2.0 (Gemfile) — EOL; likely difficult to compile on modern macOS/OpenSSL
- Rails: 4.2.0
- Bundler: 1.10.6 (lockfile) — expect to need 1.17.x for compatibility
- Sprockets: 3.4.0

#### Dependencies (high-signal)
- Core: `rails (4.2.0)`, `sqlite3` (dev/test), `pg` (prod), `thin`
- Auth: `bcrypt`, `devise` (present but not wired), `omniauth`, `omniauth-delivery-food`, `omniauth-twitter`
- Sessions: `activerecord-session_store` (GIT), configured in `config/initializers/session_store.rb`
- Views/assets: `bootstrap-sass (~> 3.1.1)`, `jquery-rails`, `sass-rails`, `uglifier`, `ratyrate`
- Utilities: `kaminari`, `figaro` (present, not used), `jbuilder`, `sdoc`
- Dev/test: `rspec-rails`, `capybara`, `selenium-webdriver`, `factory_girl_rails`, `database_cleaner`, `simplecov`, `better_errors`, `pry`, `guard-rspec`, `spring`, `byebug`
- Prod helpers: `rails_12factor`, `google-analytics-rails`

Gem source
- Gemfile uses `http://rubygems.org` (must update to `https://rubygems.org` for modern bundler/network policies)

#### App configuration
- `config/application.rb`: classic autoloader (Rails 4), sets `config.active_record.raise_in_transactional_callbacks`
- `config/environments/development.rb`: standard Rails 4 dev settings, assets debug/digest enabled
- `config/environments/production.rb`:
  - `config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?`
  - `config.assets.compile = true` (unusual in prod; okay for Heroku-era apps)
  - `config.force_ssl = true`
  - Google Analytics tracker read from `Rails.application.secrets.google_analytics_code`
- `config/environments/test.rb`: standard Rails 4 test config
- `config/initializers/omniauth.rb`: configures provider `:delivery` with `Rails.application.secrets.delivery_client_id` and `_secret`
- `config/initializers/session_store.rb`: uses `:active_record_store`

Secrets
- References to `Rails.application.secrets.*` exist, but `config/secrets.yml` is not present in the repo. App will not boot without it. Figaro is included but not used.

#### Database
- Dev/test: sqlite3 (`db/development.sqlite3`, `db/test.sqlite3`)
- Prod: `DATABASE_URL` (PostgreSQL)
- `db/schema.rb` present (version: 20151106160538)
- Tables include: `users`, `orders`, `order_catagories` (sic), `categories`, `comments`, `sessions` (for AR session store), `restaurants`, `items`, `groups`, `options`, rating-related tables from `ratyrate`

Naming inconsistencies (schema vs code)
- File `app/models/catagory.rb` defines `class Category` — file name does not match class name. In Rails 4 classic autoloading, this can still break eager loading/constant loading; should be `category.rb`.
- Join model `OrderCatagory` maps to table `order_catagories` (misspelling propagated across the codebase). Associations use the misspelled names, so it works but is error-prone.

#### Routes (high level)
- `root 'johda#search'`
- Sessions: `login`, `logout` custom controller; Devise routes are not used
- Menus: custom POST/GET routes for `order`, `order_confirm`, `confirm`, `comment`
- Rating: `post '/rate' => 'rater#create'`

#### Controllers (notable findings)
- `JohdaController#main`
  - defines a nested method `most_recent` inside the action; Ruby will define it as an instance method on the controller, not a closure; relies on `@results`. This is brittle and confusing.
  - writes to DB on every search: creates many `Restaurant` rows without de-duplication; potential uncontrolled growth and duplicate records.
  - uses `Kaminari.paginate_array` on data aggregated from existing `Restaurant` rows.
- `MenusController#index`
  - relies on `params.key("")` to derive a merchant id key from a parameter whose value is an empty string. This is highly brittle.
  - creates/fetches a `MenuComment` record for each `merch_id`.
- `MenusController#order`
  - branches on `session[:user_id]` (custom sessions logic), not Devise
- Session helpers are referenced (`include SessionsHelper`), but custom auth is used alongside a present-but-unused Devise gem.

#### Models (notable)
- `User`: custom auth using `has_secure_password`; validations present; duplicate password validation listed twice. Methods for remember token logic roll-your-own remember-me.
- `Category`/`OrderCatagory`: naming mismatches noted above.

#### Assets
- `app/assets/javascripts/application.js` requires `bootstrap` (from `bootstrap-sass`), `jquery.raty`, `ratyrate`, and vendor trees.
- `app/assets/stylesheets/application.css.scss` imports `bootstrap`; depends on glyphicons via sprockets `depend_on_asset` comments; includes many remote HTTP image URLs and Google Fonts via `http`.
- Note: Historical comment mentions hacked bootstrap; current code uses `bootstrap-sass` gem, but any edits to minified vendor files should be removed in favor of gem-managed assets.

#### Testing
- RSpec test suite present (controllers, helpers, models, views, routing). Unknown pass/fail state; likely red until environment boots.

#### Glaring issues and risks
- EOL runtime: Ruby 2.2.0 + Rails 4.2.0 require legacy toolchains; compilation on macOS 14 is non-trivial.
- Insecure gem source (`http`) blocks installs on modern networks; must change to `https`.
- Missing `config/secrets.yml` will prevent boot; OmniAuth/GA secrets referenced but undefined.
- Autoload/file-name mismatch: `catagory.rb` vs `Category` (fixed in v1).
- Widespread misspelling `catagories` in code (partially corrected in v1; DB names deferred to v2).
- Mixed authentication approaches: Devise gem present but unused; custom sessions used.
- Fragile parameter handling (`params.key("")`) and nested method definitions in controllers.
- Restaurant duplication on each search; no uniqueness constraints.
- External asset URLs use `http` (mixed content if served over HTTPS), and remote dependencies.

#### Heroku-era assumptions
- Presence of `rails_12factor`, `pg`, `config.assets.compile = true`, and `README` mention of Heroku implies original deploy target was Heroku.


