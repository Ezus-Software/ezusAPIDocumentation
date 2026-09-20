# Conventions

This repository is the public API documentation an integrator reads. `README.md` covers
the toolchain — Ruby, Middleman, Netlify. This file covers what you write.
`DEFINITION_OF_DONE.md` covers what you check before committing.

## Document from a real call

Read the payload from the endpoint on a dev stage, never from the code alone. A response
key can be right in the service and still carry something an integrator cannot use — a
raw wording key, an internal id, a soft-deleted row. Paste what the API actually answers,
then write the table from it.

## Where content lives

| File                            | Role                                                             |
| ------------------------------- | ---------------------------------------------------------------- |
| `source/index.html.md`          | Front matter, the intro, and the ordered `includes:` list        |
| `source/includes/_<topic>.md`   | One topic: its `# Title` and its `## VERB route` sections        |
| `source/includes/_nested_resources.md` | The JSON objects several routes return                    |
| `source/ezus_api_postman.json`  | The Postman collection shipped with the doc                      |

A new topic needs its file **and** its name added to `includes:` in `index.html.md`.
A route that belongs to an existing topic goes in that file, never in one of its own.

## The shape of a route section

```
## VERB route

One or two sentences: what it returns, and the one thing a reader has to know.

shell block, then javascript block

> This request returns a structured JSON object:

json block — the nominal response, no optional object

### HTTP Endpoint
### Header Parameters
### Query Parameters       (GET)  /  ### Body Parameters (application/json)  (POST, PUT)
### Response
```

The `Response` table names the top-level keys and links each JSON object to its nested
resource. It does not restate the object.

## Nested resources

An object of more than two or three fields, or one that more than one route returns, is a
`## Name` section in `_nested_resources.md`: a JSON sample, then its table. Link to it as
`([Name](#nested-resources-name))` — lowercase, spaces become hyphens, prefixed by the
`# Title` of the file.

That section is also where an object's caveats go — a value that can be `null`, a figure
that is not real time, a code to decode. Keep the route section free of them.

## Wording

Terse and factual, like the tables already there: `Email of the user`,
`Display name of the tag`, `Tag type. Possible values: ...`. No selling, no explaining why
an endpoint is convenient, no sentence that would still be true with the endpoint removed.

Closed sets are listed. A format is shown, not described. Anything that can come back
`null` says so.

Use `<aside class="notice">` for something a reader must know before integrating and
`<aside class="warning">` for something that will break them. At most one per section —
they stop being read otherwise.

## Postman

Every documented route has an entry in `source/ezus_api_postman.json`, with the same
method and URL. Optional query parameters are present and `"disabled": true`. Only
`source/` is edited; `build/` is generated and gitignored.

## Language and line endings

Everything is written in English.

Markdown is platform agnostic: nothing here depends on the line endings of a file, and
Middleman renders CRLF and LF the same way. Keep whatever a file already has — never
convert one wholesale, it turns a one-line change into a diff nobody can review.

## Stay inside what was asked

Change the files the task names, and nothing else. The toolchain — `Gemfile`,
`Gemfile.lock`, `config.rb`, the build command, the CI workflow — is not yours to
rework on the way to a documentation change unless the task asks for it. Nor is
reordering a file, renaming a section or reformatting a table the task did not
mention. A diff that carries more than the ask costs the reviewer more than it
saves you: if something next door looks wrong, say so and leave it.
