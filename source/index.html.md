---
title: Ezus API Reference

language_tabs: # must be one of https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers
  - shell: cURL
  - javascript

toc_footers:
  - <a href='https://ezus.io/' target="_blank">Documentation Powered by Ezus</a>

includes:
  - warnings
  - errors

search: true

code_clipboard: true

meta:
  - name: description
    content: Documentation for the Ezus API
---

# Introduction

Welcome to the Ezus API. Our API follows <a href='https://en.wikipedia.org/wiki/Representational_state_transfer' target="_blank">REST</a> principles, offering a set of HTTP methods that serve as the foundation for Ezus' core functionalities. Its primary purpose is to empower you to programmatically manage your Ezus projects, clients, catalog (suppliers, products, packages), and invoices.

If you're seeking an overview of common use cases achievable through our API, feel free to explore our help center's <a href='https://help.ezus.io/en/collections/3016686-integrations' target="_blank">Integrations</a> section for valuable insights.

For those ready to delve into the details of available methods, you're in the right place. This documentation presents a technical reference for each method in the left-hand section, complemented by code examples in the right-hand section.

While each method possesses its unique specifications, here are some general guidelines:

For any request, you must provide <a href='https://swagger.io/docs/specification/describing-parameters/#header-parameters' target="_blank">Header Parameters</a>

For GET requests, ensure you also provide the required <a href='https://swagger.io/docs/specification/describing-parameters/#query-parameters' target="_blank">query parameters</a>

For POST/PUT/DELETE requests, structure your request's <a href='https://swagger.io/docs/specification/2-0/describing-request-body' target="_blank">body parameters</a> in JSON format (application/json)

<aside class="warning">
Quick tip: You can <a href="./ezus_api_postman.json?attachmentlinks=true"  target="_blank" download>download here</a> a Postman export of this API
</aside>

# Authentication

## Principles

Ezus API employs a robust authentication scheme that leverages <a href='https://swagger.io/docs/specification/authentication/api-keys/' target="_blank">API Keys</a> and <a href='https://swagger.io/docs/specification/authentication/bearer-authentication/' target="_blank">Bearer authentication</a>. To interact with the Ezus API effectively, you'll need two crucial elements:

- An Ezus API key
- User credentials for an active Ezus account

<span style="text-decoration:underline">API key</span>

Ezus uses API keys to control access to its API. To obtain your `<YOUR_API_KEY>`, kindly request it from your account manager. Every request you make to the Ezus API must include this API key as the `x-api-key` header parameter, like so:

`x-api-key: <YOUR_API_KEY>`

<span style="text-decoration:underline">Bearer Authentication</span>

Upon successfully calling the `/login` endpoint with valid credentials, you will receive a bearer token, referred to as `<YOUR_TOKEN>`. This token remains valid for a duration of 12 hours. The Ezus API requires this bearer token to be included in the Authorization header parameter of all subsequent requests.

`Authorization: Bearer <YOUR_TOKEN>`

## POST login

> To initiate authentication, your first step is to make a request to the `/login` endpoint:

```shell
curl --location 'https://api.ezus.app/login' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "<YOUR_EMAIL>",
    "password": "<YOUR_PASSWORD>"
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  email: "<YOUR_EMAIL>",
  password: "<YOUR_PASSWORD>",
};
const headers = { "x-api-key": "<YOUR_API_KEY>" };

axios.post(baseUrl + "/login", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "token": "<YOUR_TOKEN>"
}
```

> In subsequent requests, remember to replace `<YOUR_TOKEN>` in the Authorization header parameter with the token you received during this authentication process.

### HTTP Endpoint

`POST https://api.ezus.app/login`

### Header Parameters

| Parameter | Type   | Description                                                                 |
| --------- | ------ | --------------------------------------------------------------------------- |
| x-api-key | String | <span class="label label-red float-right">Required</span> Your Ezus API key |

### Body Parameters (application/json)

| Parameter | Type   | Description                                                                     |
| --------- | ------ | ------------------------------------------------------------------------------- |
| email     | String | <span class="label label-red float-right">Required</span> Your account email    |
| password  | String | <span class="label label-red float-right">Required</span> Your account password |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message. If successful, it also returns a `token` that you must retain for future API requests.

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
      "created_at": "2024-06-18",
      "updated_at": "2024-06-19",
      "currency": "€",
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

| Parameter            | Type   | Description                                                                                                                                                                                        |
| -------------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token           | String | Specify this parameter if you want to retrieve the following elements of a given list query                                                                                                        |
| info_stage_reference | String | You can filter projects that are in a specific stage. The stage of the project must be indicated by its technical name                                                                             |
| created_at           | Date   | You can filter projects assigned to a specific or an intersection of creation date. Expected format: “YYYY-MM-DD” or “YYYY-MM-DD,YYYY-MM-DD”. See [Date Format](#date-format) for more details.    |
| updated_at           | Date   | You can filter projects assigned to a specific or an intersection of last update date. Expected format: “YYYY-MM-DD” or “YYYY-MM-DD,YYYY-MM-DD”. See [Date Format](#date-format) for more details. |
| trip_date_in         | Date   | You can filter projects assigned to a specific or an intersection of trip start date. Expected format: “YYYY-MM-DD” or “YYYY-MM-DD,YYYY-MM-DD”. See [Date Format](#date-format) for more details.  |
| trip_date_out        | Date   | You can filter projects assigned to a specific or an intersection of trip end date. Expected format: “YYYY-MM-DD” or “YYYY-MM-DD,YYYY-MM-DD”. See [Date Format](#date-format) for more details.    |
| sales_manager        | String | You can filter projects assigned to a specific sales manager. Expected format: email (john.doe@e-corp.com)                                                                                         |
| project_manager      | String | You can filter projects assigned to a specific project manager. Expected format: email (john.doe@e-corp.com)                                                                                       |

### Response

A JSON object containing the project information with properties like:

| Property   | Type   | Description                                                                                                                                                                                 |
| ---------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token | String | A token will be returned if all projects have not been returned. Use it in another call to access the following projects                                                                    |
| size       | Number | The total number of projects available with these filters                                                                                                                                   |
| data_size  | Number | Number of projects returned on the current page                                                                                                                                             |
| page       | Number | The page number                                                                                                                                                                             |
| projects   | Array  | An array of JSON objects, each representing a project. These objects are formatted according to a simplified version of the GET `project` response structure. ([GET project](#get-project)) |

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
  "created_at": "2024-06-18",
  "updated_at": "2024-06-19",
  "currency": "€",
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
      "alternative_title": "Main Alternative",
      "is_main": true,
      "trip_date_in": "2024-03-01",
      "trip_date_out": "2024-03-09",
      "trip_duration": 9,
      "trip_budget": 90000,
      "budget_actual": 88750,
      "budget_actual_excl_taxes ": 77950,
      "budget_margin_gross": 2500,
      "budget_margin_net": 1000,
      "trip_people": "15",
      "trip_date_in": "2024-03-01",
      "trip_date_out": "2024-03-09",
      "trip_duration": 9,
      "trip_destination_reference": "destination_reference",
      "trip_destination": "France",
      "trip_subdestination_reference ": "subdestination_reference",
      "trip_subdestination": "Paris",
      "client": {
        "reference": "client_reference",
        "type": "enterprise",
        "company_name": "MOKE INTERNATIONAL LIMITED",
        "first_name": "Jane",
        "last_name": "Doe",
        "email": "contact@moke-international.com"
      },
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
| created_at           | Date   | Date of creation                                                                  |
| updated_at           | Date   | Date of the last update                                                           |
| currency             | String | Default currency of the project                                                   |
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
          "is_optional": false
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
  ]
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

| Parameter         | Type   | Description                                                                                                                    |
| ----------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------ |
| reference         | String | <span class="label label-red float-right">Required</span> The reference of the project to retrieve documents from              |
| alternative_order | Number | Specifies the alternative order in the project to retrieve documents from. If not provided, defaults to 0 for main alternative |

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
      "name": "Smith",
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

This API endpoint updates a project record if the provided reference matches an existing project in your account. If no match is found, a new project record is created with the provided reference, or a randomly generated one if no reference is supplied.

```shell
curl --location 'https://api.ezus.app/projects-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
    "reference": "project_reference",
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

| Parameter                     | Type   | Description                                                                                                                                                                                                                                                         |
| ----------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference                     | String | If provided, the unique reference associated with the project you want to update or create (or a random one will be generated).                                                                                                                                     |
| info_number                   | String | File number that appears in the project record. Not to be confused with reference                                                                                                                                                                                   |
| info_title                    | String | Title of the project. This parameter is required if you create a new project                                                                                                                                                                                        |
| info_stage_reference          | String | Stage of the project: Please use the technical name of the stage you intend to apply. If no specific stage is found, a default stage will be automatically assigned upon adding the project.                                                                        |
| trip_date_in                  | Date   | Date of the project's start in "YYYY-MM-DD" format (only settable when creating a new project). If not provided or if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1 day and trip_date_in as today. |
| trip_date_out                 | Date   | Date of the project's end in "YYYY-MM-DD" format (only settable when creating a new project). If not provided or if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1 day and trip_date_out as today.  |
| trip_budget                   | Number | Forecasted budget for the project                                                                                                                                                                                                                                   |
| trip_people                   | Number | Number of people in the project (only settable when creating a new project)                                                                                                                                                                                         |
| sales_manager_email           | Email  | Email of the Ezus user to be set as the sales manager of the project                                                                                                                                                                                                |
| client_reference              | String | Reference or email of an existing client in your Ezus account to link to the project (only settable when creating a new project)                                                                                                                                    |
| trip_destination_reference    | String | Reference of the destination to link to the project. To reset the destination, you can put `'0'`.                                                                                                                                                                   |
| trip_subdestination_reference | String | Reference of the sub-destination to link to the project. To reset the sub-destination, you can put `'0'`. If the `trip_destination_reference` is not provided, the `trip_subdestination_reference` will be ignored.                                                 |
| custom_fields                 | JSON   | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                                                       |

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
|----------|------|-----------------------------------------------------------|
| result   | Link | The URL link of the document after uploading the document |

## POST project-steps-upsert

This API endpoint creates or updates a project step. If the step already exists, it is updated, otherwise, it is created.

```shell
curl --location 'https://api.ezus.app/project-steps-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "reference": "project_step_reference",
    "project_reference": "project_reference",
    "alternative_order": "0",
    "name": "activity Title",
    "type": "activity",
    "category": "restaurant",
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
    "date_start": "2025-10-03 10:00:00",
    "date_end": "2025-10-03 12:00:00",
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "project_step_reference",
  project_reference: "project_reference",
  alternative_order: "0",
  name: "activity Title",
  type: "activity",
  category: "restaurant",
  people: 4, 
  address: {
    label: "58 Rue de Paradis",
    city: "Paris",
    country: "France",
    zip: "75010",
    geo: {
      x: 48.875761,
      y: 2.348727
    }
  },
  date_start: "2025-10-03 10:00:00",
  date_end: "2025-10-03 12:00:00",
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
|---------------|--------|-----------------------------------------------------------------------------|
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter         | Type   | Description                                                                                                                                                                                                                      |
|-------------------|--------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| reference         | String | The step reference used to retrieve the step. If the step reference is provided and exists, the step will be updated.                                                                                                            |
| project_reference | String | The project reference in which you want to create an step. This field is ignored on update.                                                                                                                                      |
| alternative_order | String | Specifies the alternative project order from which to create or update the step. If not provided, defaults to `0` for main alternative. This field is required to create an step. This field is ignored on update.               |
| type              | String | 3 options: `accom`, `activity`, `transport`. This field is required to create an step. This field is ignored on update.                                                                                                          |
| name              | String | Title of the step. This field is required to create an step. This field is optional on update.                                                                                                                                   |
| category          | String | Category of the step, If this is not specified during creation, the default value will be the main category of the account.                                                                                                      |
| date_start        | String | Start date and time of the step. Must be within the dates of the alternative where the step is created. Required when creating an step. Ignored on update. Expected format: `YYYY-MM-DD HH:MM:SS` (e.g.: `2024-10-01 12:00:00`). |
| date_end          | String | End date and time of the step. Must be within the dates of the alternative where the step is created. Required when creating an step. Ignored on update. Expected format: `YYYY-MM-DD HH:MM:SS` (e.g.: `2024-10-01 12:00:00`).   |
| people            | String | Number of people in the activity. You can use a `number` or `P`. If not specified when creating, `P` will be used as the default value. `P` represents the number of people in the project.                                      |
| address           | Object | JSON object address ([Address](#address))                                                                                                                                                                                        |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                  |
|-----------|--------|------------------------------------------------------------------------------|
| error     | String | If there was an error during creation or update                              |
| message   | String | The return message ‘ok’ if everything went well, otherwise the error message |
| action    | String | If the project has been updated and created                                  |
| reference | String | The reference of the activity that was created or updated                    |


# Clients

## GET clients

Returns a list of your clients, sorted from the newest to the oldest, with the most recent clients appearing first. The list of clients returned is paginated (50 per 50): to call the 50 next items in the list, call the route with the `next_token` query parameter.

```shell
curl --location 'https://api.ezus.app/clients' \
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

axios.get(baseUrl + "/clients", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "next_token": "<NEXT_TOKEN>",
  "size": 338,
  "data_size": 50,
  "page": 1,
  "clients": [
    {
      "reference": "client_reference",
      "info_number": "202306001-C",
      "type": "enterprise",
      "company_name": "MOKE INTERNATIONAL LIMITED",
      "info_notes": "This prospect looks interesting to follow",
      "website": "www.moke_ltd.com",
      "vat_number": "GB 240-635-038",
      "company_number": "09728676",
      "user": {
        "email": "tommy@e-corp.com",
        "first_name": "Tommy",
        "last_name": "Atkins",
        "agency": "Paris Agency"
      },
      "email": "contact@moke-international.com",
      "first_name": "Jane",
      "last_name": "Doe",
      "address": {
        "label": "58 Rue de Paradis",
        "city": "Paris",
        "country": "France",
        "zip": "75010",
        "geo": {
          "x": 48.875761,
          "y": 2.348727
        }
      }
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/clients`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter   | Type                               | Description                                                                                                                               |
| ----------- | ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| next_token  | String                             | Specify this parameter if you want to retrieve the following elements of a given list query.                                              |
| reference   | [Dynamic-filter](#dynamic-filters) | You can filter clients with a specific reference                                                                                          |
| info_number | [Dynamic-filter](#dynamic-filters) | You can filter clients with a specific info_number, file number that appears in the client record. Not to be confused with reference      |
| type        | String                             | You can filter clients by their type. Either `enterprise` or `individual`                                                                 |
| email       | [Dynamic-filter](#dynamic-filters) | You can filter clients by email. This filter works for both `enterprise` clients (uses the main contact’s email) and `individual` clients |

### Response

A JSON object containing the client information with properties like:

| Property   | Type   | Description                                                                                                                                                                             |
| ---------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token | String | A token will be returned if all clients have not been returned. Use it in another call to access the following clients                                                                  |
| size       | Number | The total number of clients available with these filters                                                                                                                                |
| data_size  | Number | Number of clients returned on the current page                                                                                                                                          |
| page       | Number | The page number                                                                                                                                                                         |
| clients    | Array  | An array of JSON objects, each representing a client. These objects are formatted according to a simplified version of the GET `client` response structure. ([GET client](#get-client)) |

## GET client

This API endpoint retrieves detailed information about a specific client in Ezus.

```shell
curl --location 'https://api.ezus.app/client?reference=client_reference' \
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

axios.get(baseUrl + "/client?reference=client_reference", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "reference": "client_reference",
  "info_number": "202306001-C",
  "type": "enterprise",
  "company_name": "MOKE INTERNATIONAL LIMITED",
  "info_notes": "This prospect looks interesting to follow",
  "website": "www.moke_ltd.com",
  "vat_number": "GB 240-635-038",
  "company_number": "09728676",
  "user": {
    "email": "tommy@e-corp.com",
    "first_name": "Tommy",
    "last_name": "Atkins",
    "agency": "Paris Agency"
  },
  "email": "contact@moke-international.com",
  "first_name": "Jane",
  "last_name": "Doe",
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
  "projects": {
    "data": [
      {
        "reference": "project_reference",
        "info_title": "Project title"
      }
    ],
    "size": 1
  },
  "contacts": {
    "data": [
      {
        "reference": "contact_reference",
        "email": "contact@moke.com",
        "first_name": "Jane",
        "last_name": "Doe",
        "title": "CEO",
        "gender": "Ms",
        "phone": "0101010101",
        "phone2": "0606060606",
        "birth_date": "1986-09-17",
        "is_main": true
      },
      {
        "reference": "contact_reference",
        "email": "bob@proton.me",
        "first_name": "Bob",
        "last_name": "Morane",
        "title": "Project Manager",
        "gender": "Mr",
        "phone": "0202020202",
        "phone2": "0707070707",
        "birth_date": "1985-10-18",
        "is_main": false
      }
    ],
    "size": 2
  },
  "custom_fields": [
    {
      "name": "CustomField",
      "value": "Value"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/client`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter | Type   | Description                                                                                       |
| --------- | ------ | ------------------------------------------------------------------------------------------------- |
| reference | String | <span class="label label-red float-right">Required</span> The reference of the client to retrieve |

### Response

A JSON object containing the client information with properties like:

| Property       | Type   | Description                                                                      |
| -------------- | ------ | -------------------------------------------------------------------------------- |
| reference      | String | The reference of the client                                                      |
| info_number    | String | File number that appears in the client record. Not to be confused with reference |
| type           | String | The type of the client (either "enterprise" or "individual")                     |
| company_name   | String | Name of the client's company (if applicable)                                     |
| info_notes     | String | Notes on the client                                                              |
| website        | String | Website of the client                                                            |
| vat_number     | String | VAT number of the client (only for "enterprise" clients)                         |
| company_number | String | Company registration number of the client (only for "enterprise" clients)        |
| user           | JSON   | JSON object representing the user ([User](#user)) associated with the client     |
| email          | String | Email of the main contact at the client's organization                           |
| first_name     | String | First name of the main contact at the client's organization                      |
| last_name      | String | Last name of the main contact at the client's organization                       |
| address        | JSON   | JSON object representing the address ([Address](#address)) of the client         |
| projects       | JSON   | Projects linked to the client (returns the first 10 projects)                    |
| contacts       | Array  | An array of JSON contacts ([Contacts](#contacts)) associated with the client     |
| custom_fields  | Array  | An array of JSON custom fields ([Custom fields](#custom-fields)) for the client  |

## POST clients-upsert

This API endpoint updates a client record if the provided reference or email matches an existing client in your account. If no match is found, a new client record is created with the provided reference, or a randomly generated one if no reference is supplied. The client's email can be used as the primary key for upsert operations.

### Duplicate Prevention Rules

- **Enterprise clients**: A client cannot be created or updated if another enterprise client already exists with the same **company name**.
- **Individual clients**: A client cannot be created or updated if another individual client already exists with the same **first and last name**.

### Error messages

- Enterprise client duplication → `A client with this name already exists`
- Individual client duplication → `A client with this name already exists`

```shell
curl --location 'https://api.ezus.app/clients-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
    "reference": "client_reference",
    "info_number": "202306001-C",
    "type": "enterprise",
    "company_name": "MOKE INTERNATIONAL LIMITED",
    "website": "www.moke_ltd.com",
    "vat_number": "FR 32 123456789",
    "company_number": "362 521 879 00034",
    "user": "sam@proton.me",
    "contact": {
        "email": "contact@moke-international.com",
        "first_name": "Jane",
        "last_name": "Doe",
        "title": "CEO",
        "gender": "Ms",
        "phone": "0101010101",
        "phone2": "0606060606",
        "birth_date": "1986-09-17"
    },
    "address": {
        "label": "58 Rue de Paradis",
        "city": "Paris",
        "country": "France",
        "zip": "75010"
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
  reference: "client_reference",
  info_number: "202306001-C",
  type: "enterprise",
  company_name: "MOKE INTERNATIONAL LIMITED",
  website: "www.moke_ltd.com",
  vat_number: "FR 32 123456789",
  company_number: "362 521 879 00034",
  user: "sam@proton.me",
  contact: {
    email: "contact@moke-international.com",
    first_name: "Jane",
    last_name: "Doe",
    title: "CEO",
    gender: "Ms",
    phone: "0101010101",
    phone2: "0606060606",
    birth_date: "1986-09-17",
  },
  address: {
    label: "58 Rue de Paradis",
    city: "Paris",
    country: "France",
    zip: "75010",
  },
  custom_fields: [{ name: "field_name", value: "field_value" }],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/clients-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Client successfully created",
  "reference": "client_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/clients-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter      | Type   | Description                                                                                                                                                                                                                            |
| -------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference      | String | If provided, the unique reference associated with the client you want to update or create (or a random one will be generated).                                                                                                         |
| info_number    | String | File number that appears in the client record. Not to be confused with reference                                                                                                                                                       |
| type           | String | Optional parameter. Specifies the client type (`enterprise` or `individual`). If `enterprise`, `company_name` is required. If `individual`, provide contact.first_name or contact.last_name.                                           |
| company_name   | String | <span class="label label-red float-right">Required</span> Name of the client's company (if applicable). If empty, the client will be considered an individual, and the name of the client will be the same as the name of the contact. |
| website        | String | Website of the client                                                                                                                                                                                                                  |
| vat_number     | String | VAT number of the client (only for "enterprise" clients)                                                                                                                                                                               |
| company_number | String | Company registration number of the client (only for "enterprise" clients)                                                                                                                                                              |
| user           | Email  | Email of the Ezus user to be set as the owner of the client                                                                                                                                                                            |
| contact        | JSON   | A single JSON element ([Contacts](#contacts)) representing the main                                                                                                                                                                    |
| address        | JSON   | JSON object address ([Address](#address)) To reset the address, you can put `'0'`. **Geolocation data cannot be modified during an upsert**.                                                                                           |
| custom_fields  | JSON   | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                          |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                             |
| --------- | ------ | --------------------------------------------------------------------------------------- |
| action    | String | Indicates type of client action was created                                             |
| reference | String | The `reference` for the client, which you should store for future updates or retrievals |

# Suppliers

## GET suppliers

Returns a list of your suppliers, sorted by creation date from newest to oldest, with the most recent suppliers appearing first. The list of suppliers returned is paginated (50 per 50): to call the 50 next items in the list, call the route with the `next_token` query parameter.

```shell
curl --location 'https://api.ezus.app/suppliers' \
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

axios.get(baseUrl + "/suppliers", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "next_token": "<NEXT_TOKEN>",
  "size": 338,
  "data_size": 50,
  "page": 1,
  "suppliers": [
    {
      "reference": "supplier_reference",
      "info_number": "202306001-S",
      "type": "accom, activity",
      "company_name": "The best hotel",
      "info_notes": "Emily confirmed: this hotel really is the best in town.",
      "website": "www.the_best_hotel.com",
      "capacity": "200",
      "user": {
        "email": "travel-design@e-corp.com",
        "first_name": "Alice",
        "last_name": "Tate",
        "agency": "Paris Agency"
      },
      "destination": {
        "reference": "destination_reference",
        "name": "France",
        "subdestination_reference": "subdestination_reference",
        "subdestination_name": "Paris"
      },
      "address": {
        "label": "58 Rue de Paradis",
        "city": "Paris",
        "country": "France",
        "zip": "75010",
        "geo": {
          "x": 48.875761,
          "y": 2.348727
        }
      }
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/suppliers`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter  | Type   | Description                                                                                  |
| ---------- | ------ | -------------------------------------------------------------------------------------------- |
| next_token | String | Specify this parameter if you want to retrieve the following elements of a given list query. |

### Response

A JSON object containing the supplier information with properties like:

| Property   | Type   | Description                                                                                                                                                                                     |
| ---------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token | String | A token will be returned if all suppliers have not been returned. Use it in another call to access the following suppliers                                                                      |
| size       | Number | The total number of suppliers available with these filters                                                                                                                                      |
| data_size  | Number | Number of suppliers returned on the current page                                                                                                                                                |
| page       | Number | The page number                                                                                                                                                                                 |
| suppliers  | Array  | An array of JSON objects, each representing a supplier. These objects are formatted according to a simplified version of the GET `supplier` response structure. ([GET supplier](#get-supplier)) |

## GET supplier

This API endpoint retrieves detailed information about a specific supplier in Ezus.

```shell
curl --location 'https://api.ezus.app/supplier?reference=supplier_reference' \
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

axios.get(baseUrl + "/supplier?reference=supplier_reference", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "reference": "supplier_reference",
  "info_number": "202306001-S",
  "type": "accom, activity",
  "company_name": "The best hotel",
  "info_notes": "Emily confirmed: this hotel really is the best in town.",
  "website": "www.the_best_hotel.com",
  "capacity": "200",
  "visual_url": "https://docs.google.com/presentation/d/10GoT7nVkSIScaHUQEPh-EyUms5o6D7bcgUYsJlyql94",
  "user": {
    "email": "travel-design@e-corp.com",
    "first_name": "Alice",
    "last_name": "Tate",
    "agency": "Paris Agency"
  },
  "destination": {
    "reference": "destination_reference",
    "name": "France",
    "subdestination_reference": "subdestination_reference",
    "subdestination_name": "Paris"
  },
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
  "medias": {
    "data": [
      {
        "media_name": "The lobby",
        "path_full": "www.the_best_hotel.com/media/loby.jpg"
      }
    ],
    "size": 1
  },
  "products": {
    "data": [
      {
        "reference": "product_reference",
        "title": "2-bed room with breakfast"
      }
    ],
    "size": 1
  },
  "contacts": {
    "data": [
      {
        "reference": "contact_reference",
        "email": "contact@moke.com",
        "first_name": "Jane",
        "last_name": "Doe",
        "title": "CEO",
        "gender": "Ms",
        "phone": "0101010101",
        "phone2": "0606060606",
        "is_main": true
      },
      {
        "reference": "contact_reference",
        "email": "bob@proton.me",
        "first_name": "Bob",
        "last_name": "Morane",
        "title": "Project Manager",
        "gender": "Mr",
        "phone": "0202020202",
        "phone2": "0707070707",
        "is_main": false
      }
    ],
    "size": 2
  },
  "langs": [
    {
      "lang": "american",
      "name": "The best hotel",
      "short_description": "The best hotel: Parisian luxury redefined.",
      "long_description": "Welcome to The best hotel, a luxurious Parisian hotel nestled in the heart of..."
    },
    {
      "lang": "spanish",
      "name": "The best hotel",
      "short_description": "Luz y lujo en París: The best hotel.",
      "long_description": "Bienvenido a The best hotel, un lujoso hotel parisino ubicado en el corazón de..."
    }
  ],
  "custom_fields": [
    {
      "name": "Stars",
      "value": "5"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/supplier`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter | Type   | Description                                                                                         |
| --------- | ------ | --------------------------------------------------------------------------------------------------- |
| reference | String | <span class="label label-red float-right">Required</span> The reference of the supplier to retrieve |

### Response

A JSON object containing the supplier information with properties like:

| Property      | Type   | Description                                                                                                                                                  |
| ------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| reference     | String | The reference of the supplier                                                                                                                                |
| info_number   | String | File number that appears in the supplier record. Not to be confused with reference                                                                           |
| type          | String | 3 options: `accom`, `activity`, `transport`. A supplier can have no type, 1 type or several types. In this case, the different types are separated by commas |
| company_name  | String | Name of the company of the supplier                                                                                                                          |
| info_notes    | String | The notes about the product                                                                                                                                  |
| website       | String | Website of the supplier                                                                                                                                      |
| capacity      | String | Maximum number of people for which the supplier can be used                                                                                                  |
| visual_url    | String | URL of the Google Slides visual linked to the supplier                                                                                                       |
| user          | JSON   | JSON object user ([User](#user))                                                                                                                             |
| destination   | JSON   | JSON object destination ([Destination](#destination))                                                                                                        |
| address       | JSON   | JSON object address ([Address](#address))                                                                                                                    |
| medias        | JSON   | JSON object medias ([Medias](#medias))                                                                                                                       |
| products      | JSON   | JSON object products ([Products](#products-2))                                                                                                               |
| contacts      | Array  | Array of JSON contacts ([Contacts](#contacts))                                                                                                               |
| langs         | Array  | Array of JSON langs ([Langs](#langs))                                                                                                                        |
| custom_fields | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                |

## POST suppliers-upsert

It updates a supplier record if the provided reference (or the email) does match one of the supplier references in your account, otherwise it creates a new supplier record with the provided reference (or with a random one if no reference is provided). Note that for this endpoint, the email of the supplier can also be used as a primary key for the upsert.

```shell
curl --location 'https://api.ezus.app/suppliers-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
  "reference": "supplier_reference",
  "info_number": "202306001-S",
  "type": "accom, activity",
  "company_name": "The best hotel",
  "website": "www.the_best_hotel.com",
  "capacity": "200",
  "user": "sam@proton.me",
  "contact": {
      "email": "bob@proton.me",
      "first_name": "Bob",
      "last_name": "Morane",
      "title": "Project Manager",
      "gender": "Mr",
      "phone": "0606060606",
      "phone2": "0707070707"
  },
  "address": {
      "label": "58 Rue de Paradis",
      "city": "Paris",
      "country": "France",
      "zip": "75010"
  },
  "destination_reference": "destination_reference",
  "subdestination_reference": "subdestination_reference",
  "custom_fields": [
      {"name": "field_name", "value": "field_value"}
  ]
}
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "supplier_reference",
  info_number: "202306001-S",
  type: "accom, activity",
  company_name: "The best hotel",
  website: "www.the_best_hotel.com",
  capacity: 200,
  user: "sam@proton.me",
  contact: {
    email: "bob@proton.me",
    first_name: "Bob",
    last_name: "Morane",
    title: "Project Manager",
    gender: "Mr",
    phone: "0606060606",
    phone2: "0707070707",
  },
  address: {
    label: "58 Rue de Paradis",
    city: "Paris",
    country: "France",
    zip: "75010",
  },
  destination_reference: "destination_reference",
  subdestination_reference: "subdestination_reference",
  custom_fields: [{ name: "field_name", value: "field_value" }],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/suppliers-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Supplier successfully created",
  "reference": "supplier_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/suppliers-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter                | Type   | Description                                                                                                                                                                                                                                      |
| ------------------------ | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --- |
| reference                | String | If provided, the unique reference associated to the supplier you want to update or create (in case the one you provided has never been used). If no reference is provided, a supplier will be created with a random one.                         |
| info_number              | String | File number that appears in the supplier record. Not to be confused with reference                                                                                                                                                               |
| type                     | String | Either `undefined` or a combination of these 3 options: `accom`, `activity`, `transport`. You can select multiple options by separating them with comas ("accom, activity" for instance). Enter "undefined" if you want to reset this parameter. |
| company_name             | String | <span class="label label-red float-right">Required</span> Name of the supplier. This parameter is required if you create a new supplier                                                                                                          |     |
| website                  | String | Website of the supplier                                                                                                                                                                                                                          |
| capacity                 | Number | Maximum number of people for which the supplier can be used. Leave blank `''` if not relevant                                                                                                                                                    |
| user                     | Email  | Email of the Ezus user that will be set as the owner of the supplier. By default, if no owner is provided or the provided email do not match any user on this account, the owner will be assigned to everyone                                    |
| contact                  | JSON   | Contact is a single JSON and email is needed. Note that only one contact can be upsert this way (the main contact of the supplier) ([Contact](#contacts)) To reset the main contact, you can put `'0'`                                           |
| address                  | JSON   | JSON object address ([Address](#address)) To reset the address, you can put `'0'`. **Geolocation data cannot be modified during an upsert**.                                                                                                     |
| destination_reference    | String | Reference of the destination to link to the supplier. To reset the destination, you can put `'0'`.                                                                                                                                               |
| subdestination_reference | String | Reference of the sub-destination to link to the supplier. To reset the sub-destination, you can put `'0'`. If the `destination_reference` is not provided, the `subdestination_reference` will be ignored.                                       |
| custom_fields            | JSON   | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                                    |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                               |
| --------- | ------ | ----------------------------------------------------------------------------------------- |
| action    | String | Indicates type of supplier action was created                                             |
| reference | String | The `reference` for the supplier, which you should store for future updates or retrievals |

# Products

## GET products

Returns a list of your products, sorted by creation date from newest to oldest, with the most recent products appearing first. The list of products returned is paginated (50 per 50): to call the 50 next items in the list, call the route with the `next_token` query parameter.

```shell
curl --location 'https://api.ezus.app/products' \
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

axios.get(baseUrl + "/products", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "next_token": "<NEXT_TOKEN>",
  "size": 338,
  "data_size": 50,
  "page": 1,
  "products": [
    {
      "reference": "product_reference",
      "info_number": "202306001-PR",
      "title": "2-bed room with breakfast",
      "capacity": "2",
      "quantity": "1",
      "currency": "EUR",
      "vat_rate": 20.0,
      "vat_regime": "margin",
      "commission": {
        "commission_mode": "purchase",
        "commission_regime": "percent",
        "value": "10"
      },
      "supplier_reference": "supplier_reference",
      "package_reference": "package_reference",
      "destination": {
        "reference": "destination_reference",
        "name": "France",
        "subdestination_reference": "subdestination_reference",
        "subdestination_name": "Paris"
      },
      "budget_form": "Important",
      "budget_variable": "Display"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/products`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter  | Type   | Description                                                                                  |
| ---------- | ------ | -------------------------------------------------------------------------------------------- |
| next_token | String | Specify this parameter if you want to retrieve the following elements of a given list query. |

### Response

A JSON object containing the product information with properties like:

| Property   | Type   | Description                                                                                                                                                                                 |
| ---------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token | String | A token will be returned if all products have not been returned. Use it in another call to access the following products                                                                    |
| size       | Number | The total number of products available with these filters                                                                                                                                   |
| data_size  | Number | Number of products returned on the current page                                                                                                                                             |
| page       | Number | The page number                                                                                                                                                                             |
| products   | Array  | An array of JSON objects, each representing a product. These objects are formatted according to a simplified version of the GET `product` response structure. ([GET product](#get-product)) |

## GET product

This API endpoint retrieves detailed information about a specific product in Ezus.

```shell
curl --location 'https://api.ezus.app/product?reference=product_reference' \
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

axios.get(baseUrl + "/product?reference=product_reference", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "reference": "product_reference",
  "info_number": "202306001-PR",
  "title": "2-bed room with breakfast",
  "info_notes": "Product's notes",
  "capacity": "2",
  "quantity": "1",
  "currency": "EUR",
  "vat_rate": 20.0,
  "vat_regime": "margin",
  "visual_url": "https://docs.google.com/presentation/d/10GoT7nVkSIScaHUQEPh-EyUms5o6D7bcgUYsJlyql94",
  "commission": {
    "commission_mode": "purchase",
    "commission_regime": "percent",
    "value": "10"
  },
  "supplier": {
    "reference": "supplier_reference",
    "company_name": "The best hotel"
  },
  "package": {
    "reference": "package_reference",
    "title": "packages_title"
  },
  "destination": {
    "reference": "destination_reference",
    "name": "France",
    "subdestination_reference": "subdestination_reference",
    "subdestination_name": "Paris"
  },
  "budget_form": "Important",
  "budget_text": "Option",
  "budget_variable": "Display",
  "medias": {
    "data": [
      {
        "media_name": "img.jpeg",
        "path_full": "https://link-img.jpeg"
      }
    ],
    "size": 1
  },
  "langs": [
    {
      "lang": "french",
      "name": "Chambre à 2 lits avec petit déjeuner",
      "short_description": "",
      "long_description": ""
    }
  ],
  "tariffs": [
    {
      "reference": "tariff_reference",
      "type": "default",
      "name": "",
      "purchase_price": 100.0,
      "margin_rate": 50.0,
      "sales_price": 200.0,
      "childs": []
    }
  ],
  "custom_fields": [
    {
      "name": "View",
      "value": "Parking"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/product`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter | Type   | Description                                                                                        |
| --------- | ------ | -------------------------------------------------------------------------------------------------- |
| reference | String | <span class="label label-red float-right">Required</span> The reference of the product to retrieve |

### Response

A JSON object containing the product information with properties like:

| Property        | Type   | Description                                                                                                                                                                                                                              |
| --------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| reference       | String | The reference of the product                                                                                                                                                                                                             |
| info_number     | String | File number that appears in the product record. Not to be confused with reference                                                                                                                                                        |
| title           | String | Name of the product                                                                                                                                                                                                                      |
| info_notes      | String | Notes about your product                                                                                                                                                                                                                 |     |
| capacity        | Number | Maximum number of people for which the product can be used                                                                                                                                                                               |
| quantity        | String | The default number for this product when it is added to a project. It can either be a Number or one of these letters (`P` = Number of people in the project, `D` = Number of days in the project, `N` = Number of nights in the project) |
| currency        | String | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>)                        |
| vat_rate        | Number | Default % of the VAT on the product                                                                                                                                                                                                      |
| vat_regime      | String | Can be either `classic` (common law VAT), `margin` (VAT on the margin), `none` (Non applicable VAT)                                                                                                                                      |
| visual_url      | String | URL of the Google Slides visual linked to the product                                                                                                                                                                                    |
| commission      | JSON   | A JSON object containing `commission_mode` ("sales" or "purchase"), `commission_regime` ("percent" or "amount"), `value`                                                                                                                 |
| supplier        | JSON   | A JSON object containing `reference`, `company_name`                                                                                                                                                                                     |
| package         | JSON   | A JSON object containing `reference`, `title`                                                                                                                                                                                            |
| destination     | JSON   | JSON object destination ([Destination](#destination))                                                                                                                                                                                    |
| buget_form      | String | `Important`, `Normal`, `Low` represent how the product will be highlight on the budget By Default                                                                                                                                        |
| budget_text     | String | This is an empty string `""` if the product is not marked as an option in the budget, otherwise it is the custom label of the option to which the product is associated                                                                  |
| budget_variable | String | `Display`, `Do not Display`, this option tells if the product will be displayed or not in the budget                                                                                                                                     |
| medias          | JSON   | JSON object medias ([Medias](#medias))                                                                                                                                                                                                   |
| langs           | Array  | Array of JSON langs ([Langs](#langs))                                                                                                                                                                                                    |
| tariffs         | Array  | Array of JSON tariffs ([Tariffs](#tariffs))                                                                                                                                                                                              |
| custom_fields   | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                            |
|                 |

## POST products-upsert

It updates a product record if the provided reference does match one of the product references in your account, otherwise it creates a new product record with the provided reference (or with a random one if no reference is provided).

```shell
curl --location 'https://api.ezus.app/products-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "reference": "product_reference",
    "info_number": "202306001-PR",
    "title": "2-bed room with breakfast",
    "info_notes": "The notes about the product",
    "capacity": "2",
    "quantity": "1",
    "currency": "USD",
    "purchase_price": "42",
    "sales_price": "84",
    "vat_rate": 20,
    "vat_regime": "none",
    "commission": {
        "commission_mode": "purchase",
        "commission_regime": "percent",
        "value": 10
    },
    "supplier_reference": "supplier_reference",
    "package_reference": "package_reference",
    "destination_reference": "destination_reference",
    "subdestination_reference": "subdestination_reference",
    "custom_fields": [
        {"name": "field_name", "value": "field_value"}
    ]
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "product_reference",
  info_number: "202306001-PR",
  title: "2-bed room with breakfast",
  info_notes: "Product's notes",
  capacity: 2,
  quantity: "1",
  currency: "USD",
  purchase_price: "42",
  sales_price: "84",
  vat_rate: "20",
  vat_regime: "none",
  commission: {
    commission_mode: "purchase",
    commission_regime: "percent",
    value: "10",
  },
  supplier_reference: "supplier_reference",
  package_reference: "package_reference",
  destination_reference: "destination_reference",
  subdestination_reference: "subdestination_reference",
  custom_fields: [{ name: "field_name", value: "field_value" }],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/products-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Product successfully created",
  "reference": "product_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/products-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter                | Type   | Description                                                                                                                                                                                                                                                             |
| ------------------------ | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference                | String | If provided, the unique reference associated to the product you want to update or create (in case the one you provided has never been used). If no reference is provided, a product will be created with a random one.                                                  |
| info_number              | String | File number that appears in the product record. Not to be confused with reference                                                                                                                                                                                       |
| title                    | String | Title of your product. This parameter is required if you create a new product                                                                                                                                                                                           |
| info_notes               | String | Notes about your product. This parameter is not required if you create or update a product                                                                                                                                                                              |
| capacity                 | Number | Maximum number of people for which the product can be used. Leave blank `''` if not relevant                                                                                                                                                                            |
| quantity                 | String | The default number for this product when it is added to a project. It can either be a Number or one of these letters (`P` = Number of people in the project, `D` = Number of days in the project, `N` = Number of nights in the project)                                |
| currency                 | String | The ISO 4217 code of the currency of this product (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to Doc</a>). If empty or not provided, your default account currency will be set |
| purchase_price           | Number | Purchase price as a number                                                                                                                                                                                                                                              |
| sales_price              | Number | Sales price as a number                                                                                                                                                                                                                                                 |
| vat_rate                 | Number | Default VAT rate. If empty or not provided, your default account VAT rate will be set                                                                                                                                                                                   |
| vat_regime               | String | Can be either `classic` (common law VAT), `margin` (VAT on the margin), `none` (Non applicable VAT). If empty or not provided, your default account VAT regime will be set                                                                                              |
| commission               | JSON   | A JSON object containing `commission_mode` ("sales" or "purchase"), `commission_regime` ("percent" or "amount"), `value`                                                                                                                                                |
| supplier_reference       | String | If you give an adequate supplier reference, the product will be added in this supplier. If you want to update the supplier's product to None, you must enter 0.                                                                                                         |
| package_reference        | String | If you give an adequate package reference, the product will be added in this package. If you want to update the package's product to None, you must enter 0.                                                                                                            |
| destination_reference    | String | Reference of the destination to link to the product. To reset the destination, you can put `'0'`.                                                                                                                                                                       |
| subdestination_reference | String | Reference of the sub-destination to link to the product. To reset the sub-destination, you can put `'0'`. If the `destination_reference` is not provided, the `subdestination_reference` will be ignored.                                                               |
| custom_fields            | JSON   | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                                                           |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                              |
| --------- | ------ | ---------------------------------------------------------------------------------------- |
| action    | String | Indicates type of product action was created                                             |
| reference | String | The `reference` for the product, which you should store for future updates or retrievals |

# Packages

## GET package

This API endpoint retrieves detailed information about a specific package in Ezus.

```shell
curl --location 'https://api.ezus.app/package?reference=package_reference' \
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

axios.get(baseUrl + "/package?reference=package_reference", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "reference": "package_reference",
  "info_number": "202306001-PK",
  "title": "The best package",
  "info_notes": "A classical day in Paris",
  "capacity": "2",
  "visual_url": "https://docs.google.com/presentation/d/10GoT7nVkSIScaHUQEPh-EyUms5o6D7bcgUYsJlyql94",
  "suppliers": {
    "data": [
      {
        "reference": "supplier_reference",
        "company_name": "The best hotel"
      }
    ],
    "size": 1
  },
  "medias": {
    "data": [],
    "size": 0
  },
  "products": {
    "data": [
      {
        "reference": "product_reference",
        "title": "2-bed room with breakfast"
      },
      {
        "reference": "product_reference_1235",
        "title": "A gourmet menu for 2"
      }
    ],
    "size": 2
  },
  "langs": [
    {
      "lang": "american",
      "name": "The best package",
      "short_description": "A classical day in Paris",
      "long_description": "Immerse yourself in the romance and elegance of a classical Parisian day, as our hotel and restaurant capture the essence of this magical city."
    },
    {
      "lang": "french",
      "name": "Le meilleur package",
      "short_description": "Une journée classique à Paris",
      "long_description": "Plongez dans le romantisme et l'élégance d'une journée parisienne classique, car notre hôtel et notre restaurant capturent l'essence de cette ville magique."
    }
  ],
  "custom_fields": [
    {
      "name": "Is for children?",
      "value": "False"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/package`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter | Type   | Description                                                                                        |
| --------- | ------ | -------------------------------------------------------------------------------------------------- |
| reference | String | <span class="label label-red float-right">Required</span> The reference of the package to retrieve |

### Response

A JSON object containing the package information with properties like:

| Property      | Type   | Description                                                                       |
| ------------- | ------ | --------------------------------------------------------------------------------- |
| reference     | String | The reference of the package                                                      |
| info_number   | String | File number that appears in the package record. Not to be confused with reference |
| title         | String | Name of the package                                                               |
| info_notes    | String | Notes on the package                                                              |
| capacity      | String | Maximum number of people for which the package can be used                        |
| visual_url    | String | URL of the Google Slides visual linked to the package                             |
| suppliers     | JSON   | JSON object suppliers ([Suppliers](#suppliers-2))                                 |
| medias        | JSON   | JSON object medias ([Medias](#medias))                                            |
| products      | JSON   | JSON object products ([Products](#products-2))                                    |
| langs         | Array  | Array of JSON langs ([Langs](#langs))                                             |
| custom_fields | Array  | Array of JSON custom fields [Custom fields](#custom-fields)                       |

## POST packages-upsert

It updates a package record if the provided reference does match one of the package references in your account, otherwise it creates a new package record with the provided reference (or with a random one if no reference is provided).

```shell
curl --location 'https://api.ezus.app/packages-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "reference": "package_reference",
    "info_number": "202306001-PK",
    "title": "The best package",
    "capacity": "2",
    "destination_reference": "destination_reference",
    "subdestination_reference": "subdestination_reference",
    "custom_fields": [
        {"name": "field_name", "value": "field_value"}
    ]

}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "package_reference",
  info_number: "202306001-PK",
  title: "The best package",
  capacity: "2",
  destination_reference: "destination_reference",
  subdestination_reference: "subdestination_reference",
  custom_fields: [{ name: "field_name", value: "field_value" }],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/packages-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Package successfully created",
  "reference": "package_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/packages-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter                | Type   | Description                                                                                                                                                                                                            |
| ------------------------ | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference                | String | If provided, the unique reference associated to the package you want to update or create (in case the one you provided has never been used). If no reference is provided, a package will be created with a random one. |
| info_number              | String | File number that appears in the package record. Not to be confused with reference                                                                                                                                      |
| title                    | String | This parameter is required if you create a new package                                                                                                                                                                 |
| capacity                 | Number | Maximum number of people for which the package can be used . Leave blank `''` if not relevant                                                                                                                          |
| destination_reference    | String | Reference of the destination to link to the package. To reset the destination, you can put `'0'`.                                                                                                                      |
| subdestination_reference | String | Reference of the sub-destination to link to the package. To reset the sub-destination, you can put `'0'`. If the `destination_reference` is not provided, the `subdestination_reference` will be ignored.              |
| custom_fields            | JSON   | Array of JSON custom fields [Custom fields](#custom-fields)                                                                                                                                                            |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                              |
| --------- | ------ | ---------------------------------------------------------------------------------------- |
| action    | String | Indicates type of package action was created                                             |
| reference | String | The `reference` for the package, which you should store for future updates or retrievals |

# Destinations

## GET destinations

Returns a list of all destinations and sub-destinations. The list is not paginated and is theoretically limited to 1000 objects (destinations and sub-destinations), although higher limits may work depending on the payload size. The order of the destinations and sub-destinations matches their order in Ezus.

```shell
curl --location 'https://api.ezus.app/destinations' \
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

axios.get(baseUrl + "/destinations", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "size": 32,
  "destinations": [
    {
      "reference": "destination_reference",
      "name": "France",
      "subdestinations": [
        {
          "reference": "subdestination_reference",
          "name": "Paris"
        }
      ]
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/destinations`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Response

A JSON object containing the destination information with properties like:

| Property     | Type   | Description                                                  |
| ------------ | ------ | ------------------------------------------------------------ |
| size         | Number | The total number of destinations                             |
| destinations | Array  | Array of JSON destinations ([Destinations](#destinations-2)) |

## POST destinations-upsert

It updates a destination record if the provided reference does match one of the destination references in your account, otherwise it creates a new destination record with the provided reference (or with a random one if no reference is provided).

```shell
curl --location 'https://api.ezus.app/destinations-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>'
--data '{
    "reference": "destination_reference",
    "name": "France"
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "destination_reference",
  name: "France",
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/destinations-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Destination successfully created",
  "reference": "destination_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/destinations-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter | Type   | Description                                                                                                                                                                                                                    |
| --------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| reference | String | If provided, the unique reference associated to the destination you want to update or create (in case the one you provided has never been used). If no reference is provided, a destination will be created with a random one. |
| name      | String | This parameter is required. Name of the destination to create or update. If a destination already exists with this name, it will return an error.                                                                              |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                                  |
| --------- | ------ | -------------------------------------------------------------------------------------------- |
| action    | String | Indicates type of destination action was created                                             |
| reference | String | The `reference` for the destination, which you should store for future updates or retrievals |

## GET subdestination

This API endpoint retrieves detailed information about a specific sub-destination in Ezus.

```shell
curl --location 'https://api.ezus.app/subdestination?reference=subdestination_reference' \
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
  baseUrl + "/subdestination?reference=subdestination_reference",
  headers
);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "reference": "subdestination_reference",
  "name": "Paris",
  "destination_reference": "destination_reference",
  "destination_name": "France",
  "visual_url": "https://docs.google.com/presentation/d/10GoT7nVkSIScaHUQEPh-EyUms5o6D7bcgUYsJlyql94",
  "medias": {
    "data": [
      {
        "media_name": "img.jpeg",
        "path_full": "https://link-img.jpeg"
      }
    ],
    "size": 1
  },
  "langs": [
    {
      "lang": "french",
      "name": "Chambre à 2 lits avec petit déjeuner",
      "short_description": "",
      "long_description": ""
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/subdestination`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter | Type   | Description                          |
| --------- | ------ | ------------------------------------ |
| reference | String | The reference of the sub-destination |

### Response

A JSON object containing the sub-destination information with properties like:

| Property              | Type   | Description                                                   |
| --------------------- | ------ | ------------------------------------------------------------- |
| reference             | String | The reference of the sub-destination                          |
| name                  | String | Name of the sub-destination                                   |
| destination_reference | String | The reference of the destination                              |
| destination_name      | String | Name of the destination                                       |
| visual_url            | String | URL of the Google Slides visual linked to the sub-destination |
| medias                | JSON   | JSON object medias ([Medias](#medias))                        |
| langs                 | Array  | Array of JSON langs ([Langs](#langs))                         |

## POST subdestinations-upsert

It updates a sub-destination record if the provided reference does match one of the sub-destination references in your account, otherwise it creates a new sub-destination record with the provided reference (or with a random one if no reference is provided).

```shell
curl --location 'https://api.ezus.app/subdestinations-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>'
--data '{
    "reference": "subdestination_reference",
    "destination_reference": "destination_reference",
    "name": "Paris"
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "subdestination_reference",
  destination_reference: "destination_reference"
  name: "Paris",
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/subdestinations-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Subdestination successfully created",
  "reference": "subdestination_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/subdestinations-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter             | Type   | Description                                                                                                                                                                                                                            |
| --------------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference             | String | If provided, the unique reference associated to the sub-destination you want to update or create (in case the one you provided has never been used). If no reference is provided, a sub-destination will be created with a random one. |
| destination_reference | String | This parameter is required and must match an existing destination.                                                                                                                                                                     |
| name                  | String | This parameter is required. Name of the sub-destination to create or update. If a sub-destination already exists with this name, it will return an error.                                                                              |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                                      |
| --------- | ------ | ------------------------------------------------------------------------------------------------ |
| action    | String | Indicates type of sub-destination action was created                                             |
| reference | String | The `reference` for the sub-destination, which you should store for future updates or retrievals |

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

| Parameter      | Type   | Description                                                                                                                                                               |
| -------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token     | String | Specify this parameter if you want to retrieve the following elements of a given list query. If this parameter is filled, other parameters are ignored.                   |
| stage          | String | You can filter invoices that are at a specific stage. The stage can be `paid`, `completed` or `draft`.                                                                    |
| technical_name | String | You can filter invoices according to one of their custom fields by adding the `technical_name` of the custom field as a query parameter and the desired value as a value. |

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
  }
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

| Property           | Type   | Description                                                                                                                                                                                                       |
| ------------------ | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference          | String | The reference of the invoice                                                                                                                                                                                      |
| info_number        | String | Title of the invoice                                                                                                                                                                                              |
| type               | String | Type of the invoice `invoice` or `credit_note`                                                                                                                                                                    |
| origin_reference   | String | This is only displayed if the type of the invoice is a `credit_note`. The reference of the origin invoice.                                                                                                        |
| origin_info_number | String | This is only displayed if the type of the invoice is a `credit_note`. Title of the origin invoice.                                                                                                                |
| stage              | String | Stage of the invoice `draft` `completed` or `paid`                                                                                                                                                                |
| created_date       | String | Date of the creation of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                    |
| send_date          | String | Sent date of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                               |
| due_date           | String | Due date of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                                |
| currency           | String | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>) |
| amount_ttc         | Number | Amount of the invoice including taxes                                                                                                                                                                             |
| amount_ht          | Number | Amount of the invoice excluding taxes                                                                                                                                                                             |
| vat                | Number | VAT amount of the invoice                                                                                                                                                                                         |
| url                | String | URL of the invoice `.pdf` file                                                                                                                                                                                    |
| project            | JSON   | JSON including: `reference`, `info_number`, `info_title`, `info_stage_reference`, `info_stage`, `currency` and `is_closed`                                                                                        |
| alternative        | JSON   | JSON including: `sort_order` and `title`                                                                                                                                                                          |
| client             | JSON   | JSON including: `reference`, `type` (enterprise or individual), `company_name`, `first_name`, `last_name` and `email`                                                                                             |
| forecast           | JSON   | JSON object forecast ([Invoices Amounts](#invoices-amounts))                                                                                                                                                      |
| actual             | JSON   | JSON object actual ([Invoices Amounts](#invoices-amounts))                                                                                                                                                        |

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
| custom_fields | JSON   | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                              |
| --------- | ------ | ---------------------------------------------------------------------------------------- |
| action    | String | Indicates type of invoice action was created                                             |
| reference | String | The `reference` for the invoice, which you should store for future updates or retrievals |

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
  "filename": "File Name",
  "created_date": "2023-10-10",
  "due_date": "2023-10-20",
  "currency": "EUR",
  "amount_ttc": 1200.0,
  "amount_ht": 1000.0,
  "vat": 200.0,
  "url": "https://ezus.io/2023_101010.pdf",
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

| Property     | Type   | Description                                                                                                                                                                                                       |
| ------------ | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference    | String | The reference of the supplier invoice                                                                                                                                                                             |
| filename     | String | Filename of the supplier invoice                                                                                                                                                                                  |
| created_date | String | Date of the creation of the supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                            |
| due_date     | String | Due date of the supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                                        |
| currency     | String | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>) |
| amount_ttc   | Number | Amount of the supplier invoice excluding taxes                                                                                                                                                                    |
| amount_ht    | Number | Amount of the supplier invoice including taxes                                                                                                                                                                    |
| vat          | Number | VAT amount of the supplier invoice                                                                                                                                                                                |
| url          | String | URL of the supplier invoice file                                                                                                                                                                                  |
| supplier     | JSON   | JSON including: `reference`, `company_name` and `website`                                                                                                                                                         |
| project      | JSON   | JSON including: `reference`, `info_title`, `info_stage`, `info_stage_reference`, `info_number`, `currency` and `is_closed`                                                                                        |
| alternative  | JSON   | JSON including: `sort_order` and `title`                                                                                                                                                                          |
| client       | JSON   | JSON including: `reference`, `type` (enterprise or individual), `company_name`, `first_name`, `last_name` and `email`                                                                                             |
| payments     | Array  | Array of JSON including: `reference`, `date`, `amount` and `payment_method`                                                                                                                                       |

# Deposits

## POST deposits-create

It creates a client deposit in the specified project.

```shell
curl --location 'https://api.ezus.app/deposits-create' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
    "project_reference": "project_reference",
    "alternative_order": "0",
    "type": "deposit",
    "notes": "Up-front payment 2023-05-25",
    "date": "2023-05-25",
    "amount": 6855,
    "payment_method": "card"
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  project_reference: "project_reference",
  alternative_order: "0",
  type: "deposit",
  notes: "Up-front payment 2023-05-25",
  date: "2023-05-25",
  amount: 6855,
  payment_method: "card",
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/deposits-create", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Deposit successfully created"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/deposits-create`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter         | Type    | Description                                                                                                                                        |
| ----------------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| project_reference | String  | <span class="label label-red float-right">Required</span> The reference is mandatory and refers to the project to which the payment will be added. |
| alternative_order | String  | Alternative number, if not entered, the payment will be added to the project's main alternative.                                                   |
| type              | String  | Type can be `deposit`, `payment`, `final_payment`, `extra_paid`. By default the deposits will be a `deposit`                                       |
| notes             | String  | Note attributed to the payment, this note is limited to 100 characters, all additional characters will not be saved.                               |
| date              | String  | The date must be a string in "YYYY-MM-DD" format. If it is not filled in or is invalid, the payment will be assigned to the current date.          |
| amount            | Integer | The deposit amount in cents.                                                                                                                       |
| payment_method    | String  | Technical name of the payment method, you can find it in Settings - Custom fields                                                                  |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property | Type   | Description                                  |
| -------- | ------ | -------------------------------------------- |
| action   | String | Indicates type of deposit action was created |

# Webhooks

## GET webhooks

Retrieves a list of webhook endpoints, sorted by creation date from newest to oldest.

```shell
curl --location 'https://api.ezus.app/webhooks' \
--header 'X-API-KEY: <YOUR_API_KEY>' \
--header 'Authorization: Bearer <YOUR_TOKEN>'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const headers = {
  "X-API-KEY": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.get(baseUrl + "/webhooks", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "webhooks": [
    {
      "reference": "webhook_reference",
      "endpoint": "webhook_endpoint",
      "events_types": "projects.created,clients.created",
      "is_active": "true",
      "last_called_at": "2023-01-01 01:01:01"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/webhooks`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| X-API-KEY     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Response

An array of JSON that contains your webhooks information.

| Property | Type  | Description                                      |
| -------- | ----- | ------------------------------------------------ |
| webhooks | Array | Array of JSON webhooks ([Webhooks](#webhooks-2)) |

## GET webhooks-last

Returns the latest event occurrence of a specified event type.

```shell
curl --location 'https://api.ezus.app/webhooks-last?event_type=projects.created' \
--header 'X-API-KEY: <YOUR_API_KEY>' \
--header 'Authorization: Bearer <YOUR_TOKEN>'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const headers = {
  "X-API-KEY": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.get(baseUrl + "/webhooks-last?event_type=projects.created", headers);
```

> This request returns a structured JSON object:

```json
{
  "id": "event_id",
  "object": "event",
  "type": "projects.created",
  "field": "",
  "old_value": "",
  "new_value": "",
  "created": 1234567890,
  "trigger_reference": "pro.ezus.io;projects-create",
  "is_duplication": false,
  "data": {...}
}
```

### HTTP Endpoint

`GET https://api.ezus.app/webhooks-last`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| X-API-KEY     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter  | Type   | Description                                                                          |
| ---------- | ------ | ------------------------------------------------------------------------------------ |
| event_type | String | <span class="label label-red float-right">Required</span> The event type to retrieve |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message. If successful, it returns the latest event occurrence of a specified event type ([Events](#events)).

## POST webhooks-upsert

It updates a webhook record if the provided reference or endpoint does match one of the webhooks in your account, otherwise it creates a new webhook record with the provided reference (or with a random one if no reference is provided).

```shell
curl --location 'https://api.ezus.app/webhooks-upsert' \
--header 'X-API-KEY: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "reference": "webhook_reference",
    "endpoint": "https://webhook.webhook/",
    "is_active": "true",
    "events_types": "projects.created,clients.created"
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "webhook_reference",
  endpoint: "https://webhook.webhook/",
  is_active: "true",
  events_types: "projects.created,clients.created",
};
const headers = {
  "X-API-KEY": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/webhooks-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Webhook successfully created",
  "reference": "webhook_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/webhooks-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| X-API-KEY     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter    | Type   | Description                                                                                                                                                                                                                                                              |
| ------------ | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| reference    | String | If provided, the unique reference associated to the webhook you want to update or create (in case the one you provided has never been used). If no reference is provided, a webhook will be created with a random one.                                                   |
| endpoint     | String | If provided, the endpoint associated to the webhook you want to update or create (in case the one you provided has never been used). This parameter is required if you create a new webhook and has to be unique. You cannot update the endpoint of an existing webhook. |
| is_active    | String | Status of the webhook `true` or `false`                                                                                                                                                                                                                                  |
| events_types | JSON   | The list of events to enable for this endpoint. At least 1 required, separated by commas if more than one. ([Events](#events))                                                                                                                                           |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                              |
| --------- | ------ | ---------------------------------------------------------------------------------------- |
| action    | String | Indicates type of webhook action was created                                             |
| reference | String | The `reference` for the webhook, which you should store for future updates or retrievals |

## DELETE webhooks-delete

It deletes a webhook record if the provided reference or endpoint does match one of the webhooks in your account.

```shell
curl --request "DELETE" \
--location 'https://api.ezus.app/webhooks-delete' \
--header 'X-API-KEY: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "reference": "webhook_reference",
    "endpoint": "https://webhook.webhook/"
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "webhook_reference",
  endpoint: "https://webhook.webhook/",
};
const headers = {
  "X-API-KEY": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.delete(baseUrl + "/webhooks-delete", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Webhook successfully deleted"
}
```

### HTTP Endpoint

`DELETE https://api.ezus.app/webhooks-delete`

### Header parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| X-API-KEY     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body parameters (application/json)

| Parameter | Type   | Description                                                                    |
| --------- | ------ | ------------------------------------------------------------------------------ |
| reference | String | If provided, the unique reference associated to the webhook you want to delete |
| endpoint  | String | If provided, the endpoint associated to the webhook you want to delete         |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

# Nested Resources

### Address

```json
"address": {
  "label": "58 Rue de Paradis",
  "city": "Paris",
  "country": "France",
  "zip": "75010",
  "geo": {
    "x": 48.875761,
    "y": 2.348727
  }
}
```

| Property | Type   | Description                                                                                                                                                                                    |
| -------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| label    | String | Label of the address                                                                                                                                                                           |
| city     | String | Name of the city                                                                                                                                                                               |
| country  | String | Name of the country                                                                                                                                                                            |
| zip      | String | Post code                                                                                                                                                                                      |
| geo      | JSON   | Represents the geographical coordinates of the address or `null` if not geolocated. If provided, it consists of `x` (latitude) and `y` (longitude), both returning a `Number` with 6 decimals. |

### Alternatives

```json
"alternatives": [
  {
    "alternative_title": "Main Alternative",
    "is_main": true,
    "trip_date_in": "2024-03-01",
    "trip_date_out": "2024-03-09",
    "trip_duration": 9,
    "trip_budget": 90000,
    "budget_actual": 88750,
    "budget_actual_excl_taxes ": 77950,
    "budget_margin_gross": 2500,
    "budget_margin_net": 1000,
    "trip_people": "15",
    "client": {
      "reference": "client_reference",
      "type": "enterprise",
      "company_name": "MOKE INTERNATIONAL LIMITED",
      "first_name": "Jane",
      "last_name": "Doe",
      "email": "contact@moke-international.com"
    },
    "trip_destination_reference": "destination_reference",
    "trip_destination": "France",
    "trip_subdestination_reference ": "subdestination_reference",
    "trip_subdestination": "Paris",
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
    }
  }
]
```

| Property                      | Type    | Description                                                                                                                                                |
| ----------------------------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| alternative_title             | String  | Title of the alternative                                                                                                                                   |
| is_main                       | Boolean | If the alternative is the main alternative                                                                                                                 |
| trip_date_in                  | Date    | Date of the beginning of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates                                        |
| trip_date_out                 | Date    | Date of the end of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates                                              |
| trip_duration                 | Number  | Number of days this alternative lasts                                                                                                                      |
| trip_budget                   | Number  | Forecasted budget for the alternative (the one that is entered manually not the actual one)                                                                |
| budget_actual                 | Number  | Actual budget for the alternative, inclusive of taxes                                                                                                      |
| budget_actual_excl_taxes      | Number  | Actual budget for the alternative, excluding taxes                                                                                                         |
| budget_margin_gross           | Number  | Gross margin for the alternative                                                                                                                           |
| budget_margin_net             | Number  | Net margin for the alternative                                                                                                                             |
| trip_people                   | String  | Number of people                                                                                                                                           |
| client                        | JSON    | JSON including: `reference`, `type` (enterprise or individual), `company_name`, `first_name`, `last_name` and `email`                                      |
| trip_destination_reference    | String  | Destination reference of the alternative. Note: For multi-destination alternatives, only the primary destination is returned.                              |
| trip_destination              | String  | Destination of the alternative. Note: For multi-destination alternatives, only the primary destination is returned.                                        |
| trip_subdestination_reference | String  | Subdestination reference of the alternative. Note: For multi-destination alternatives, only the primary subdestination is returned.                        |
| trip_subdestination           | String  | Subdestination of the alternative. Note: For multi-destination alternatives, only the primary subdestination is returned.                                  |
| destinations                  | JSON    | JSON including: `size`, Array of all destination (`reference` and `name`) and subdestination (`subdestination_reference` and `subdestination_name`) values |

### Contacts

Only the last 10 contacts are returned in this object. Note that for upsert endpoints, only one contact is required (equivalent to a single JSON element in the contacts.data Array below).

```json
"contacts": {
  "data": [
    {
      "reference": "contact_reference",
      "email": "contact@moke.com",
      "first_name": "Jane",
      "last_name": "Doe",
      "title": "CEO",
      "gender": "Ms",
      "phone": "0101010101",
      "phone2": "0606060606",
      "birth_date": "1986-09-17",
      "is_main": true
    },
    {
      "reference": "contact_reference",
      "email": "bob@proton.me",
      "first_name": "Bob",
      "last_name": "Morane",
      "title": "Project Manager",
      "gender": "Mr",
      "phone": "0202020202",
      "phone2": "0707070707",
      "birth_date": "1985-10-18",
      "is_main": false
    }
  ],
  "size": 2
}
```

| Property   | Type    | Description                                                                                       |
| ---------- | ------- | ------------------------------------------------------------------------------------------------- |
| reference  | String  | Reference of the contact                                                                          |
| email      | String  | Email of the contact                                                                              |
| first_name | String  | First name of the contact as a string                                                             |
| last_name  | String  | Last name of the contact as a string                                                              |
| title      | String  | Title of the contact as a string                                                                  |
| gender     | String  | `Mr`, `Ms` or `Undefined`                                                                         |
| phone      | String  | Phone number of the contact as a string                                                           |
| phone2     | String  | Second phone number of the contact as a string                                                    |
| birth_date | String  | Contact's date of birth in a "YYYY-MM-DD" format string (supplier contacts have no date of birth) |
| is_main    | Boolean | True if this contact is the primary contact for the parent resource                               |

### Custom Fields

```json
"custom_fields": [
  {
    "name": "Text",
    "value": "Value"
  },
  {
    "name": "Number",
    "value": "42"
  },
  {
    "name": "Text area",
    "value": "Value of the text Area"
  },
  {
    "name": "Date",
    "value": "2012-12-21"
  },
  {
    "name": "Time",
    "value": "2006-10-07T12:06:56.568+01:00"
  },
  {
    "name": "URL link",
    "value": "https://urllink.com"
  },
  {
    "name": "File",
    "value": "https://urllink.com/files/document.pdf"
  },
  {
    "name": "Checkbox",
    "value": "true"
  },
  {
    "name": "Dropdown",
    "value": "ExactOption"
  },
  {
    "name": "MultipleDropdown",
    "value": "ExactOption1/-/ExactOption2"
  }
]
```

<aside class="warning">
The name of custom fields refers to their technical name, not their display name.
</aside>
The technical name of a custom field can be found in the custom field edit modal

| Options           | Type   | Description                                                                                                                                                                                    |
| ----------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Text              | String | Simple string like Text Area                                                                                                                                                                   |
| Dropdown          | String | The option must be written exactly as in the parameters, respecting the case                                                                                                                   |
| Multiple Dropdown | String | The option must be written exactly as in the parameters, respecting the case, for Multiple Answer you should enter Option1/-/Option2/-/Option3 in a string, "/-/" should separate each options |
| Date              | String | The date must be in a "YYYY-MM-DD" format string                                                                                                                                               |
| Time              | String | The time must be in a "YYYY-MM-DDTHH:MM:SS+01:00" format string                                                                                                                                |
| Checkbox          | String | The checkbox must be a string: "true" (checked) OR "false" (unchecked)                                                                                                                         |
| Number            | String | Number type should be a Number without other character                                                                                                                                         |
| File              | String | File must be a valid URL, and supported file extensions include: .pdf, .jpg, .jpeg, .png, .bmp, .gif, .docx, .doc, .msg, .odt, .rtf, .txt, .ppt, .pptx, .pptm, .csv, .xlsx                     |

### Destination

```json
"destination": {
  "reference": "destination_reference",
  "name": "France",
  "subdestination_reference": "subdestination_reference",
  "subdestination_name": "Paris"
}
```

| Property                 | Type   | Description                          |
| ------------------------ | ------ | ------------------------------------ |
| reference                | String | The reference of the destination     |
| name                     | String | Name of the destination              |
| subdestination_reference | String | The reference of the sub-destination |
| subdestination_name      | String | Name of the sub-destination          |

### Destinations

```json
"destinations": [
  {
    "reference": "destination_reference",
    "name": "France",
    "subdestinations": [
      {
        "reference": "subdestination_reference",
        "name": "Paris"
      }
    ]
  },
]
```

Each object represents a destination with its associated sub-destinations

| Property        | Type   | Description                                                                                     |
| --------------- | ------ | ----------------------------------------------------------------------------------------------- |
| reference       | String | The reference of the destination                                                                |
| name            | String | Name of the destination                                                                         |
| subdestinations | Array  | An array of JSON objects, each representing a sub-destination along with its name and reference |

### Invoices Amounts

```json
"forecast": {
  "is_automatic": true,
  "purchase": 0.0,
  "commission": 0.0,
  "vat_deducted": 0.0,
  "amount_ht": 1000.0
}
"actual": {
  "is_automatic": true,
  "purchase": null,
  "commission": null,
  "vat_deducted": null,
  "amount_ht": null
}
```

These objects provides insights into the invoice amounts, differentiating between actual figures and forecasts. Actual figures are available when the associated project is closed and the invoice is marked as `completed` or `paid`. Otherwise, `null` values are displayed.

| Property     | Type    | Description                                                                              |
| ------------ | ------- | ---------------------------------------------------------------------------------------- |
| is_automatic | Boolean | Automatically use the figures of the project to which this invoice/credit_note is linked |
| purchase     | Number  | Forecasted / Actual purchase                                                             |
| commission   | Number  | Forecasted / Actual commission                                                           |
| vat_deducted | Number  | Forecasted / Actual deductible VAT                                                       |
| amount_ht    | Number  | Forecasted / Actual amount excluding taxes                                               |

### Items

```json
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
    "is_optional": false
  }
]
```

The items array represents a collection of items associated with a step.
The fields `purchase_price`, `purchase_price_excl_taxes`, `sales_price`, and `sales_price_excl_taxes` **represent the price per unit of the item**. To calculate the total cost or total sales value for an item, multiply the unit price by the quantity.

**All prices returned by this endpoint are expressed in the project’s currency**. If the items are in different currencies, conversion must be performed using the exchange rates available in the project’s currency library.

| Property                  | Type    | Description                                                                                                             |
| ------------------------- | ------- | ----------------------------------------------------------------------------------------------------------------------- |
| reference                 | String  | The reference of the item                                                                                               |
| name                      | String  | Name of the item                                                                                                        |
| product_reference         | String  | The product reference associated with the item                                                                          |
| supplier_reference        | String  | The supplier reference associated with the item                                                                         |
| quantity                  | Number  | Quantity of the item                                                                                                    |
| purchase_price            | Number  | The unit purchase price of the item (including taxes)                                                                   |
| purchase_price_excl_taxes | Number  | The unit purchase price of the item (excluding taxes)                                                                   |
| sales_price               | Number  | The unit sales price of the item (including taxes)                                                                      |
| sales_price_excl_taxes    | Number  | The unit sales price of the item (excluding taxes)                                                                      |
| is_optional               | Boolean | Indicates whether the item is optional. **If true, the item does not contribute to the final purchase or sales price.** |

### Langs

```json
"langs": [
  {
    "lang": "american",
    "name": "My American product version",
    "short_description": "Short American Description",
    "long_description": "Long American Description"
  }
]
```

| Property          | Type   | Description                                      |
| ----------------- | ------ | ------------------------------------------------ |
| lang              | String | Language name in lower case                      |
| name              | String | Title of the object in this language             |
| short_description | String | Short description of the object in this language |
| long_description  | String | Long description of the object in this language  |

### Medias

Only the last 10 medias are returned in this object.

```json
"medias": {
  "data": [
    {
      "media_name": "img.jpeg",
      "path_full": "https://link-img.jpeg"
    }
  ],
  "size": 1
}
```

| Property   | Type   | Description                                                       |
| ---------- | ------ | ----------------------------------------------------------------- |
| media_name | String | Title of the media                                                |
| path_full  | String | Media URL. This is a pre-signed URL that expires after 30 minutes |

### Products <a name="products-two"></a>

Only the last 10 products are returned in this object.

```json
"products": {
  "data": [
    {
      "reference": "product_reference",
      "title": "2-bed room with breakfast"
    }
  ],
  "size": 1
}
```

| Property  | Type   | Description                  |
| --------- | ------ | ---------------------------- |
| reference | String | The reference of the product |
| title     | String | The title of the product     |

### Steps

The steps are sorted by their creation date, with the most recently created appearing first.

```json
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
        "is_optional": false
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
]
```

| Property      | Type   | Description                                                                                                                                                                   |
| ------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference     | String | The reference of the activity                                                                                                                                                 |
| type          | String | Type of the step `activity` `accommodation` `transport` or `extra`                                                                                                            |
| name          | String | Name of the step                                                                                                                                                              |
| category      | String | Category of the step                                                                                                                                                          |
| date_start    | String | Date of the beginning of this step, in a "YYYY-MM-DD HH:MM:SS" format string. If it's empty, the step has no dates.                                                           |
| date_end      | String | Date of the end of this step, in a "YYYY-MM-DD HH:MM:SS" format string. If it's empty, the step has no dates or no end.                                                       |
| people        | Number | Number of people                                                                                                                                                              |
| address       | JSON   | JSON object representing the address ([Address](#address)) of the step, including longitude and latitude. Note: Longitude and latitude are only returned by this step object. |
| description   | JSON   | JSON object representing the short and long description of the step                                                                                                           |
| items         | Array  | Array of JSON items ([Items](#items))                                                                                                                                         |
| medias        | Array  | Array of strings representing the images URLs associated with the step                                                                                                        |
| custom_fields | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                 |

### Travellers

```json
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
    "name": "Smith",
    "phone": "+1-555-987-6543",
    "custom_field1": "value1.2",
    "custom_field2": "value2.2"
  }
]
```

| Property      | Type   | Description                                                                     |
| ------------- | ------ | ------------------------------------------------------------------------------- | --- |
| email         | String | The email of the traveller                                                      |
| first_name    | String | The first name of the traveller                                                 |
| last_name     | String | The last name of the traveller                                                  |
| phone         | String | The phone number of the traveller                                               |     |
| custom_fields | String | The custom fields and the assigned values. Varies with number of custom fields. |

### Suppliers

Only the last 10 suppliers are returned in this object.

```json
"suppliers": {
  "data": [
    {
      "reference": "supplier_reference",
      "company_name": "The best hotel"
    }
  ],
  "size": 1
}
```

| Property     | Type   | Description                      |
| ------------ | ------ | -------------------------------- |
| reference    | String | The reference of the supplier    |
| company_name | String | The company name of the supplier |

### Tariffs

```json
"tariffs": [
  {
    "reference": "tariff_reference",
    "type": "default",
    "name": "",
    "purchase_price": 100.0,
    "margin_rate": 50.0,
    "sales_price": 200.0,
    "childs": []
  }
]
```

| Property       | Type   | Description                                                                           |
| -------------- | ------ | ------------------------------------------------------------------------------------- |
| reference      | String | An unique reference of this tariff                                                    |
| type           | String | A tariff can be `default`, `custom` OR `season`.                                      |
| name           | String | Name of the tariff (only season tariffs can have a name)                              |
| purchase_price | Number | Purchase price including taxes                                                        |
| margin_rate    | Number | The margin rate is based on the sales price                                           |
| sales_price    | Number | Sales price including taxes                                                           |
| childs         | Array  | Childs are sub-tariffs contained by this tariff (only season tariffs can have childs) |

### User

One of the following options: `None`, `Everyone`, `User Group` or the following JSON object corresponding to an active Ezus user of this account.

```json
"user": {
  "email": "tommy@e-corp.com",
  "first_name": "Tommy",
  "last_name": "Atkins",
  "agency": "Paris Agency"
}
```

| Property   | Type   | Description              |
| ---------- | ------ | ------------------------ |
| email      | String | Email of the user        |
| first_name | String | First name of the user   |
| last_name  | String | Last name of the user    |
| agency     | String | User's affiliated agency |

### Webhooks

```json
"webhooks": [
  {
    "reference": "webhook_reference",
    "endpoint": "webhook_endpoint",
    "events_types": "projects.created,clients.created",
    "is_active": "true",
    "last_called_at": "2023-01-01 01:01:01"
  }
]
```

| Property       | Type   | Description                                                           |
| -------------- | ------ | --------------------------------------------------------------------- |
| reference      | String | The reference of the webhook                                          |
| endpoint       | String | The endpoint URL of the webhook                                       |
| events_types   | String | The list of events for this endpoint ([Events](#events))              |
| is_active      | String | The status of the webhook `true` or `false`                           |
| last_called_at | String | The webhook last called date in a "YYYY-MM-DD hh:mm:ss" format string |

# Events

## Basic event information

This section provides an overview of the fundamental details related to a webhook event, including its unique identifier, type, creation timestamp, trigger source, and whether it's a duplication.

```json
{
  "id": "event_id",
  "object": "event",
  "type": "projects.created",
  "field": "",
  "old_value": "",
  "new_value": "",
  "created": 1234567890,
  "trigger_reference": "pro.ezus.io;projects-create",
  "is_duplication": false,
  "data": {...}
}
```

| Property          | Type    | Description                                                                                                                                                                    |
| ----------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| id                | String  | Unique identifier for the event                                                                                                                                                |
| object            | String  | The object of the event. The event's target object is currently limited to `event` but in the future, webhooks will become capable of being triggered by various other events. |
| type              | String  | The type of the event                                                                                                                                                          |
| field             | String  | This is only displayed if the event is an update. The name of the field that was updated.                                                                                      |
| old_value         | String  | This is only displayed if the event is an update. The previous value of the updated field.                                                                                     |
| new_value         | String  | This is only displayed if the event is an update. The updated field's new value.                                                                                               |
| created           | Number  | Time at which the object was created. Measured in seconds since the Unix epoch.                                                                                                |
| trigger_reference | String  | The trigger of the event. Indicates the source or origin from which the event was initiated.                                                                                   |
| is_duplication    | Boolean | Indicates whether the event originates from a duplication                                                                                                                      |
| data              | String  | Detailed information about the event. For more in-depth details, please refer to the sections below.                                                                           |

## projects.created

This event is triggered whenever a project is either created or duplicated.

```json
{
  "data": {
    "reference": "project_reference",
    "info_number": "202306001-P",
    "info_title": "Paris fashion week 2024",
    "trip_date_in": "2024-03-01",
    "trip_date_out": "2024-03-09",
    "trip_duration": "9",
    "trip_budget": "90000",
    "trip_people": "15"
  }
}
```

| Property      | Type   | Description                                                                                                          |
| ------------- | ------ | -------------------------------------------------------------------------------------------------------------------- |
| reference     | String | The reference of the project                                                                                         |
| info_number   | String | File number that appears in the project record. Not to be confused with reference                                    |
| info_title    | String | The title of the project                                                                                             |
| trip_date_in  | String | Date of the beginning of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates. |
| trip_date_out | String | Date of the end of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates.       |
| trip_duration | String | Number of days this project lasts                                                                                    |
| trip_budget   | String | Forecasted budget for the alternative (the one that is entered manually not the actual one)                          |
| trip_people   | String | Number of people                                                                                                     |

## projects.updated

This event is triggered whenever a project is updated. This event is triggered only by specific fields within projects, including: `info_title`, `info_stage`, `info_notes`, `info_number`, `currency`, `sales_manager`, and `projects_manager`.

```json
{
  "data": {
    "reference": "project_reference",
    "info_number": "202306001-P",
    "info_title": "Paris fashion week 2024"
  }
}
```

| Property    | Type   | Description                                                                       |
| ----------- | ------ | --------------------------------------------------------------------------------- |
| reference   | String | The reference of the project                                                      |
| info_number | String | File number that appears in the project record. Not to be confused with reference |
| info_title  | String | The title of the project                                                          |

## clients.created

This event is triggered whenever a client is created.

```json
{
  "data": {
    "reference": "client_reference",
    "info_number": "202306001-C",
    "type": "enterprise",
    "company_name": "MOKE INTERNATIONAL LIMITED",
    "email": "contact@moke-international.com",
    "first_name": "Jane",
    "last_name": "Doe",
    "gender": "Ms",
    "phone": "0101010101",
    "birth_date": "1986-09-17"
  }
}
```

| Property     | Type   | Description                                                                      |
| ------------ | ------ | -------------------------------------------------------------------------------- |
| reference    | String | The reference of the client                                                      |
| info_number  | String | File number that appears in the client record. Not to be confused with reference |
| type         | String | The type of the client can be either "enterprise" or "individual"                |
| company_name | String | Name of the company of the client                                                |
| email        | String | Email of the main contact of the client                                          |
| first_name   | String | First name of the main contact of the client                                     |
| last_name    | String | Last name of the main contact of the client                                      |
| gender       | String | `Mr`, `Ms` or `Undefined`                                                        |
| phone        | String | Phone number of the contact as a string                                          |
| birth_date   | String | Contact's date of birth in a "YYYY-MM-DD" format string                          |

## clients.updated

This event is triggered whenever a client is updated. This event is triggered only by specific fields within clients, including: `company_name`, `website`, `vat_number`, `company_number`, `info_notes`, `info_number` and `user`.

```json
{
  "data": {
    "reference": "client_reference",
    "info_number": "202306001-C",
    "company_name": "MOKE INTERNATIONAL LIMITED"
  }
}
```

| Property     | Type   | Description                                                                      |
| ------------ | ------ | -------------------------------------------------------------------------------- |
| reference    | String | The reference of the client                                                      |
| info_number  | String | File number that appears in the client record. Not to be confused with reference |
| company_name | String | Name of the client's company                                                     |

## invoices.finalized

This event is triggered whenever an invoice is finalized (its stage goes from `draft` to `completed`).

```json
{
  "data": {
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
    "amount_ttc": 1200.0,
    "amount_ht": 1000.0,
    "vat": 200.0,
    "project_reference": "project_reference",
    "url": "https://ezus.io/2023_101010.pdf",
    "alternative": {
      "sort_order": "0",
      "title": "Main Alternative"
    }
  }
}
```

| Property           | Type   | Description                                                                                                                                                                                                       |
| ------------------ | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference          | String | The reference of the invoice                                                                                                                                                                                      |
| info_number        | String | Title of the invoice                                                                                                                                                                                              |
| type               | String | Type of the invoice `invoice` or `credit_note`                                                                                                                                                                    |
| origin_reference   | String | This is only displayed if the type of the invoice is a `credit_note`. The reference of the origin invoice.                                                                                                        |
| origin_info_number | String | This is only displayed if the type of the invoice is a `credit_note`. Title of the origin invoice.                                                                                                                |
| stage              | String | Stage of the invoice `draft` `completed` or `paid`                                                                                                                                                                |
| created_date       | String | Date of the creation of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                    |
| send_date          | String | Sent date of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                               |
| due_date           | String | Due date of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                                |
| currency           | String | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>) |
| amount_ttc         | Number | Amount of the invoice including taxes                                                                                                                                                                             |
| amount_ht          | Number | Amount of the invoice excluding taxes                                                                                                                                                                             |
| vat                | Number | VAT amount of the invoice                                                                                                                                                                                         |
| project_reference  | String | The reference of the project linked to this invoice                                                                                                                                                               |
| url                | String | URL of the invoice `.pdf` file                                                                                                                                                                                    |
| alternative        | JSON   | JSON including: `sort_order` and `title`                                                                                                                                                                          |

## invoices_suppliers.attached

This event is triggered whenever a file is added to a supplier invoice.

```json
{
  "data": {
    "reference": "invoice_supplier_reference",
    "filename": "2023_101010.pdf",
    "created_date": "2023-10-10",
    "due_date": "2023-10-20",
    "currency": "EUR",
    "amount_ttc": 1200.0,
    "amount_ht": 1000.0,
    "vat": 200.0,
    "url": "https://ezus.io/2023_101010.pdf",
    "supplier_reference": "supplier_reference",
    "project_reference": "project_reference",
    "alternative": {
      "sort_order": "0",
      "title": "Main Alternative"
    }
  }
}
```

| Property           | Type   | Description                                                                                                                                                                                                       |
| ------------------ | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference          | String | The reference of the supplier invoice                                                                                                                                                                             |
| filename           | String | Filename of the supplier invoice                                                                                                                                                                                  |
| created_date       | String | Date of the creation of this supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                           |
| due_date           | String | Due date of this supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                                       |
| currency           | String | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>) |
| amount_ttc         | Number | Amount of the supplier invoice including taxes                                                                                                                                                                    |
| amount_ht          | Number | Amount of the supplier invoice excluding taxes                                                                                                                                                                    |
| vat                | Number | VAT amount of the supplier invoice                                                                                                                                                                                |
| url                | String | URL of the supplier invoice file                                                                                                                                                                                  |
| supplier_reference | String | The reference of the supplier linked to this supplier invoice                                                                                                                                                     |
| project_reference  | String | The reference of the project linked to this supplier invoice                                                                                                                                                      |
| alternative        | JSON   | JSON including: `sort_order` and `title`                                                                                                                                                                          |

# Dynamic Filters

Some filters can be marked as Dynamic-filter.
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

# Date Format

All dates in our API follow the `YYYY-MM-DD` format. Our database stores dates in Central European Time (CET/CEST - UTC+1/UTC+2).

### Date format specifications

- The API returns dates without specific time information
- Dates are stored and processed in Paris local time
- Date conversions automatically account for daylight saving time changes
- A date like `2024-12-01` represents the full day in Central European Time
  - `2024-11-30 23:30:00 UTC+0` will be considered as `2024-12-01` for instance

### Date filters

Date filters allow you to retrieve objects based on specific dates or date ranges.

**Single date filter**:

- Retrieves all objects for a specific date
- Format: `"YYYY-MM-DD"` (Year-Month-Day)
- Example: `"2024-12-01"` will return all objects dated December 1st, 2024

**Date range filter**:

- Retrieves objects within a specified date range
- Includes both start and end dates
- Format: `"start_date,end_date"`
- Example: `"2024-12-01,2024-12-31"` returns all objects from December 1st to December 31st, 2024

# Rate Limits

### Daily rate limit

For security reasons, the API allows you to make 10,000 calls per day period.
What does this "day period" mean? It means we limit to 10,000 requests per day from the first request made. This limit is called later "daily rate limit" and is reset once the day is over.

### Burst rate limit

Additionally, the API is protected by a burst rate limit. This means you can't make more than 100 requests per second.
