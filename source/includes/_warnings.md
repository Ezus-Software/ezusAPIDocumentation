# Warnings

<aside class="notice">
Classic Warning messages
</aside>
The Ezus API uses the following warning message format in the message field: `{code}_{field}`. Where:

- `code` is the warning code
- `field` is the field name that caused the warning

Multiple warnings are separated by a comma.

The Ezus API uses the following warning codes:

| Warning Code | Meaning                  |
| ------------ | ------------------------ |
| skip         | A field has been skipped |

<aside class="notice">
Warning messages examples
</aside>
Here is a warning message example:

```json
{
  "error": "false",
  "message": "skip_company_number,skip_vat_number",
  "action": "Client successfully updated",
  "reference": "client_reference"
}
```

In this case, the fields `company_number` and `vat_number` have been skipped during the update of the client. This is due to the fact that these fields are not used for an `individual` client type. Therefore, these fields have been ignored and not updated.

## Ignored Query Parameters

On a `GET` endpoint, each query parameter the endpoint does not support (see [Unsupported Filters](#filtering-unsupported-filters)) adds a warning to the `message` field:

`Warning: The filter '{parameter}' does not exist and was ignored`

Multiple warnings are separated by a comma. `message` is absent when every query parameter is supported.

```json
{
  "error": "false",
  "next_token": "<NEXT_TOKEN>",
  "size": 85,
  "data_size": 50,
  "page": 1,
  "suppliers": [...],
  "message": "Warning: The filter 'company_name_like' does not exist and was ignored,Warning: The filter 'capacity_like' does not exist and was ignored"
}
```

In this case, `GET suppliers?company_name_like=Tren&capacity_like=10` returned every supplier: neither filter is supported by this endpoint.
