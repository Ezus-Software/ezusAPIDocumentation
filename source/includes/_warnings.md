# Warnings

<aside class="notice">
Classic Warning messages
</aside>
The Ezus API uses the following warning message format: `{code}_field`.

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
