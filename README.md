# Ezus API Documentation

Public API documentation for Ezus, built with [Slate](https://github.com/slatedocs/slate) (Middleman + Ruby) and deployed to Netlify on every push.

---

## Requirements

| Tool    | Version | Install                                                                                   |
| ------- | ------- | ----------------------------------------------------------------------------------------- |
| Ruby    | 3.4.x   | [RubyInstaller for Windows](https://rubyinstaller.org/) — **check DevKit** during install |
| Bundler | 2.6.x   | `gem install bundler -v 2.6.2` (newer Bundler 3.x/4.x is not compatible)                  |
| Git     | —       | [git-scm.com](https://git-scm.com/)                                                       |

Verify your install:

```bash
ruby -v      # -> 3.4.x
bundle -v    # -> 2.6.x
```

If `bundle install` later fails on native gems (`nokogiri`, `sassc`, `ffi`) on Windows, run `ridk install` and pick option **3** to install the native toolchain.

---

## 1. Install from your fork

```bash
git clone https://github.com/<your-user>/ezusAPIDocumentation.git
cd ezusAPIDocumentation
bundle install
```

`bundle install` reads the `Gemfile` and downloads all Ruby dependencies into the project. Run it once, then again whenever the `Gemfile` changes.

---

## 2. Run locally

**Dev mode with hot-reload** (recommended while editing):

```bash
bundle exec middleman server
```

Open http://localhost:4567. The page reloads automatically on every source file change. Stop with `Ctrl + C`.

**Static build** (matches exactly what Netlify will deploy):

```bash
bundle exec middleman build
```

The compiled site lands in `build/`. Serve it locally with:

```bash
cd build
python -m http.server 8000
```

Then open http://localhost:8000.

---

## 3. Where to edit what

| File / Folder               | Role                                       |
| --------------------------- | ------------------------------------------ |
| `source/index.html.md`      | **Main doc content** (Markdown)            |
| `source/includes/*.md`      | Included sections (e.g. `_errors.md`)      |
| `source/stylesheets/*.scss` | SCSS styles                                |
| `source/javascripts/`       | Frontend scripts (search, toc, copy, lang) |
| `source/layouts/layout.erb` | Global HTML layout                         |
| `source/images/`            | Logo, images                               |
| `config.rb`                 | Middleman config                           |
| `Gemfile`                   | Ruby dependencies                          |
| `.ruby-version`             | Ruby version used in production            |

---

## 4. Add or update a gem

After any change to the `Gemfile`:

```bash
bundle install
bundle lock --add-platform x86_64-linux
bundle lock --add-platform ruby
```

The two `--add-platform` commands are **essential**: they add the Linux platforms to `Gemfile.lock` so Netlify (which builds on Linux) can install the gems. Without this, Netlify's build will fail.

Commit both files together:

```bash
git add Gemfile Gemfile.lock
git commit -m "deps: <what you changed>"
git push
```

---

## 5. Deployment

Pushing to the production branch triggers an automatic Netlify build. Netlify settings:

- **Build command**: `bundle exec middleman build`
- **Publish directory**: `build`
- **Ruby version**: controlled by `.ruby-version` at the repo root
- **Bundler version**: auto-detected from `BUNDLED WITH` in `Gemfile.lock`

---

## Stack pinning — why these versions

This project is pinned to a specific legacy stack. Do **not** upgrade blindly:

- **Middleman `~> 4.5.0`** — newer 4.6.x requires Rack 3, which breaks Sprockets 3
- **Sprockets `~> 3.7`** — ships with built-in Sass support and processes `//= require` JS directives; Sprockets 4.x dropped the Sass processor and would break both CSS compilation and JS bundling
- **Bundler `~> 2.6`** — Bundler 3.x/4.x forces Middleman to the 4.6.x branch via transitive constraints, which conflicts with Sprockets 3
- **Terser** (not Uglifier) — used for JS minification because the JS source contains ES6 syntax (`const`, arrow functions) that legacy UglifyJS can't parse

---

## Troubleshooting

| Error                                                                          | Fix                                                                                                                                                                                                |
| ------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `CssSyntaxError: Unknown word` on `//`                                         | SCSS files must be named `screen.css.scss` / `print.css.scss` (double extension), not just `.css`                                                                                                  |
| `Unexpected token: keyword (const)` during JS build                            | Make sure `config.rb` uses `activate :minify_javascript, compressor: ::Terser.new` (not the default Uglifier)                                                                                      |
| Dropdown menus don't open / no pink-purple highlight on active items           | `activate :sprockets` is missing from `config.rb`, or `middleman-sprockets` / `sprockets` aren't in the `Gemfile` — without Sprockets, `//= require` directives are ignored and jQuery never loads |
| `bundler: failed to load command: middleman` + `cannot load such file -- sass` | Add `gem 'sass'` to the `Gemfile` — Sprockets 3 needs the legacy ruby-sass gem to render SCSS                                                                                                      |
| `Your bundle requires a different version of Bundler`                          | You're on Bundler 3.x/4.x. Install 2.6.2 (`gem install bundler -v 2.6.2`) and prefix commands with `bundle _2.6.2_`                                                                                |
| Netlify: Ruby version mismatch                                                 | Make sure `.ruby-version` matches the version you use locally                                                                                                                                      |
| Netlify: `Could not find gem ... in locked gems`                               | You forgot the `bundle lock --add-platform` steps — run them and recommit `Gemfile.lock`                                                                                                           |
| `bundle install` fails on Windows                                              | Run `ridk install` and pick option 3 to install the native toolchain                                                                                                                               |

---

## Stack

- [Middleman](https://middlemanapp.com/) 4.5 — static site generator
- [Slate](https://github.com/slatedocs/slate) — API doc template
- [Sprockets](https://github.com/rails/sprockets) 3.7 — asset pipeline (JS bundling + Sass)
- [Redcarpet](https://github.com/vmg/redcarpet) — Markdown parser
- [Rouge](https://github.com/rouge-ruby/rouge) — syntax highlighting
- [Terser](https://github.com/ahorek/terser-ruby) — JS minifier
- Hosting: Netlify
