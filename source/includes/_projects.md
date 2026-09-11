# Projects

## GET projects

Returns a list of your projects, sorted from the most recent to the oldest, with the newest projects appearing first. The list of projects returned is paginated (50 per 50): to call the 50 next items in the list, call the route with the `next_token` query parameter.

```shell
curl --location 'https://api.ezus.app/projects' \
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

axios.get(baseUrl + "/projects", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "next_token": "<NEXT_TOKEN>",
  "size": 338,
  "data_size": 50,
  "page": 1,
  "projects": [
    {
      "reference": "project_reference",
      "info_number": "202306001-P",
      "info_title": "Paris fashion week 2024",
      "info_stage_reference": "confirmed",
      "info_stage": "Confirmed",
      "info_notes": "Jane has verbally confirmed our quotation",
      "trip_date_in": "2024-03-01",
      "trip_date_out": "2024-03-09",
      "trip_duration": 8,
      "currency": "€",
      "created_at": "2024-06-18",
      "updated_at": "2024-06-19",
      "sales_manager": {
        "email": "travel-design@e-corp.com",
        "first_name": "Alice",
        "last_name": "Tate",
        "agency": "Paris Agency"
      },
      "project_manager": {
        "email": "no-reply@e-corp.com",
        "first_name": "Joe",
        "last_name": "Shmoe",
        "agency": "Paris Agency"
      }
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/projects`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter             | Type    | Description                                                                                                                                                                                        |
| --------------------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token            | String  | Specify this parameter if you want to retrieve the following elements of a given list query                                                                                                        |
| info_stage_reference  | String  | You can filter projects that are in a specific stage. The stage of the project must be indicated by its technical name                                                                             |
| trip_date_in          | Date    | You can filter projects assigned to a specific or an intersection of trip start date. Expected format: “YYYY-MM-DD” or “YYYY-MM-DD,YYYY-MM-DD”. See [Date Format](#date-format) for more details.  |
| trip_date_out         | Date    | You can filter projects assigned to a specific or an intersection of trip end date. Expected format: “YYYY-MM-DD” or “YYYY-MM-DD,YYYY-MM-DD”. See [Date Format](#date-format) for more details.    |
| created_at            | Date    | You can filter projects assigned to a specific or an intersection of creation date. Expected format: “YYYY-MM-DD” or “YYYY-MM-DD,YYYY-MM-DD”. See [Date Format](#date-format) for more details.    |
| updated_at            | Date    | You can filter projects assigned to a specific or an intersection of last update date. Expected format: “YYYY-MM-DD” or “YYYY-MM-DD,YYYY-MM-DD”. See [Date Format](#date-format) for more details. |
| sales_manager         | String  | Provide either the sales manager's email address or "None". Expected format: "john.doe@e-corp.com" or "None".                                                                                      |
| project_manager       | String  | Provide either the project manager's email address or "None". Expected format: "john.doe@e-corp.com" or "None".                                                                                    |
| from_programs_catalog | Boolean | Optional. Defaults to false. When set to true, retrieves all projects from the programs catalog.                                                                                                   |

### Response

A JSON object containing the project information with properties like:

| Property   | Type   | Description                                                                                                                                                                                                                                                                                                                          |
| ---------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| next_token | String | A token will be returned if all projects have not been returned. Use it in another call to access the following projects                                                                                                                                                                                                             |
| size       | Number | The total number of projects available with these filters                                                                                                                                                                                                                                                                            |
| data_size  | Number | Number of projects returned on the current page                                                                                                                                                                                                                                                                                      |
| page       | Number | The page number                                                                                                                                                                                                                                                                                                                      |
| projects   | Array  | An array of JSON objects, each representing a project. Each object follows the [GET project](#get-project) response structure, with two differences: the `alternatives` and `custom_fields` arrays are omitted ; the main alternative's `trip_date_in`, `trip_date_out`, `trip_duration` are returned directly at the project level. |

## GET project

This API endpoint retrieves detailed information about a specific project in Ezus.

```shell
curl --location 'https://api.ezus.app/project?reference=project_reference' \
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

axios.get(baseUrl + "/project?reference=project_reference", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "reference": "project_reference",
  "info_number": "202306001-P",
  "info_title": "Paris fashion week 2024",
  "info_stage_reference": "confirmed",
  "info_stage": "Confirmed",
  "info_notes": "Jane has verbally confirmed our quotation",
  "currency": "€",
  "created_at": "2024-06-18",
  "updated_at": "2024-06-19",
  "sales_manager": {
    "email": "travel-design@e-corp.com",
    "first_name": "Alice",
    "last_name": "Tate",
    "agency": "Paris Agency"
  },
  "project_manager": {
    "email": "no-reply@e-corp.com",
    "first_name": "Joe",
    "last_name": "Shmoe",
    "agency": "Paris Agency"
  },
  "alternatives": [
    {
      "reference": "550e8400-e29b-41d4-a716-446655440000",
      "alternative_title": "Main Alternative",
      "lang": "fr-FR",
      "is_main": true,
      "trip_date_in": "2024-03-01",
      "trip_date_out": "2024-03-09",
      "trip_duration": 9,      
      "trip_people": "15",
      "trip_destination_reference": "destination_reference",
      "trip_destination": "France",
      "trip_subdestination_reference ": "subdestination_reference",
      "trip_subdestination": "Paris",
      "trip_budget": 90000,
      "budget_actual": 88750,
      "budget_actual_excl_taxes ": 77950,
      "budget_margin_gross": 2500,
      "budget_margin_net": 1000,
      "budget_purchases": 74500,
      "financial_invoiced": 48000,
      "financial_collected": 48000,
      "financial_purchases": 72820,
      "financial_spendings": 12820,
      "destinations": {
        "size": 3,
        "data": [
          {
            "reference": "destination_reference",
            "name": "France",
            "subdestination_reference": "subdestination_reference",
            "subdestination_name": "Paris"
          },
          {
            "reference": "destination_reference",
            "name": "France",
            "subdestination_reference": "subdestination_reference1-2",
            "subdestination_name": "Lyon"
          },
          {
            "reference": "destination_reference2",
            "name": "Italy",
            "subdestination_reference": "subdestination_reference2-1",
            "subdestination_name": "Milan"
          }
        ]
      },
      "client": {
        "reference": "client_reference",
        "type": "enterprise",
        "company_name": "MOKE INTERNATIONAL LIMITED",
        "first_name": "Jane",
        "last_name": "Doe",
        "email": "contact@moke-international.com"
      },
      "client_space": {
        "is_live": true,
        "url": "https://custom-domain.com/your-space-slug",
        "description": "Description of the client space",
        "image_url": "https://image.jpg"
      },
      "brand": {
        "title": "INTERNATIONAL LIMITED",
        "company_name": "MOKE INTERNATIONAL LIMITED",
        "address": {
          "label": "58 Rue de Paradis",
          "city": "Paris",
          "country": "France",
          "zip": "75010"
        },
        "email": "travel-design@e-corp.com",
        "phone": "0101010101",
        "website": "www.moke_ltd.com",
        "vat_number": "GB 240-635-038",
        "company_number": "09728676"
      }
    }
  ],
  "custom_fields": [
    {
      "name": "CustomField",
      "value": "Value"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/project`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter | Type   | Description                                                                                        |
| --------- | ------ | -------------------------------------------------------------------------------------------------- |
| reference | String | <span class="label label-red float-right">Required</span> The reference of the project to retrieve |

### Response

A JSON object containing the project information with properties like:

| Property             | Type   | Description                                                                       |
| -------------------- | ------ | --------------------------------------------------------------------------------- |
| reference            | String | The reference of the project                                                      |
| info_number          | String | File number that appears in the project record. Not to be confused with reference |
| info_title           | String | The title of the project                                                          |
| info_stage_reference | String | Technical name of the stage of the project (confirmed, received, paid...)         |
| info_stage           | String | The stage of the project (Confirmed, Received, Paid...)                           |
| info_notes           | String | Notes on the project                                                              |
| currency             | String | Default currency of the project                                                   |
| created_at           | Date   | Date of creation                                                                  |
| updated_at           | Date   | Date of the last update                                                           |
| sales_manager        | JSON   | JSON object representing the sales manager ([User](#user))                        |
| project_manager      | JSON   | JSON object representing the project manager ([User](#user))                      |
| alternatives         | Array  | Array of JSON alternatives ([Alternatives](#alternatives))                        |
| custom_fields        | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                     |

## GET project-documents

Returns the list of documents of your project, sorted from the most recent to the oldest.

```shell
curl --location 'https://api.ezus.app/project-documents?reference=project_reference' \
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

axios.get(baseUrl + "/project-documents?reference=project_reference", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "reference": "project_reference",
  "alternative_order": "0",
  "documents": [
    {
      "type": "custom",
      "title": "documentName",
      "url": "https://ezus.io/2023_101010.pdf"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/project-documents`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter         | Type   | Description                                                                                                                    |
| ----------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------ |
| reference         | String | <span class="label label-red float-right">Required</span> The reference of the project to retrieve documents from              |
| alternative_order | Number | Specifies the alternative order in the project to retrieve documents from. If not provided, defaults to 0 for main alternative |

### Response

A JSON object containing the project documents information with properties like:

| Property          | Type   | Description                                                                                                                                                                                                                       |
| ----------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference         | String | The reference of the project                                                                                                                                                                                                      |
| alternative_order | Number | The alternative order; 0 is for main alternative                                                                                                                                                                                  |
| documents         | Array  | An array of JSON objects, each representing a document. The documents are sorted by their creation date, with the most recently created appearing first. Each document includes the following fields: `type`, `title`, and `url`. |

## GET project-steps

Returns the list of steps of your project, sorted from the most recent to the oldest.

```shell
curl --location 'https://api.ezus.app/project-steps?reference=project_reference' \
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

axios.get(baseUrl + "/project-steps?reference=project_reference", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "next_token": "<NEXT_TOKEN>",
  "reference": "project_reference",
  "alternative_order": "0",
  "size": 1,
  "data_size": 1,
  "page": 1,
  "steps": [
    {
      "reference": "activity_reference",
      "type": "activity",
      "name": "activityTitle",
      "category": "restaurant",
      "date_start": "2024-10-01 10:00:00",
      "date_end": "2024-10-01 12:00:00",
      "people": 4,
      "address": {
        "label": "58 Rue de Paradis",
        "city": "Paris",
        "country": "France",
        "zip": "75010",
        "geo": {
          "x": 48.875761,
          "y": 2.348727
        }
      },
      "description": {
        "short": "Short description of the activity",
        "long": "Long description of the activity"
      },
      "items": [
        {
          "reference": "item_reference",
          "name": "item_title",
          "product_reference": "product_reference",
          "supplier_reference": "supplier_reference",
          "quantity": 2,
          "purchase_price": 150,
          "purchase_price_excl_taxes": 125,
          "sales_price": 200,
          "sales_price_excl_taxes": 166.67,
          "is_optional": false,
          "notes": "Notes about the item",
          "booked": false
        }
      ],
      "medias": ["https://image.jpg", "https://image2.jpg"],
      "custom_fields": [
        {
          "name": "CustomField",
          "value": "Value"
        }
      ]
    }
  ],
  "supplements": {
    "fees": [
      {
        "reference": "fee_reference",
        "label": "Main fee",
        "mode": "flat",
        "value": 2000,
        "amount": 2000,
        "amount_excl_taxes": 1666.67,
        "notes": "Some notes"
      }
    ],
    "discounts": [
      {
        "reference": "discount_reference",
        "label": "Main discount",
        "mode": "percentage",
        "value": 10,
        "amount": 1000,
        "amount_excl_taxes": 833.33,
        "notes": "Some notes"
      }
    ]
  }
}
```

### HTTP Endpoint

`GET https://api.ezus.app/project-steps`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter          | Type    | Description                                                                                                                                      |
| ------------------ | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| reference          | String  | <span class="label label-red float-right">Required</span> The reference of the project to retrieve documents from                                |
| alternative_order  | Number  | Specifies the alternative order in the project to retrieve documents from. If not provided, defaults to 0 for main alternative                   |
| from_steps_catalog | Boolean | Optional. Defaults to false. When set to true, retrieves all the sample steps and overrides the reference and alternative_order query parameters |

### Response

A JSON object containing the project documents information with properties like:

| Property          | Type   | Description                                                                                                               |
| ----------------- | ------ | ------------------------------------------------------------------------------------------------------------------------- |
| next_token        | String | A token will be returned if all project steps have not been returned. Use it in another call to access the following ones |
| reference         | String | The reference of the project                                                                                              |
| alternative_order | Number | The alternative order; 0 is for main alternative                                                                          |
| size              | Number | The total number of projects available with these filters                                                                 |
| data_size         | Number | Number of projects returned on the current page                                                                           |
| page              | Number | The page number                                                                                                           |
| steps             | Array  | Array of JSON steps ([Steps](#steps))                                                                                     |
| supplements       | JSON   | JSON object containing the fees and discounts supplements of the project ([Supplements](#supplements))                    |

## GET project-travellers

Returns the list of travellers in your project.

```shell
curl --location 'https://api.ezus.app/project-travellers?reference=project_reference' \
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

axios.get(baseUrl + "/project-travellers?reference=project_reference", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "reference": "project_reference",
  "alternative_order": 0,
  "size": "2",
  "travellers": [
    {
      "email": "emily.johnson@example.com",
      "first_name": "Emily",
      "last_name": "Johnson",
      "phone": "+1-555-123-4567",
      "custom_field1": "value1.1",
      "custom_field2": "value2.1"
    },
    {
      "email": "michael.smith@example.com",
      "first_name": "Michael",
      "last_name": "Smith",
      "phone": "+1-555-987-6543",
      "custom_field1": "value1.2",
      "custom_field2": "value2.2"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/project-travellers`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter         | Type   | Description                                                                                                                     |
| ----------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------- |
| reference         | String | <span class="label label-red float-right">Required</span> The reference of the project to retrieve travellers from              |
| alternative_order | Number | Specifies the alternative order in the project to retrieve travellers from. If not provided, defaults to 0 for main alternative |

### Response

A JSON object containing the project travellers information with properties like:

| Property          | Type   | Description                                          |
| ----------------- | ------ | ---------------------------------------------------- |
| reference         | String | The reference of the project                         |
| alternative_order | Number | The alternative order; 0 is for main alternative     |
| size              | Number | Total travellers in the project                      |
| travellers        | Array  | Array of JSON travellers ([Travellers](#travellers)) |

## POST projects-upsert

This API endpoint can create, duplicate, or update a project. If the provided `reference` matches an existing project, that project is updated. If no match is found, a new project is created using the provided `reference`, or a randomly generated one if none is supplied and `project_reference` is not provided. When `project_reference` is specified, a new project is created by duplicating the existing project identified by `project_reference` with the provided `reference` or a random one.

```shell
curl --location 'https://api.ezus.app/projects-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
    "reference": "project_reference",
    "project_reference": "project_type_reference",
    "info_number": "202306001-P",
    "info_title": "Paris fashion week 2024",
    "info_stage_reference": "received",
    "trip_date_in": "2023-03-01",
    "trip_date_out": "2023-03-09",
    "trip_budget": "90000",
    "trip_people": "15",
    "sales_manager_email": "travel-design@e-corp.com",
    "client_reference": "client_reference",
    "trip_destination_reference": "destination_reference",
    "trip_subdestination_reference": "subdestination_reference",
    "custom_fields": [
        {"name": "field_name", "value": "field_value" }
    ]
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "project_reference",
  project_reference: "project_type_reference",
  info_number: "202306001-P",
  info_title: "Paris fashion week 2024",
  info_stage_reference: "received",
  trip_date_in: "2023-03-01",
  trip_date_out: "2023-03-09",
  trip_budget: "90000",
  trip_people: "15",
  sales_manager_email: "travel-design@e-corp.com",
  client_reference: "client_reference",
  trip_destination_reference: "destination_reference",
  trip_subdestination_reference: "subdestination_reference",
  custom_fields: [{ name: "field_name", value: "field_value" }],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/projects-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Project successfully created",
  "reference": "project_reference",
  "info_number": "202306001-P",
  "client_reference": "client_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/projects-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter                     | Type   | Description                                                                                                                                                                                                                                                                                                                                                                                                      |
| ----------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference                     | String | If provided, the unique reference associated with the project you want to update or create (or a random one will be generated).                                                                                                                                                                                                                                                                                  |
| project_reference             | String | If provided, the `project_reference` is used to duplicate an existing project. For the duplication to succeed, the `reference` field must not match any existing project. If the `info_number`, `info_title`, `info_stage_reference`, `trip_budget`, `trip_people`, `sales_manager_email` and `client_reference` fields are filled in, they are used. The fields `trip_date_in` and `trip_date_out` are skipped. |
| info_number                   | String | File number that appears in the project record. Not to be confused with reference                                                                                                                                                                                                                                                                                                                                |
| info_title                    | String | Title of the project. This parameter is required if you create a new project                                                                                                                                                                                                                                                                                                                                     |
| info_stage_reference          | String | Stage of the project: Please use the technical name of the stage you intend to apply. If no specific stage is found, a default stage will be automatically assigned upon adding the project.                                                                                                                                                                                                                     |
| trip_date_in                  | Date   | Date of the project's start in "YYYY-MM-DD" format (only settable when creating a new project). If not provided or if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1 day and trip_date_in as today.                                                                                                                                              |
| trip_date_out                 | Date   | Date of the project's end in "YYYY-MM-DD" format (only settable when creating a new project). If not provided or if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1 day and trip_date_out as today.                                                                                                                                               |
| trip_budget                   | Number | Forecasted budget for the project                                                                                                                                                                                                                                                                                                                                                                                |
| trip_people                   | Number | Number of people in the project (only settable when creating a new project)                                                                                                                                                                                                                                                                                                                                      |
| sales_manager_email           | Email  | Email of the Ezus user to be set as the sales manager of the project                                                                                                                                                                                                                                                                                                                                             |
| client_reference              | String | Reference or email of an existing client in your Ezus account to link to the project (only settable when creating a new project)                                                                                                                                                                                                                                                                                 |
| trip_destination_reference    | String | Reference of the destination to link to the project. To reset the destination, you can put `'0'`.                                                                                                                                                                                                                                                                                                                |
| trip_subdestination_reference | String | Reference of the sub-destination to link to the project. To reset the sub-destination, you can put `'0'`. If the `trip_destination_reference` is not provided, the `trip_subdestination_reference` will be ignored.                                                                                                                                                                                              |
| custom_fields                 | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                                                                                                                                                                                                    |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property         | Type   | Description                                                                              |
| ---------------- | ------ | ---------------------------------------------------------------------------------------- |
| action           | String | Indicates type of project action was created                                             |
| reference        | String | The `reference` for the project, which you should store for future updates or retrievals |
| info_number      | String | File number that appears in the project record. Not to be confused with reference        |
| client_reference | String | The `reference` for the client, which you should store for future updates or retrievals  |

## POST project-documents-create

This API endpoint generates a PDF document from a given link within the specified project.

```shell
curl --location 'https://api.ezus.app/project-documents-create' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "project_reference": "project_reference",
    "title": "Document PDF",
    "link": "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  project_reference: "project_reference",
  title: "Document PDF",
  result:
    "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/project-documents-create", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "result": "<LINK>"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/project-documents-create`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter         | Type   | Description                                                                                                                              |
| ----------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------- |
| project_reference | String | <span class="label label-red float-right">Required</span> The project reference in which you want to create a document                   |
| title             | String | Title of the document                                                                                                                    |
| link              | Link   | <span class="label label-red float-right">Required</span> URL of the document (only supports PDF format and must be publicly accessible) |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property | Type | Description                                               |
| -------- | ---- | --------------------------------------------------------- |
| result   | Link | The URL link of the document after uploading the document |

## POST project-steps-upsert

This endpoint updates an existing step when the provided reference matches a step in your account. If no match is found, a new step is created using the provided reference, or a randomly generated one if none is supplied. Note that the following fields are used only during creation and are ignored on update: `project_reference`, `alternative_order`, `type`, `date_start`, `date_end`.

Use the field `from_steps_catalog` to update an existing sample step when the provided reference matches a sample step in your account. If no match is found, a new sample step is created using the provided reference, or a randomly generated one if none is supplied.
Note that the dates provided are not stored as they are, but are normalised to January 1950. The delta between `date_end` and `date_start` must not exceed the number of days in the sample steps catalog. Dates can only be modified if both `date_start` and `date_end` are specified. Note that the following fields are ignored during creation and update: `project_reference`, `alternative_order`, `description`. Note that the following fields are used only during creation and are ignored on update: `type`.

```shell
curl --location 'https://api.ezus.app/project-steps-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "from_steps_catalog": false,
    "reference": "project_step_reference",
    "project_reference": "project_reference",
    "alternative_order": "0",
    "name": "activity Title",
    "type": "activity",
    "category": "restaurant",
    "people": "4",
    "date_start": "2025-10-03 10:00:00",
    "date_end": "2025-10-03 12:00:00",
    "address": {
        "label": "58 Rue de Paradis",
        "city": "Paris",
        "country": "France",
        "zip": "75010",
        "geo": {
            "x": 48.875761,
            "y": 2.348727
        }
    },
    "description": {
      "short": "Short description of the activity",
      "long": "Long description of the activity"
    },
    "custom_fields": [
      {"name": "field_name", "value": "field_value"}
    ]
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  from_steps_catalog: false,
  reference: "project_step_reference",
  project_reference: "project_reference",
  alternative_order: "0",
  name: "activity Title",
  type: "activity",
  category: "restaurant",
  people: "4",
  date_start: "2025-10-03 10:00:00",
  date_end: "2025-10-03 12:00:00",
  address: {
    label: "58 Rue de Paradis",
    city: "Paris",
    country: "France",
    zip: "75010",
    geo: {
      x: 48.875761,
      y: 2.348727,
    },
  },
  description: {
    short: "Short description of the activity",
    long: "Long description of the activity",
  },
  custom_fields: [{ name: "field_name", value: "field_value" }],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/project-steps-upsert", body, headers);
```

```shell
curl --location 'https://api.ezus.app/project-steps-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "from_steps_catalog": true,
    "reference": "project_sample_step_reference",
    "name": "activity Title",
    "type": "activity",
    "category": "restaurant",
    "people": "4",
    "date_start": "2025-10-03 10:00:00",
    "date_end": "2025-10-03 12:00:00",
    "address": {
        "label": "58 Rue de Paradis",
        "city": "Paris",
        "country": "France",
        "zip": "75010",
        "geo": {
            "x": 48.875761,
            "y": 2.348727
        }
    },
    "custom_fields": [
      {"name": "field_name", "value": "field_value"}
    ]
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  from_steps_catalog: true,
  reference: "project_sample_step_reference",
  name: "activity Title",
  type: "activity",
  category: "restaurant",
  people: "4",
  date_start: "2025-10-03 10:00:00",
  date_end: "2025-10-03 12:00:00",
  address: {
    label: "58 Rue de Paradis",
    city: "Paris",
    country: "France",
    zip: "75010",
    geo: {
      x: 48.875761,
      y: 2.348727,
    },
  },
  custom_fields: [{ name: "field_name", value: "field_value" }],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/project-steps-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Project step successfully created",
  "reference": "project_step_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/project-steps-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter          | Type    | Description                                                                                                                                                                                                                                                                                                                                   |
| ------------------ | ------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| from_steps_catalog | Boolean | Optional. Default to false. When set to true, create or update sample step from catalog.                                                                                                                                                                                                                                                      |
| reference          | String  | If provided, the unique reference associated to the step you want to update. If you specify a reference during creation, this value will be used as the step reference. It must be a maximum of 64 characters.                                                                                                                                |
| project_reference  | String  | The project reference in which you want to create an step. This field is ignored during update or when using the `from_steps_catalog` field.                                                                                                                                                                                                  |
| alternative_order  | String  | Specifies the alternative project order from which to create or update the step. If not provided, defaults to `0` for main alternative. This field is required to create a step. This field is ignored during update or when using the `from_steps_catalog` field.                                                                            |
| name               | String  | Title of the step. This field is required to create a step. This field is optional on update.                                                                                                                                                                                                                                                 |
| type               | String  | Three options exist: `accom`, `activity`, `transport`. This field is required to create a step. This field is ignored on update.                                                                                                                                                                                                              |
| category           | String  | Category of the step. You must provide the technical name of the category. If not specified during creation, the default value will be the main category of the account.                                                                                                                                                                      |
| people             | String  | Number of people in the activity. You can use a `number` or `P`. If not specified during creation, `P` will be used as the default value. `P` represents the number of people in the project.                                                                                                                                                 |
| date_start         | String  | Start date and time of the step. Must be within the dates of the alternative where the step is created. This field is required to create a step. This field is ignored on step update. This field can be completed when updating a sample step, but both dates are required. The date format must be as follows, e.g.: `2024-10-01 12:00:00`. |
| date_end           | String  | End date and time of the step. Must be within the dates of the alternative where the step is created. This field is required to create a step. This field is ignored on step update. This field can be completed when updating the sample step, but both dates are required. The date format must be as follows, e.g.: `2024-10-01 12:00:00`. |
| address            | Object  | JSON object address ([Address](#address))                                                                                                                                                                                                                                                                                                     |
| description        | JSON    | JSON object representing the short and long description of the step. This field is ignored for sample steps.                                                                                                                                                                                                                                  |
| custom_fields      | Array   | An array of JSON custom fields ([Custom fields](#custom-fields)) for the step.                                                                                                                                                                                                                                                                |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                               |
| --------- | ------ | --------------------------------------------------------- |
| action    | String | If the project has been updated and created               |
| reference | String | The reference of the activity that was created or updated |

## POST project-steps-items-upsert

This endpoint allows you to create or update multiple items within project step(s) in batch mode (maximum 100 items per request).
The endpoint works in upsert mode: if the provided `reference` matches an existing item in your account and belongs to the specified step, the item is updated. Otherwise, a new item is created.

```shell
curl --location 'https://api.ezus.app/project-steps-items-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '[
    {
        "project_step_reference": "project_step_reference",
        "name": "item_creation_minimal"
    },
    {
        "project_step_reference": "project_step_reference",
        "reference": "item_reference",
        "product_reference": "product_reference",
        "name": "item_update_maximal",
        "quantity": 2,
        "currency": "USD",
        "purchase_price": 150,
        "sales_price": 200,
        "vat_rate": 20,
        "vat_regime": "classic"
    }
]'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = [
  {
    project_step_reference: "project_step_reference",
    name: "item_creation_minimal",
  },
  {
    project_step_reference: "project_step_reference",
    reference: "item_reference",
    product_reference: "product_reference",
    name: "item_update_maximal",
    quantity: 2,
    currency: "USD",
    purchase_price: 150,
    sales_price: 200,
    vat_rate: 20,
    vat_regime: "classic",
  },
];
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/project-steps-items-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "1 item successfully created ; 1 item successfully updated",
  "references": ["project_step_item_reference", "item_reference"]
}
```

> Error response example:

```json
{
  "error": "true",
  "message": "Invalid input detected: item[0].'vat_regime'. It must be classic, margin or none. The operation could not be processed due to this error"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/project-steps-items-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

The request body must be an array of item objects (maximum 100 items).

| Parameter              | Type   | Description                                                                                                                                                                                                                                                                                                          |
| ---------------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| project_step_reference | String | <span class="label label-red float-right">Required</span> The project step reference in which you want to create or update an item. Must match a valid, non-deleted step belonging to your account.                                                                                                                  |
| reference              | String | If provided, the unique reference associated to the item you want to update. If you specify a reference during creation, this value will be used as the item reference (max 64 characters). If not provided, a UUID v4 is automatically generated.                                                                   |
| product_reference      | String | Reference of the product to link to the item. This field is optional. If provided, it must match a valid product reference in your account. When linking a product to your item, it will inherit its name, quantity, currency, purchase_price, sales_price, vat_rate and vat_regime by default on the creation only. |
| name                   | String | Title of the item. Cannot be empty. This field is required to create an item if the product_reference is not provided. This field is optional on update.                                                                                                                                                             |
| quantity               | Number | Quantity of the item. Default value on creation: `1`. If this item is linked to a product, it will trigger a tariff recalculation based on the product's pricing rules.                                                                                                                                              |
| currency               | String | Currency ISO code (e.g., `USD`, `EUR`). Default value on creation: the project's sales currency. Must be present in the project's currencies else it will throw an error.                                                                                                                                            |
| purchase_price         | Number | The unit purchase price of the item (including taxes). Default value on creation: `0`. See [Price behavior](#price-behavior) for more details.                                                                                                                                                                       |
| sales_price            | Number | The unit sales price of the item (including taxes). Default value on creation: `0`. See [Price behavior](#price-behavior) for more details.                                                                                                                                                                          |
| vat_rate               | Number | VAT rate in percentage (e.g., `20` for 20%). Default value on creation: the project's `vat_rate`.                                                                                                                                                                                                                    |
| vat_regime             | String | VAT regime: `classic`, `margin`, or `none`. Default value on creation: the project's VAT regime.                                                                                                                                                                                                                     |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property   | Type   | Description                                                                                                            |
| ---------- | ------ | ---------------------------------------------------------------------------------------------------------------------- |
| action     | String | Summary of actions performed (e.g., "1 item successfully created ; 1 item successfully updated")                       |
| references | Array  | List of references of the items that were created or updated (UUIDs for auto-generated, provided references otherwise) |

### Price behavior

When creating an item here are the following rules that will apply if the project is in "Per product" calculation mode:

- If neither `purchase_price` nor `sales_price` is provided on INSERT: `purchase_price` = `sales_price` = `0`
- If `purchase_price` is provided but `sales_price` is not on INSERT: `sales_price` = `purchase_price`
- If `sales_price` is provided but `purchase_price` is not on INSERT: `purchase_price` = `sales_price`

For project in "Global" calculation mode:

- If no price is provided on INSERT: `sales_price` = `purchase_price` = `0`
- If `sales_price` provided and `purchase_price` not provided (INSERT or UPDATE): `purchase_price` = `sales_price`
- If `purchase_price` provided and `sales_price` not provided (INSERT or UPDATE): `sales_price` = `purchase_price`
- If both `purchase_price` and `sales_price` are provided (INSERT or UPDATE): `sales_price` takes priority, `purchase_price` = `sales_price`

## POST project-travellers-create

Creates travellers for a project.

This endpoint replaces all existing travellers for the selected project alternative.  
 If the project already has travellers, they will be **deleted and replaced** by the travellers provided in this request.

**Note:** When creating travellers with custom fields, only custom fields of type `text` are currently supported.

**Note:** Travellers can only be created if the project's defined number of travelers is greater than or equal to the number of travellers provided in the request. If the input exceeds the project's traveler count, the request will be rejected.

```shell
curl --location 'https://api.ezus.app/project-travellers-create' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "reference": "project_reference",
    "alternative_order": 0,
    "travellers": [
      {
        "email": "emily.johnson@example.com",
        "first_name": "Emily",
        "last_name": "Johnson",
        "phone": "+1-555-123-4567",
        "custom_field1": "value1.1",
        "custom_field2": "value2.1"
      }
    ]
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "project_reference",
  alternative_order: 0,
  travellers: [
    {
      email: "emily.johnson@example.com",
      first_name: "Emily",
      last_name: "Johnson",
      phone: "+1-555-123-4567",
      custom_field1: "value1.1",
      custom_field2: "value2.1",
    },
  ],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/project-travellers-create", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Travellers successfully created"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/project-travellers-create`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter         | Type   | Description                                                                                                                   |
| ----------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------- |
| reference         | String | <span class="label label-red float-right">Required</span> The project reference in which you want to create travellers        |
| alternative_order | Number | Specifies the alternative order in the project to create travellers from. If not provided, defaults to 0 for main alternative |
| travellers        | Array  | Array of JSON travellers ([Travellers](#travellers))                                                                          |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property | Type   | Description                         |
| -------- | ------ | ----------------------------------- |
| action   | String | If the travellers have been created |
