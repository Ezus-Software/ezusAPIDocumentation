# Ezus API Documentation

Documentation de l'API Ezus, générée avec [Slate](https://github.com/slatedocs/slate) (Middleman + Ruby) et déployée sur Netlify à chaque push.

---

## Prérequis

| Outil | Version | Install                                                                         |
| ----- | ------- | ------------------------------------------------------------------------------- |
| Ruby  | 3.4.x   | [RubyInstaller Windows](https://rubyinstaller.org/) — **coche DevKit** à la fin |
| Git   | —       | [git-scm.com](https://git-scm.com/)                                             |

Vérifie l'install :

```bash
ruby -v      # -> 3.4.x
bundle -v
```

Si `bundle install` plante plus tard sur des gems natifs (`nokogiri`, `sassc`, `ffi`), lance `ridk install` et choisis l'option **3**.

---

## 1. Installation depuis ton fork

```bash
git clone https://github.com/<ton-user>/ezusAPIDocumentation.git
cd ezusAPIDocumentation
bundle install
```

`bundle install` lit le `Gemfile` et télécharge toutes les dépendances Ruby dans ton projet. À ne faire qu'une fois (ou après un changement de `Gemfile`).

---

## 2. Lancer en local

**Mode dev avec hot-reload** (recommandé pour éditer la doc) :

```bash
bundle exec middleman server
```

Ouvre http://localhost:4567. Chaque modif d'un fichier source recharge la page automatiquement. `Ctrl + C` pour stopper.

**Mode build statique** (pour tester exactement ce que Netlify va déployer) :

```bash
bundle exec middleman build
```

Le site compilé atterrit dans `build/`. Pour le servir :

```bash
cd build
python -m http.server 8000
```

Puis http://localhost:8000.

---

## 3. Où éditer quoi

| Fichier / Dossier           | Rôle                                       |
| --------------------------- | ------------------------------------------ |
| `source/index.html.md`      | **Contenu principal** de la doc (Markdown) |
| `source/includes/*.md`      | Sections incluses (ex. `_errors.md`)       |
| `source/stylesheets/*.scss` | Styles SCSS                                |
| `source/javascripts/`       | Scripts front (search, toc, copy, lang)    |
| `source/layouts/layout.erb` | Template HTML global                       |
| `source/images/`            | Logo, images                               |
| `config.rb`                 | Config Middleman                           |
| `Gemfile`                   | Dépendances Ruby                           |
| `.ruby-version`             | Version Ruby utilisée en prod              |

---

## 4. Ajouter ou modifier un gem

Après un changement dans le `Gemfile` :

```bash
bundle install
bundle lock --add-platform x86_64-linux
bundle lock --add-platform ruby
```

Les deux `--add-platform` sont **essentielles** : elles ajoutent les plateformes Linux dans le `Gemfile.lock` pour que Netlify (qui build sur Linux) puisse installer les gems. Sans ça, le build Netlify plante.

Ensuite commit les deux fichiers ensemble :

```bash
git add Gemfile Gemfile.lock
git commit -m "deps: <what you changed>"
git push
```

---

## 5. Déploiement

Un push sur la branche de prod déclenche automatiquement un build Netlify. La config côté Netlify :

- **Build command** : `bundle exec middleman build`
- **Publish directory** : `build`
- **Ruby version** : contrôlée par `.ruby-version` à la racine du repo

---

## Troubleshooting rapide

| Erreur                                                  | Fix                                                                                                                                   |
| ------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `CssSyntaxError: Unknown word` sur `//`                 | Les fichiers SCSS doivent s'appeler `screen.css.scss` / `print.css.scss` (double extension), pas seulement `.css`                     |
| `Unexpected token: keyword (const)` au build JS         | Dans `config.rb`, remplace `activate :minify_javascript` par `activate :minify_javascript, compressor: ::Uglifier.new(harmony: true)` |
| Build Netlify : Ruby version mismatch                   | Vérifie que `.ruby-version` contient la même version que celle que tu utilises en local                                               |
| Build Netlify : `Could not find gem ... in locked gems` | Tu as oublié les `bundle lock --add-platform`, refais-les et recommit `Gemfile.lock`                                                  |
| `bundle install` plante sur Windows                     | Lance `ridk install` puis option 3 pour installer le toolchain natif                                                                  |

---

## Stack

- [Middleman](https://middlemanapp.com/) 4.x — static site generator
- [Slate](https://github.com/slatedocs/slate) — template doc API
- [Redcarpet](https://github.com/vmg/redcarpet) — parser Markdown
- [Rouge](https://github.com/rouge-ruby/rouge) — coloration syntaxique
- Hébergement : Netlify
