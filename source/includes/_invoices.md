# Invoices

## GET invoices

Returns a list of your invoices, sorted by creation date from newest to oldest, with the most recent invoices appearing first. You can specify filters as query parameters to narrow down your search. The list of invoices returned is paginated (50 per 50): to call the 50 next items in the list, call the route with the `next_token` query parameter.

```shell
curl --location 'https://api.ezus.app/invoices?stage=completed' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Authorization: Bearer <YOUR_TOKEN>'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.get(baseUrl + "/invoices?stage=completed", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "next_token": "<NEXT_TOKEN>",
  "size": 338,
  "data_size": 50,
  "page": 1,
  "invoices": [
    {
      "error": "false",
      "reference": "invoice_reference",
      "info_number": "2023_101010",
      "type": "credit_note",
      "origin_reference": "origin_reference",
      "origin_info_number": "2023_101009",
      "stage": "completed",
      "created_date": "2023-10-10",
      "send_date": "2023-10-10",
      "due_date": "2023-10-10",
      "currency": "EUR",
      "is_einvoice_ready": true,
      "amount_ttc": 1200.0,
      "amount_ht": 1000.0,
      "vat": 200.0,
      "project": {
        "reference": "project_reference",
        "info_number": "202306001-P",
        "info_title": "Paris fashion week 2024",
        "info_stage_reference": "confirmed",
        "info_stage": "Confirmed",
        "currency": "EUR",
        "is_closed": false
      },
      "alternative": {
        "sort_order": "0",
        "title": "Main Alternative",
        "trip_date_in": "2024-03-01",
        "trip_date_out": "2024-03-09",
        "trip_duration": 9
      },
      "client": {
        "reference": "client_reference",
        "type": "enterprise",
        "company_name": "MOKE INTERNATIONAL LIMITED",
        "first_name": "Jane",
        "last_name": "Doe",
        "email": "contact@moke-international.com"
      },
      "forecast": {
        "is_automatic": true,
        "purchase": 0.0,
        "commission": 0.0,
        "vat_deducted": 0.0,
        "amount_ht": 1000.0
      },
      "actual": {
        "is_automatic": true,
        "purchase": null,
        "commission": null,
        "vat_deducted": null,
        "amount_ht": null
      },
      "url": "https://ezus.io/2023_101010.pdf"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/invoices`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter                    | Type                                                                                          | Description                                                                                                                                                               |
| ---------------------------- | --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token                   | String                                                                                        | Specify this parameter if you want to retrieve the following elements of a given list query. If this parameter is filled, other parameters are ignored.                   |
| stage                        | String                                                                                        | You can filter invoices that are at a specific stage. The stage can be `paid`, `completed` or `draft`.                                                                    |
| is_einvoice_ready            | Boolean                                                                                       | Filter invoices ready for e-invoicing. Accepts `true` or `false`.                                                                                                         |
| client_reference             | [Linked-record filter](#linked-record-filters)                                                | Exact match. Filter invoices by the reference of the linked client.                                                                                                       |
| project_info_stage_reference | [Linked-record filter](#linked-record-filters)                                                | Exact match. Filter invoices whose linked project is at a given stage...                                                                                                  |
| technical_name               | String                                                                                        | You can filter invoices according to one of their custom fields by adding the `technical_name` of the custom field as a query parameter and the desired value as a value. |
| info_number                  | [Dynamic filter](#dynamic-filters)                                                            | Filter on the invoice's `info_number`.                                                                                                                                    |
| project_info_number          | [Linked-record filter](#linked-record-filters) + [Dynamic filter](#dynamic-filters)           | Filter on the linked project's `info_number`.                                                                                                                             |
| created_date                 | [Dynamic date filter](#dynamic-date-filters)                                                  | Filter on the invoice creation date.                                                                                                                                      |
| send_date                    | [Dynamic date filter](#dynamic-date-filters)                                                  | Filter on the invoice send date.                                                                                                                                          |
| due_date                     | [Dynamic date filter](#dynamic-date-filters)                                                  | Filter on the invoice due date.                                                                                                                                           |
| alternative_trip_date_in     | [Linked-record filter](#linked-record-filters) + [Dynamic date filter](#dynamic-date-filters) | Filter on the linked alternative's trip start date.                                                                                                                       |
| alternative_trip_date_out    | [Linked-record filter](#linked-record-filters) + [Dynamic date filter](#dynamic-date-filters) | Filter on the linked alternative's trip end date.                                                                                                                         |

All filters are cumulative (`AND`): an invoice must match every supplied filter to be returned.

### Response

A JSON object containing the invoice information with properties like:

| Property   | Type   | Description                                                                                                                                                                                 |
| ---------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token | String | A token will be returned if all invoices have not been returned. Use it in another call to access the following invoices                                                                    |
| size       | Number | The total number of invoices available with these filters                                                                                                                                   |
| data_size  | Number | Number of invoices returned on the current page                                                                                                                                             |
| page       | Number | The page number                                                                                                                                                                             |
| invoices   | Array  | An array of JSON objects, each representing a invoice. These objects are formatted according to a simplified version of the GET `invoice` response structure. ([GET invoice](#get-invoice)) |

## GET invoice

This API endpoint retrieves detailed information about a specific invoice in Ezus.

```shell
curl --location 'https://api.ezus.app/invoice?reference=invoice_reference' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Authorization: Bearer <YOUR_TOKEN>'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.get(baseUrl + "/invoice?reference=invoice_reference", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "reference": "invoice_reference",
  "info_number": "2023_101010",
  "type": "credit_note",
  "origin_reference": "origin_reference",
  "origin_info_number": "2023_101009",
  "stage": "draft",
  "created_date": "2023-10-10",
  "send_date": "2023-10-10",
  "due_date": "2023-10-10",
  "currency": "EUR",
  "is_einvoice_ready": true,
  "amount_ttc": 1200.0,
  "amount_ht": 1000.0,
  "vat": 200.0,
  "url": "https://ezus.io/2023_101010.pdf",
  "project": {
    "reference": "project_reference",
    "info_number": "202306001-P",
    "info_title": "Paris fashion week 2024",
    "info_stage_reference": "confirmed",
    "info_stage": "Confirmed",
    "currency": "EUR",
    "is_closed": false
  },
  "alternative": {
    "sort_order": "0",
    "title": "Main Alternative",
    "trip_date_in": "2024-03-01",
    "trip_date_out": "2024-03-09",
    "trip_duration": 9
  },
  "client": {
    "reference": "client_reference",
    "type": "enterprise",
    "company_name": "MOKE INTERNATIONAL LIMITED",
    "first_name": "Jane",
    "last_name": "Doe",
    "email": "contact@moke-international.com"
  },
  "forecast": {
    "is_automatic": true,
    "purchase": 0.0,
    "commission": 0.0,
    "vat_deducted": 0.0,
    "amount_ht": 1000.0
  },
  "actual": {
    "is_automatic": true,
    "purchase": null,
    "commission": null,
    "vat_deducted": null,
    "amount_ht": null
  },
  "lines": [
    {
      "title": "Private Suite at Hôtel Ritz Paris",
      "quantity": 1,
      "price": 1200,
      "price_excl_taxes": 1000,
      "description": "Luxury private suite accommodation at Hôtel Ritz Paris including premium amenities and concierge services.",
      "tax_rate": 20,
      "tax_regime": {
        "name": "classic",
        "category": "S",
        "comment": ""
      }
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/invoice`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter | Type   | Description                                                                                        |
| --------- | ------ | -------------------------------------------------------------------------------------------------- |
| reference | String | <span class="label label-red float-right">Required</span> The reference of the invoice to retrieve |

### Response

A JSON object containing the invoice information with properties like:

| Property           | Type    | Description                                                                                                                                                                                                       |
| ------------------ | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference          | String  | The reference of the invoice                                                                                                                                                                                      |
| info_number        | String  | Title of the invoice                                                                                                                                                                                              |
| type               | String  | Type of the invoice `invoice` or `credit_note`                                                                                                                                                                    |
| origin_reference   | String  | This is only displayed if the type of the invoice is a `credit_note`. The reference of the origin invoice.                                                                                                        |
| origin_info_number | String  | This is only displayed if the type of the invoice is a `credit_note`. Title of the origin invoice.                                                                                                                |
| stage              | String  | Stage of the invoice `draft` `completed` or `paid`                                                                                                                                                                |
| created_date       | String  | Date of the creation of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                    |
| send_date          | String  | Sent date of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                               |
| due_date           | String  | Due date of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                                |
| currency           | String  | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>) |
| is_einvoice_ready  | Boolean | Is the invoice ready for e-invoicing                                                                                                                                                                              |
| amount_ttc         | Number  | Amount of the invoice including taxes                                                                                                                                                                             |
| amount_ht          | Number  | Amount of the invoice excluding taxes                                                                                                                                                                             |
| vat                | Number  | VAT amount of the invoice                                                                                                                                                                                         |
| url                | String  | URL of the invoice `.pdf` file                                                                                                                                                                                    |
| project            | JSON    | JSON including: `reference`, `info_number`, `info_title`, `info_stage_reference`, `info_stage`, `currency` and `is_closed`                                                                                        |
| alternative        | JSON    | JSON including: `sort_order`, `title`, `trip_date_in`, `trip_date_out` and `trip_duration`                                                                                                                        |
| client             | JSON    | JSON including: `reference`, `type` (enterprise or individual), `company_name`, `first_name`, `last_name` and `email`                                                                                             |
| forecast           | JSON    | JSON object forecast ([Invoices Amounts](#invoices-amounts))                                                                                                                                                      |
| actual             | JSON    | JSON object actual ([Invoices Amounts](#invoices-amounts))                                                                                                                                                        |
| lines              | Array   | Array of JSON invoices lines ([Invoices Lines](#invoices-lines))                                                                                                                                                  |

## PUT invoices-update

It updates an invoice record if the provided reference does match one of the invoices references in your account.

```shell
curl --location --request PUT 'https://api.ezus.app/invoices-update' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
    "reference": "invoice_reference",
    "stage": "paid",
    "due_date": "2023-09-29",
    "custom_fields": [
        {"name": "field_name", "value": "field_value"}
    ]
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "invoice_reference",
  stage: "paid",
  due_date: "2023-09-29",
  custom_fields: [{ name: "field_name", value: "field_value" }],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.put(baseUrl + "/invoices-update", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Invoice successfully updated",
  "reference": "invoice_reference"
}
```

### HTTP Endpoint

`PUT https://api.ezus.app/invoices-update`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter     | Type   | Description                                                                                                                                                                                                                  |
| ------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference     | String | The reference of the invoice you want to update                                                                                                                                                                              |
| stage         | String | Represents the stage of the invoice. Allowed updates: you can move from `draft` to `paid` or `completed`. Once set to paid or completed, switching between these stages is allowed. Reverting back to draft is not permitted |
| due_date      | String | due_date can be updated only if the invoice is a draft, due_date can be only on format `YYYY-MM-DD`                                                                                                                          |
| custom_fields | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

Please note that invoice finalization (the step that occurs when moving an invoice from the `draft` stage to `paid` or `completed`) can occasionally be busy if another finalization is already in progress.
In such cases, the response message will indicate that the process is busy, and the client simply needs to retry the request after a short delay.

| Property  | Type   | Description                                                                              |
| --------- | ------ | ---------------------------------------------------------------------------------------- |
| action    | String | Indicates type of invoice action was created                                             |
| reference | String | The `reference` for the invoice, which you should store for future updates or retrievals |

## GET invoices-supplier

This API endpoint retrieves a list of purchase invoices in Ezus.

```shell
curl --location 'https://api.ezus.app/invoices-supplier' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Authorization: Bearer <YOUR_TOKEN>'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.get(baseUrl + "/invoices-supplier", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "next_token": "<NEXT_TOKEN>",
  "size": 1240,
  "data_size": 50,
  "page": 1,
  "invoices-supplier": [
    {
      "reference": "invoice_supplier_reference",
      "has_attachement": true,
      "filename": "2023_101010.pdf",
      "url": "https://ezus.io/2023_101010.pdf",
      "created_date": "2023-10-10",
      "due_date": "2023-10-10",
      "send_date": "2023-10-10",
      "currency": "EUR",
      "amount_ttc": 160.0,
      "amount_ht": 120.0,
      "vat": 40.0,
      "supplier_reference": "supplier_reference",
      "project_reference": "project_reference",
      "alternative_order": "0",
      "paid": 150.0
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/invoices-supplier`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter          | Type    | Description                                                                                                                                                                                                                                                                                                                              |
| ------------------ | ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token         | String  | Specify this parameter if you want to retrieve the following elements of a given list query. If this parameter is filled, other parameters are ignored.                                                                                                                                                                                  |
| has_attachement    | Boolean | true if a file is attached (filename and url are both set), false otherwise                                                                                                                                                                                                                                                              |
| supplier_reference | String  | Filter invoices by the given supplier reference                                                                                                                                                                                                                                                                                          |
| project_reference  | String  | Filter invoices by the given project reference                                                                                                                                                                                                                                                                                           |
| alternative_order  | Number  | If <code>project_reference</code> is not provided, this parameter is ignored and the query applies to all alternatives of all projects.<br />If <code>project_reference</code> is provided, <code>alternative_order</code> must be a non-negative number: 0 targets the main alternative and the value falls back to 0 if not specified. |

### Response

A JSON object containing the invoices-supplier information with properties like:

| Property          | Type   | Description                                                                                                                                                                                                                      |
| ----------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token        | String | A token will be returned if all invoices have not been returned. Use it in another call to access the following invoices                                                                                                         |
| size              | Number | The total number of invoices available with these filters                                                                                                                                                                        |
| data_size         | Number | Number of invoices returned on the current page                                                                                                                                                                                  |
| page              | Number | The page number                                                                                                                                                                                                                  |
| invoices-supplier | Array  | An array of JSON objects, each representing an invoice-supplier. These objects are formatted according to a simplified version of the GET `invoice-supplier` response structure. ([GET invoice-supplier](#get-invoice-supplier)) |

Each `invoice-supplier` of the `invoices-supplier` list is a JSON object containing the invoice-supplier information with properties like:

| Property           | Type    | Description                                                                                                                                                                                                       |
| ------------------ | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference          | String  | The reference of the supplier invoice                                                                                                                                                                             |
| has_attachement    | Boolean | true if a file is attached (filename and url are both set), false otherwise                                                                                                                                       |
| filename           | String  | Filename of the supplier invoice                                                                                                                                                                                  |
| url                | String  | URL of the supplier invoice file                                                                                                                                                                                  |
| created_date       | String  | Date of the creation of the supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                            |
| due_date           | String  | Due date of the supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                                        |
| send_date          | String  | Sent date of the supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                                       |
| currency           | String  | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>) |
| amount_ttc         | Number  | Amount of the supplier invoice including taxes                                                                                                                                                                    |
| amount_ht          | Number  | Amount of the supplier invoice excluding taxes                                                                                                                                                                    |
| vat                | Number  | VAT amount of the supplier invoice                                                                                                                                                                                |
| supplier_reference | String  | Reference of the related supplier, or an empty string if no supplier is assigned                                                                                                                                  |
| project_reference  | String  | Reference of the related project                                                                                                                                                                                  |
| alternative_order  | Number  | Reference of the related alternative order; 0 is for main alternative                                                                                                                                             |
| paid               | Number  | Sum of the payments already made on the invoice                                                                                                                                                                   |

## GET invoice-supplier

This API endpoint retrieves detailed information about a specific purchase invoice in Ezus.

```shell
curl --location 'https://api.ezus.app/invoice-supplier?reference=invoice_supplier_reference' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Authorization: Bearer <YOUR_TOKEN>'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.get(
  baseUrl + "/invoice-supplier?reference=invoice_supplier_reference",
  headers
);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "reference": "invoice_supplier_reference",
  "has_attachement": true,
  "filename": "File Name",
  "url": "https://ezus.io/2023_101010.pdf",
  "created_date": "2023-10-10",
  "due_date": "2023-10-20",
  "send_date": "2023-10-15",
  "currency": "EUR",
  "amount_ttc": 1200.0,
  "amount_ht": 1000.0,
  "vat": 200.0,
  "supplier": {
    "reference": "supplier_reference",
    "company_name": "The best hotel",
    "website": "www.the_best_hotel.com"
  },
  "project": {
    "reference": "project_reference",
    "info_number": "202306001-P",
    "info_title": "Paris fashion week 2024",
    "info_stage_reference": "confirmed",
    "info_stage": "Confirmed",
    "currency": "EUR",
    "is_closed": false
  },
  "alternative": {
    "sort_order": "0",
    "title": "Main Alternative"
  },
  "client": {
    "reference": "client_reference",
    "type": "enterprise",
    "company_name": "MOKE INTERNATIONAL LIMITED",
    "first_name": "Jane",
    "last_name": "Doe",
    "email": "contact@moke-international.com"
  },
  "payments": [
    {
      "reference": "payment_reference",
      "date": "2023-10-10",
      "amount": 500.0,
      "payment_method": "Credit Card"
    },
    {
      "reference": "payment_reference",
      "date": "2023-10-11",
      "amount": 500.0,
      "payment_method": "Wire"
    },
    {
      "reference": "payment_reference",
      "date": "2023-10-12",
      "amount": 200.0,
      "payment_method": "Check"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/invoice-supplier`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter | Type   | Description                                                                                        |
| --------- | ------ | -------------------------------------------------------------------------------------------------- |
| reference | String | <span class="label label-red float-right">Required</span> The reference of the invoice to retrieve |

### Response

A JSON object containing the supplier invoice information with properties like:

| Property        | Type    | Description                                                                                                                                                                                                       |
| --------------- | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference       | String  | The reference of the supplier invoice                                                                                                                                                                             |
| has_attachement | Boolean | true if a file is attached (filename and url are both set), false otherwise                                                                                                                                       |
| filename        | String  | Filename of the supplier invoice                                                                                                                                                                                  |
| url             | String  | URL of the supplier invoice file                                                                                                                                                                                  |
| created_date    | String  | Date of the creation of the supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                            |
| due_date        | String  | Due date of the supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                                        |
| send_date       | String  | Sent date of the supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                                       |
| currency        | String  | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>) |
| amount_ttc      | Number  | Amount of the supplier invoice including taxes                                                                                                                                                                    |
| amount_ht       | Number  | Amount of the supplier invoice excluding taxes                                                                                                                                                                    |
| vat             | Number  | VAT amount of the supplier invoice                                                                                                                                                                                |
| supplier        | JSON    | JSON including: `reference`, `company_name` and `website`                                                                                                                                                         |
| project         | JSON    | JSON including: `reference`, `info_title`, `info_stage`, `info_stage_reference`, `info_number`, `currency` and `is_closed`                                                                                        |
| alternative     | JSON    | JSON including: `sort_order` and `title`                                                                                                                                                                          |
| client          | JSON    | JSON including: `reference`, `type` (enterprise or individual), `company_name`, `first_name`, `last_name` and `email`                                                                                             |
| payments        | Array   | Array of JSON including: `reference`, `date`, `amount` and `payment_method`                                                                                                                                       |

## POST invoices-supplier-upsert

This endpoint allows you to create or update a supplier invoice (purchase invoice) on a project.
The endpoint works in upsert mode: if the provided `reference` matches an existing, non-deleted supplier invoice of your account that belongs to the specified supplier and project, the invoice is updated. Otherwise, a new supplier invoice is created.

```shell
curl --location 'https://api.ezus.app/invoices-supplier-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "supplier_reference": "supplier_reference",
    "project_reference": "project_reference",
    "alternative_order": "0",
    "reference": "invoice_supplier_reference",
    "due_date": "2023-10-20",
    "amount_ttc": 1200.00,
    "amount_ht": 1000.00,
    "filename": "2023_101010.pdf",
    "url": "https://ezus.io/2023_101010.pdf",
    "note": "Invoice for the Paris fashion week 2024 project"
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  supplier_reference: "supplier_reference",
  project_reference: "project_reference",
  alternative_order: "0",
  reference: "invoice_supplier_reference",
  due_date: "2023-10-20",
  amount_ttc: 1200.0,
  amount_ht: 1000.0,
  filename: "2023_101010.pdf",
  url: "https://ezus.io/2023_101010.pdf",
  note: "Invoice for the Paris fashion week 2024 project",
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/invoices-supplier-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Supplier invoice successfully created",
  "reference": "invoice_supplier_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/invoices-supplier-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter          | Type   | Description                                                                                                                                                                                                            |
| ------------------ | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| supplier_reference | String | <span class="label label-red float-right">Required</span> Reference of the supplier the invoice belongs to. Must match a valid, non-deleted supplier of the specified project.                                         |
| project_reference  | String | <span class="label label-red float-right">Required</span> Reference of the project the invoice belongs to. Must match a valid, non-deleted project of your account.                                                    |
| alternative_order  | String | Alternative number. If not provided, the invoice is attached to the project's main alternative (`0`).                                                                                                                  |
| reference          | String | Unique reference of the supplier invoice to create or update. If not provided, a UUID v4 is automatically generated and returned. Must be less than 100 characters, otherwise an error is returned.                    |
| due_date           | String | Due date of the supplier invoice, in a "YYYY-MM-DD" format.                                                                                                                                                            |
| amount_ttc         | Number | Amount of the supplier invoice including taxes.                                                                                                                                                                        |
| amount_ht          | Number | Amount of the supplier invoice excluding taxes.                                                                                                                                                                        |
| filename           | String | Name associated to the invoice file (PDF). Optional. If left empty while `url` is provided, the filename is deduced from the downloaded file.                                                                          |
| url                | String | Link to the invoice file. Only `.pdf` files are accepted. Required if `filename` is provided, otherwise an error is returned. If provided while `filename` is empty, the filename is deduced from the downloaded file. |
| note               | String | Note attached to the supplier invoice.                                                                                                                                                                                 |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                                                                            |
| --------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------- |
| action    | String | Summary of the action performed (e.g., "Supplier invoice successfully created" or "Supplier invoice successfully updated")             |
| reference | String | Reference of the supplier invoice that was created or updated (the auto-generated UUID on insert, or the provided reference otherwise) |

### Currency

<aside class="notice">In V1, multi-currency is not managed for supplier invoices.</aside>

- The currency of the supplier invoice is the currency of the project it is inserted into (V1).
- If the supplier (`project_supplier`) has a currency different from the project's currency, an error is returned (this case is not handled in V1).

## POST invoices-supplier-payments-create

This endpoint allows you to create a payment attached to an existing supplier invoice (purchase invoice).
The endpoint works in creation mode only: payments cannot be updated or deleted through the public API. If the provided `reference` is already used by a payment of your account, an error is returned.

```shell
curl --location 'https://api.ezus.app/invoices-supplier-payments-create' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "invoice_supplier_reference": "invoice_supplier_reference",
    "reference": "payment_reference",
    "date": "2026-05-28",
    "amount": 600.00,
    "payment_method": "default4"
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  invoice_supplier_reference: "invoice_supplier_reference",
  reference: "payment_reference",
  date: "2026-05-28",
  amount: 600.0,
  payment_method: "default4",
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/invoices-supplier-payments-create", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Supplier invoice payment successfully created",
  "reference": "payment_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/invoices-supplier-payments-create`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter                  | Type   | Description                                                                                                                                                                                                                                                                                                     |
| -------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| invoice_supplier_reference | String | <span class="label label-red float-right">Required</span> Reference of the supplier invoice the payment is attached to. Must match a valid, non-deleted supplier invoice of your account, otherwise an error is returned.                                                                                       |
| reference                  | String | Unique reference of the payment to create. If not provided, a UUID v4 is automatically generated and returned. Must be less than 36 characters and not already used by a payment of your account, otherwise an error is returned.                                                                               |
| date                       | String | <span class="label label-red float-right">Required</span> Date of the payment, in a "YYYY-MM-DD" format. Must be a date between years 2000 and 2050 (exclusive), otherwise an error is returned.                                                                                                                |
| amount                     | Number | <span class="label label-red float-right">Required</span> Amount of the payment. The value is rounded to 2 decimals before being stored. If the provided value is not a number, an error is returned.                                                                                                           |
| payment_method             | String | Technical name of the payment method (e.g. "default4"). If the provided value does not match any payment method of your account, an error is returned and nothing is created. If not provided, the account's default payment method is used; if the account don't have one, the payment is created without one. |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                                                        |
| --------- | ------ | ------------------------------------------------------------------------------------------------------------------ |
| action    | String | Summary of the action performed (e.g., "Supplier invoice payment successfully created")                            |
| reference | String | Reference of the payment that was created (the auto-generated UUID on insert, or the provided reference otherwise) |
