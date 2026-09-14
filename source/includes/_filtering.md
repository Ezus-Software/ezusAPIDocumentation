# Filtering

List endpoints accept query-parameter filters. Each endpoint lists its available filters and labels each one with its type: a plain exact match, a dynamic (text) filter, or a dynamic date filter. Some are additionally flagged as linked-record filters, meaning they only match objects whose linked entity has not been deleted.

## Linked-Record Filters

Across list endpoints, some filters target a **linked record** (e.g. the client, project or alternative attached to an invoice) rather than the returned object itself.

By default, a list includes objects whose linked record has been deleted: the object still exists (e.g. an invoice remains even if the client or project linked to it has been deleted).

But **a linked-record filter only matches objects whose linked record still exists**. As a result, applying such a filter excludes objects attached to a deleted linked record (e.g. filtering invoices on a project start date in June 2026 will not return invoices linked to _deleted_ projects that started in June 2026).

Filtering on a linked-record field therefore narrows results to objects whose linked record is not deleted.

Each endpoint indicates which of its filters are linked-record filters.

## Dynamic Filters

Some filters can be marked as Dynamic filter.
When a filter is dynamic, it only accepts **String** values, and you can append operator suffixes directly to the query parameter name.

Let’s take the `email` field as an example.  
If it’s defined as a dynamic filter, you can use different comparison operators in the query parameter name:

| Operator    | Suffix    | Description                                                                                   | Example                                   |
| ----------- | --------- | --------------------------------------------------------------------------------------------- | ----------------------------------------- |
| Equals      |           | Filters that aren’t marked as dynamic default to equals, meaning it will match values exactly | `email=contact@moke-international.com`    |
| Equals      | `_eq`     | Exact match                                                                                   | `email_eq=contact@moke-international.com` |
| Starts with | `_starts` | Field value starts with...                                                                    | `email_starts=contact`                    |
| Ends with   | `_ends`   | Field value ends with...                                                                      | `email_ends=international.com`            |
| Contains    | `_like`   | Field value contains...                                                                       | `email_like=moke`                         |

## Dynamic Date Filters

Some date filters can be marked as Dynamic date filter.
They follow the same suffix mechanism as text [Dynamic filters](#filtering-dynamic-filters), but with date comparison operators. Values must be provided in `YYYY-MM-DD` format.

| Operator     | Suffix | Description                                                                                   | Example                       |
| ------------ | ------ | --------------------------------------------------------------------------------------------- | ----------------------------- |
| Equals       |        | Filters that aren’t marked as dynamic default to equals, meaning it will match values exactly | `created_date=2026-01-15`     |
| Equals       | `_eq`  | Exact date                                                                                    | `created_date_eq=2026-01-15`  |
| After        | `_gt`  | Strictly after                                                                                | `created_date_gt=2026-01-01`  |
| On or after  | `_gte` | On or after (incl.)                                                                           | `created_date_gte=2026-01-01` |
| Before       | `_lt`  | Strictly before                                                                               | `created_date_lt=2026-02-01`  |
| On or before | `_lte` | On or before (incl.)                                                                          | `created_date_lte=2026-01-31` |

A date range is obtained by combining two suffixes, e.g. `created_date_gte=2026-01-01&created_date_lte=2026-03-31`.
