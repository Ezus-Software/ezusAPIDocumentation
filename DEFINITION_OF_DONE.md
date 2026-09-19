# Definition of done

A documentation change is done when the site builds, every link resolves, and the payload
on the page is the one the API actually answers.

Run this gate before every commit. If a step cannot pass, **do not commit**: write down
what blocks you and ask.

---

## 1. Build the site

This is exactly what the `Build` workflow and Netlify run. `README.md` has the setup and
the troubleshooting table.

```bash
bundle exec middleman build
```

`build/` is generated and gitignored. Never commit it, and never edit it — only `source/`.

## 2. Check every in-page link

Anchors are generated from the headings at build time, so only the built page can tell you
a link is dead. Run this after the build; it must print `none`:

```bash
python -c "
import re
html = open('build/index.html', encoding='utf-8').read()
ids = set(re.findall(r\"<h\d id='([^']*)'\", html))
broken = sorted(l for l in set(re.findall(r'href=\"#([^\"]+)\"', html)) if l not in ids)
print('broken in-page links:', broken or 'none')
"
```

An anchor is the heading, lowercased, spaces hyphenated, prefixed by the `# Title` of its
file: `## Langs` under `# Nested Resources` is `#nested-resources-langs`.

## 3. Check the Postman export

It must stay valid JSON, and carry every route you documented:

```bash
python -c "
import json
d = json.load(open('source/ezus_api_postman.json', encoding='utf-8'))
print([i['name'] for i in d['item']])
"
```

## 4. Compare the page with a real call

For every payload you added or changed, call the endpoint on a dev stage and diff it
against what the page shows — key by key, including the ones you did not touch. The
`DEFINITION_OF_DONE.md` of the API repository has the login and call snippet.

Check in particular:

- Every key on the page exists in the answer, with that exact name.
- No key of the answer is missing from the page.
- The sample values are shaped like the real ones: a date in the real format, an enum that
  is really one of the listed values, an id that looks like the real ids.
- A field the API can omit or return `null` says so on the page.

## 5. Re-read your own diff

- Is the route in the topic file it belongs to, rather than in a section of its own?
- Are the objects of the response in `_nested_resources.md`, with the route section only
  linking to them?
- Does a sentence still hold if you delete the endpoint? Then it says nothing — cut it.
- Do the wordings read like the tables next to them, or like something you wrote from
  scratch?
- Did you add a topic without adding it to `includes:` in `index.html.md`?

---

## Stop and ask, do not commit

- The API answers something the ticket did not describe, or does not answer something it
  did. The documentation follows the API, and the gap is worth a question.
- A value on the page would be a guess: a limit, a lifetime, a format you have not seen.
- The change renames or removes a key of a published response. That is breaking for every
  integrator and is not a documentation decision.
- The build fails for a reason `README.md` does not cover.

## What the commit message carries

Conventional style, the ticket in the scope: `docs(EZUS-1234): …`. The body says which
route changed, what an integrator has to do differently, and whether the Postman export
moved with it.
