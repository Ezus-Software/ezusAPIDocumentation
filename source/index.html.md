---
title: Ezus API Reference

language_tabs: # must be one of https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers
  - shell: cURL
  - javascript

toc_footers:
  - <a href='https://ezus.io/' target="_blank">Documentation Powered by Ezus</a>

includes:
  - errors

search: true

code_clipboard: true

meta:
  - name: description
    content: Documentation for the Ezus API
---

# Introduction

Welcome to the Ezus API. The Ezus API is organized around <a href='https://en.wikipedia.org/wiki/Representational_state_transfer' target="_blank">REST</a>. It supplies a collection of HTTP methods that underpin Ezus main functionalities. Its main objective is to enable you to manage your Ezus projects, clients, catalog (suppliers/products/packages) and invoices programmatically.

If you need an overview of some common use cases that you can setup with our API you can look at our help center section <a href='https://help.ezus.io/en/collections/3016686-integrations' target="_blank">Integrations</a>

If you want to dive into the list of available methods, you've come to the right place. This documentation provides a technical description (reference) for each method in the left-hand section, as well as code examples in the right-hand section.

Each method has its own specification, but as a general rule:

For any request, you must provide <a href='https://swagger.io/docs/specification/describing-parameters/#header-parameters' target="_blank">header parameters</a>

For GET requests, you must also provide <a href='https://swagger.io/docs/specification/describing-parameters/#query-parameters' target="_blank">query parameters</a>

For POST/PUT/DELETE requests, you must also provide <a href='https://swagger.io/docs/specification/2-0/describing-request-body' target="_blank">body parameters</a> structured in a JSON payload (application/json)

<aside class="warning">
Quick tip: You can <a href="https://ezus-public-documentation.s3.eu-west-1.amazonaws.com/ezus_api_postman.json?attachmentlinks=true"  target="_blank" download>download here</a> a Postman export of this API
</aside>

# Authentication

## Principles

Ezus authentication scheme is based on <a href='https://swagger.io/docs/specification/authentication/api-keys/' target="_blank">API Keys</a> and <a href='https://swagger.io/docs/specification/authentication/bearer-authentication/' target="_blank">Bearer authentication</a>. So, you will need 2 things to be able to interact with our API:

- An Ezus API key
- User credentials of an Ezus account

<span style="text-decoration:underline">API key</span>

Ezus uses API keys to control access to its API. To get `<YOUR_API_KEY>`, ask your account manager. The Ezus API requires this API key to be included in the x-api-key header parameter of all your requests.

`x-api-key: <YOUR_API_KEY>`

<span style="text-decoration:underline">Bearer authentication</span>

After calling the /login endpoint with valid credentials, a bearer token will be returned to you: `<YOUR_TOKEN>`. This token is then valid for 12 hours. The Ezus API requires this bearer token to be included in the Authorization header parameter of all subsequent requests.

`Authorization: Bearer <YOUR_TOKEN>`

## POST login

> To authenticate, you will need first to call our /login endpoint:

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

> It returns a JSON object structured like this:

```json
{
  "message": "ok",
  "error": "false",
  "token": "<YOUR_TOKEN>"
}
```

> In subsequent requests, be sure to replace `<YOUR_TOKEN>` in the Authorization header parameter with the token returned to you here.

### HTTP Endpoint

`POST https://api.ezus.app/login`

### Header parameters

| Parameter | Type   | Description                                                 |
| --------- | ------ | ----------------------------------------------------------- |
| x-api-key | String | <span style="color:red">(Required)</span> Your Ezus API key |

### Body parameters (application/json)

| Parameter | Type   | Description                                                     |
| --------- | ------ | --------------------------------------------------------------- |
| email     | String | <span style="color:red">(Required)</span> Your account email    |
| password  | String | <span style="color:red">(Required)</span> Your account password |

### Response

JSON object indicating whether an error has occurred during the process and, if so, the associated message. If there is no error, it also returns a `token`: you will need to store this token for future API requests.

# Projects

## GET project

It retrieves information for a project record in Ezus. You must specify to the Ezus API which project you wish to retrieve, by indicating its appropriate reference in your query parameter.

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

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "reference": "project_reference",
  "info_title": "Paris fashion week 2024",
  "info_stage": "Confirmed",
  "info_notes": "Jane has verbally confirmed our quotation",
  "info_number": "202306001-P",
  "currency": "€",
  "sales_manager": {
    "email": "travel-design@e-corp.com",
    "first_name": "Alice",
    "last_name": "Tate"
  },
  "project_manager": {
    "email": "no-reply@e-corp.com",
    "first_name": "Joe",
    "last_name": "Shmoe"
  },
  "alternatives": [
    {
      "alternative_title": "Main Alternative",
      "budget_actual": "88750",
      "trip_budget": "90000",
      "trip_people": "15",
      "trip_date_in": "2024-03-01",
      "trip_date_out": "2024-03-09",
      "trip_duration": "9",
      "trip_destination": "France",
      "trip_subdestination": "Paris",
      "client": {
        "reference": "client_reference",
        "type": "enterprise",
        "company_name": "MOKE INTERNATIONAL LIMITED",
        "first_name": "Jane",
        "last_name": "Doe",
        "email": "contact@moke-international.com"
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

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter | Type   | Description                                                                                 |
| --------- | ------ | ------------------------------------------------------------------------------------------- |
| reference | String | <span style="color:red">(Required)</span> The reference of the project you wish to retrieve |

### Response

JSON object containing the project information.

| Property        | Type   | Description                                                                                      |
| --------------- | ------ | ------------------------------------------------------------------------------------------------ |
| reference       | String | The reference of the project you wish to retrieve                                                |
| info_title      | String | The title of the project                                                                         |
| info_stage      | String | The stage of the project (Confirmed, Received, Paid...)                                          |
| info_notes      | String | Notes on the project                                                                             |
| info_number     | String | File number that appears at the bottom of the project record. Not to be confused with reference! |
| currency        | String | Default currency of the project                                                                  |
| sales_manager   | JSON   | JSON object user ([User](#user))                                                                 |
| project_manager | JSON   | JSON object user ([User](#user))                                                                 |
| alternatives    | Array  | Array of JSON alternatives ([Alternatives](#alternatives))                                       |
| custom_fields   | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                    |

## POST projects-upsert

It updates a project record if the provided reference does match one of the project references in your account, otherwise it creates a new project record with the provided reference (or with a random one if no reference is provided).

```shell
curl --location 'https://api.ezus.app/projects-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
    "reference": "project_reference",
    "info_title": "Paris fashion week 2024",
    "trip_budget": "90000",
    "trip_people": "15",
    "trip_date_in": "2023-03-01",
    "trip_date_out": "2023-03-09",
    "sales_manager_email": "travel-design@e-corp.com",
    "client_reference": "client_reference",
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
  info_title: "Paris fashion week 2024",
  trip_budget: "90000",
  trip_people: "15",
  trip_date_in: "2023-03-01",
  trip_date_out: "2023-03-09",
  sales_manager_email: "travel-design@e-corp.com",
  client_reference: "client_reference",
  custom_fields: [{ name: "field_name", value: "field_value" }],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/projects-upsert", body, headers);
```

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Project successfully created",
  "reference": "project_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/projects-upsert`

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter           | Type   | Description                                                                                                                                                                                                                                                                                                               |
| ------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference           | String | If provided, the unique reference associated to the project you want to update or create (in case the one you provided has never been used). If no reference is provided, a project will be created with a random one.                                                                                                    |
| info_title          | String | Title of the project. This parameter is required if you create a new project                                                                                                                                                                                                                                              |
| trip_budget         | Number | Forecasted budget for the project                                                                                                                                                                                                                                                                                         |
| trip_people         | Number | Number of people in the project. The number of people can be added when a project is created, but cannot be updated via API in an existing project.                                                                                                                                                                       |
| trip_date_in        | Date   | Date of the beginning of the project in a "YYYY-MM-DD" format string. If not provided or if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1 day and trip_date_in as today. A date can be added at project creation via API, but cannot be updated via API. |
| trip_date_out       | Date   | Date of the end of the project in a "YYYY-MM-DD" format string. If not provided or if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1 day and trip_date_out as today. A date can be added at project creation via API, but cannot be updated via API.      |
| sales_manager_email | Email  | Email of the Ezus user that will be set as the sales manager of the project. By default, if no sales manager is provided or the provided email do not match any user on this account, the project will be assigned to None                                                                                                |
| client_reference    | String | This can be a reference or the email of a client already created in this Ezus account. By default, the project will not be linked to any client. You can add client at the creation but you can't change client by API                                                                                                    |
| custom_fields       | JSON   | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                                                                                                             |

### Response

JSON object indicating whether an error has occurred during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the project later on.

## POST projects-documents-create

It creates a PDF document based on the link you provide within the project using project_reference as its reference.

```shell
curl --location 'https://api.ezus.app/projects-documents-create' \
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
  link: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/projects-documents-create", body, headers);
```

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "message": "ok"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/projects-documents-create`

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter         | Type   | Description                                                                                                          |
| ----------------- | ------ | -------------------------------------------------------------------------------------------------------------------- |
| project_reference | String | <span style="color:red">(Required)</span> The project reference in which you want to create a document               |
| title             | String | Title of the document                                                                                                |
| link              | Link   | <span style="color:red">(Required)</span> URL of the document (only PDF). Make sure this link is publicly accessible |

### Response

JSON object indicating whether an error has occurred during the process and, if so, the associated message.

# Clients

## GET client

It retrieves information for a client record in Ezus. You must specify to the Ezus API which client you wish to retrieve, by indicating its appropriate reference in your query parameter.

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

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "reference": "client_reference",
  "type": "enterprise",
  "company_name": "MOKE INTERNATIONAL LIMITED",
  "website": "www.moke_ltd.com",
  "first_name": "Jane",
  "last_name": "Doe",
  "email": "contact@moke-international.com",
  "activity": "Software",
  "vat_number": "GB 240-635-038",
  "siret": "09728676",
  "info_profile": "Prospect",
  "info_origin": "Adwords",
  "info_notes": "This prospect looks interesting to follow",
  "info_number": "202306001-C",
  "user": {
    "email": "tommy@e-corp.com",
    "first_name": "Tommy",
    "last_name": "Atkins"
  },
  "address": {
    "label": "58 Rue de Paradis",
    "zip": "75010",
    "city": "Paris",
    "country": "France"
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
        "email": "contact@moke-international.com",
        "first_name": "Jane",
        "last_name": "Doe",
        "title": "CEO",
        "gender": "Ms",
        "phone": "0101010101",
        "phone2": "0606060606",
        "birth_date": "1986-09-17"
      }
    ],
    "size": 1
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

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter | Type   | Description                                                                                |
| --------- | ------ | ------------------------------------------------------------------------------------------ |
| reference | String | <span style="color:red">(Required)</span> The reference of the client you wish to retrieve |

### Response

JSON object containing the client information.

| Property      | Type   | Description                                                                                                                                                           |
| ------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference     | String | The reference of the client you wish to retrieve                                                                                                                      |
| type          | String | The type of the client can be either "enterprise" or "individual"                                                                                                     |
| company_name  | String | Name of the company of the client                                                                                                                                     |
| website       | String | Website of the client                                                                                                                                                 |
| first_name    | String | First name of the main contact of the client                                                                                                                          |
| last_name     | String | Last name of the main contact of the client                                                                                                                           |
| email         | String | Email of the main contact of the client                                                                                                                               |
| activity      | String | Activity of the client (only for enterprise)                                                                                                                          |
| vat_number    | String | VAT number of the client (only for enterprise)                                                                                                                        |
| siret         | String | Company registration number of the client (only for enterprise)                                                                                                       |
| info_profile  | String | Profile of the client                                                                                                                                                 |
| info_origin   | String | Source of the client                                                                                                                                                  |
| info_notes    | String | Notes on the client                                                                                                                                                   |
| info_number   | String | File number that appears at the bottom of the client record. Not to be confused with reference!                                                                       |
| user          | JSON   | JSON object user ([User](#user))                                                                                                                                      |
| address       | JSON   | JSON object address` ([Address](#address))                                                                                                                            |
| projects      | JSON   | Projects linked to the client (return only the 10 first projects). JSON object containing `data` (Array of JSON objects containing `reference`, `info_title`), `size` |
| contacts      | Array  | Array of JSON contacts ([Contacts](#contacts))                                                                                                                        |
| custom_fields | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                         |

## POST clients-upsert

It updates a client record if the provided reference (or the email) does match one of the client references in your account, otherwise it creates a new client record with the provided reference (or with a random one if no reference is provided). Note that for this endpoint, the email of the client can also be used as a primary key for the upsert.

```shell
curl --location 'https://api.ezus.app/clients-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
    "reference": "client_reference",
    "company_name": "MOKE INTERNATIONAL LIMITED",
    "website": "www.moke_ltd.com",
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
  company_name: "MOKE INTERNATIONAL LIMITED",
  website: "www.moke_ltd.com",
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

> It returns a JSON object structured like this:

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

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter     | Type   | Description                                                                                                                                                                                                                                                             |
| ------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference     | String | If provided, the unique reference associated to the client you want to update or create (in case the one you provided has never been used). If no reference is provided, a client will be created with a random one.                                                    |
| company_name  | String | <span style="color:red">(Required)</span> Set a company name - If company name is empty, the client will be set as an individual and the name of the client = name of the contact and if the company name is not empty, the name of the client will be the company name |
| website       | String | Website of the client                                                                                                                                                                                                                                                   |
| user          | Email  | Email of the Ezus user that will be set as the owner of the client. By default, if no owner is provided or the provided email do not match any user on this account, the owner will be assigned to everyone                                                             |
| contact       | JSON   | Contact is a single JSON element and email is needed. Note that only one contact can be upsert this way (the main contact of the client) ([Contacts](#contacts)) To reset the main contact, you can put `'0'`                                                           |
| address       | JSON   | JSON object address ([Address](#address)) To reset the address, you can put `'0'`                                                                                                                                                                                       |
| custom_fields | JSON   | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                                                           |

### Response

JSON object indicating whether an error has occurred during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the client later on.

# Suppliers

## GET supplier

It retrieves information for a supplier record in Ezus. You must specify to the Ezus API which supplier you wish to retrieve, by indicating its appropriate reference in your query parameter.

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

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "reference": "supplier_reference",
  "company_name": "The best hotel",
  "website": "www.the_best_hotel.com",
  "capacity": "200",
  "type": "accom, activity",
  "info_notes": "Emily confirmed: this hotel really is the best in town.",
  "info_number": "202306001-S",
  "visual_url": "",
  "user": {
    "email": "travel-design@e-corp.com",
    "first_name": "Alice",
    "last_name": "Tate"
  },
  "address": {
    "label": "58 Rue de Paradis",
    "zip": "75010",
    "city": "Paris",
    "country": "France"
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
        "email": "bob@proton.me",
        "first_name": "Bob",
        "last_name": "Morane",
        "title": "Project Manager",
        "gender": "Mr",
        "phone": "0202020202",
        "phone2": "0707070707"
      }
    ],
    "size": 1
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
  "langs": [
    {
      "lang": "american",
      "name": "The best hotel",
      "short_description": "The best hotel: Parisian luxury redefined.",
      "long_description": "Welcome to The best hotel, a luxurious Parisian hotel nestled in the heart of the City of Lights. Indulge in timeless elegance, where opulent suites, Michelin-starred dining, and breathtaking views of the Eiffel Tower create an unforgettable experience. Immerse yourself in the rich history and artistry of Paris, while our impeccable service caters to your every desire. Discover the epitome of sophistication at The best hotel where dreams become reality."
    },
    {
      "lang": "spanish",
      "name": "The best hotel",
      "short_description": "Luz y lujo en París: The best hotel.",
      "long_description": "Bienvenido a The best hotel, un lujoso hotel parisino ubicado en el corazón de la Ciudad de las Luces. Disfruta de la elegancia atemporal, donde suites opulentas, gastronomía de estrella Michelin y vistas impresionantes de la Torre Eiffel crean una experiencia inolvidable. Sumérgete en la rica historia y artesanía de París, mientras nuestro servicio impecable atiende cada uno de tus deseos. Descubre la cúspide de la sofisticación en The best hotel donde los sueños se hacen realidad."
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

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter | Type   | Description                                                                                  |
| --------- | ------ | -------------------------------------------------------------------------------------------- |
| reference | String | <span style="color:red">(Required)</span> The reference of the supplier you wish to retrieve |

### Response

JSON object containing the supplier information.

| Property      | Type   | Description                                                                                                                                                  |
| ------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| reference     | String | The reference of the supplier you wish to retrieve                                                                                                           |
| company_name  | String | Name of the company of the supplier                                                                                                                          |
| website       | String | Website of the supplier                                                                                                                                      |
| capacity      | String | Maximum number of people for which the supplier can be used                                                                                                  |
| type          | String | 3 options: `accom`, `activity`, `transport`. A supplier can have no type, 1 type or several types. In this case, the different types are separated by commas |
| info_notes    | String | Notes on the supplier                                                                                                                                        |
| info_number   | String | File number that appears at the bottom of the supplier record. Not to be confused with reference!                                                            |
| visual_url    | String | URL of the Google Slides visual linked to the supplier                                                                                                       |
| user          | JSON   | JSON object user ([User](#user))                                                                                                                             |
| address       | JSON   | JSON object address ([Address](#address))                                                                                                                    |
| products      | JSON   | JSON object products ([Products](#products))                                                                                                                 |
| contacts      | Array  | Array of JSON contacts ([Contacts](#contacts))                                                                                                               |
| medias        | JSON   | JSON object medias ([Medias](#medias))                                                                                                                       |
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
    "company_name": "The best hotel",
    "website": "www.the_best_hotel.com",
    "capacity": "200",
    "user": "sam@proton.me",
    "type": "accom, activity",
    "contact": {
        "email": "bob@proton.me",
        "first_name": "Bob",
        "last_name": "Morane",
        "title": "Project Manager",
        "gender": "Mr",
        "phone": "0606060606",
        "phone2": "0707070707",
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
  reference: "supplier_reference",
  company_name: "The best hotel",
  website: "www.the_best_hotel.com",
  capacity: 200,
  user: "sam@proton.me",
  type: "accom, activity"
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
  custom_fields: [
    { name: "field_name", value: "field_value" }
  ],
};
const headers = { "x-api-key": "<YOUR_API_KEY>", "Authorization": "Bearer <YOUR_TOKEN>" };

axios.post(baseUrl + "/suppliers-upsert", body, headers);
```

> It returns a JSON object structured like this:

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

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter     | Type   | Description                                                                                                                                                                                                                                      |
| ------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --- |
| reference     | String | If provided, the unique reference associated to the supplier you want to update or create (in case the one you provided has never been used). If no reference is provided, a supplier will be created with a random one.                         |
| company_name  | String | Name of the supplier. This parameter is required if you create a new supplier                                                                                                                                                                    |     |
| website       | String | Website of the supplier                                                                                                                                                                                                                          |
| capacity      | Number | Maximum number of people for which the supplier can be used. Leave blank `''` if not relevant                                                                                                                                                    |
| user          | Email  | Email of the Ezus user that will be set as the owner of the supplier. By default, if no owner is provided or the provided email do not match any user on this account, the owner will be assigned to everyone                                    |
| type          | String | Either `undefined` or a combination of these 3 options: `accom`, `activity`, `transport`. You can select multiple options by separating them with comas ("accom, activity" for instance). Enter "undefined" if you want to reset this parameter. |
| contact       | JSON   | Contact is a single JSON and email is needed. Note that only one contact can be upsert this way (the main contact of the supplier) ([Contact](#contacts)) To reset the main contact, you can put `'0'`                                           |
| address       | JSON   | JSON object address ([Address](#address)) To reset the address, you can put `'0'`                                                                                                                                                                |
| custom_fields | JSON   | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                                    |

### Response

JSON object indicating whether an error has occurred during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the supplier later on.

# Products

## GET product

It retrieves information for a product record in Ezus. You must specify to the Ezus API which product you wish to retrieve, by indicating its appropriate reference in your query parameter.

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

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "reference": "product_reference",
  "title": "2-bed room with breakfast",
  "capacity": "2",
  "quantity": "1",
  "vat_regime": "margin",
  "vat_rate": 20.0,
  "currency": "EUR",
  "budget_text": "Option",
  "budget_form": "Important",
  "budget_variable": "Display",
  "info_number": "202306001-PR",
  "visual_url": "",
  "supplier": {
    "reference": "supplier_reference",
    "company_name": "The best hotel"
  },
  "package": {
    "reference": "package_reference",
    "title": "packages_title"
  },
  "commission": {
    "commission_mode": "purchase",
    "commission_regime": "percent",
    "value": "10"
  },
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

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter | Type   | Description                                                                                 |
| --------- | ------ | ------------------------------------------------------------------------------------------- |
| reference | String | <span style="color:red">(Required)</span> The reference of the product you wish to retrieve |

### Response

JSON object containing the product information.

| Property        | Type   | Description                                                                                                                                                                                                                              |
| --------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference       | String | The reference of the product you wish to retrieve                                                                                                                                                                                        |
| title           | String | Name of the product                                                                                                                                                                                                                      |
| capacity        | Number | Maximum number of people for which the product can be used                                                                                                                                                                               |
| quantity        | String | The default number for this product when it is added to a project. It can either be a Number or one of these letters (`P` = Number of people in the project, `D` = Number of days in the project, `N` = Number of nights in the project) |
| vat_regime      | String | Can be either `classic` (common law VAT), `margin` (VAT on the margin), `none` (Non applicable VAT)                                                                                                                                      |
| vat_rate        | Number | Default % of the VAT on the product                                                                                                                                                                                                      |
| currency        | String | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>)                        |
| budget_text     | String | This is an empty string `""` if the product is not marked as an option in the budget, otherwise it is the custom label of the option to which the product is associated                                                                  |
| buget_form      | String | `Important`, `Normal`, `Low` represent how the product will be highlight on the budget By Default                                                                                                                                        |
| budget_variable | String | `Display`, `Do not Display`, this option tells if the product will be displayed or not in the budget                                                                                                                                     |
| info_number     | String | File number that appears at the bottom of the product record. Not to be confused with reference!                                                                                                                                         |
| visual_url      | String | URL of the Google Slides visual linked to the product                                                                                                                                                                                    |
| supplier        | JSON   | JSON object containing `reference`, `company_name`                                                                                                                                                                                       |
| package         | JSON   | JSON object containing `reference`, `title`                                                                                                                                                                                              |
| commission      | JSON   | JSON object containing `value`, `commission_regime` ("percent" or "amount"), `commission_mode` ("sales" or "purchase")`                                                                                                                  |
| medias          | JSON   | JSON object medias ([Medias](#medias))                                                                                                                                                                                                   |
| langs           | Array  | Array of JSON langs ([Langs](#langs))                                                                                                                                                                                                    |
| tariffs         | Array  | Array of JSON tariffs ([Tariffs](#tariffs))                                                                                                                                                                                              |
| custom_fields   | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                            |

## POST products-upsert

It updates a product record if the provided reference does match one of the product references in your account, otherwise it creates a new product record with the provided reference (or with a random one if no reference is provided).

```shell
curl --location 'https://api.ezus.app/products-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "reference": "product_reference",
    "title": "2-bed room with breakfast",
    "quantity": "1",
    "capacity": "2",
    "supplier_reference": "supplier_reference",
    "package_reference": "package_reference",
    "purchase_price": "42",
    "sales_price": "84",
    "vat_regime": "none",
    "vat_rate": 20,
    "currency": "USD",
    "commission": {
        "commission_mode": "purchase",
        "commission_regime": "percent",
        "value": 10
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
  reference: "product_reference",
  title: "2-bed room with breakfast",
  quantity: "1",
  capacity: 2,
  supplier_reference: "supplier_reference",
  package_reference: "package_reference",
  purchase_price: "42",
  sales_price: "84",
  vat_regime: "none",
  vat_rate: "20",
  currency: "USD",
  commission: {
    commission_mode: "purchase",
    commission_regime: "percent",
    value: "10",
  },
  custom_fields: [{ name: "field_name", value: "field_value" }],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/products-upsert", body, headers);
```

> It returns a JSON object structured like this:

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

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter          | Type   | Description                                                                                                                                                                                                                                                             |
| ------------------ | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference          | String | If provided, the unique reference associated to the product you want to update or create (in case the one you provided has never been used). If no reference is provided, a product will be created with a random one.                                                  |
| title              | String | Title of your product. This parameter is required if you create a new product                                                                                                                                                                                           |
| quantity           | String | The default number for this product when it is added to a project. It can either be a Number or one of these letters (`P` = Number of people in the project, `D` = Number of days in the project, `N` = Number of nights in the project)                                |
| capacity           | Number | Maximum number of people for which the product can be used. Leave blank `''` if not relevant                                                                                                                                                                            |
| supplier_reference | String | If you give an adequate supplier reference, the product will be added in this supplier. If you want to update the supplier's product to None, you must enter 0.                                                                                                         |
| package_reference  | String | If you give an adequate package reference, the product will be added in this package. If you want to update the package's product to None, you must enter 0.                                                                                                            |
| purchase_price     | Number | Purchase price as a number                                                                                                                                                                                                                                              |
| sales_price        | Number | Sales price as a number                                                                                                                                                                                                                                                 |
| vat_regime         | String | Can be either `classic` (common law VAT), `margin` (VAT on the margin), `none` (Non applicable VAT). If empty or not provided, your default account VAT regime will be set                                                                                              |
| vat_rate           | Number | Default VAT rate. If empty or not provided, your default account VAT rate will be set                                                                                                                                                                                   |
| currency           | String | The ISO 4217 code of the currency of this product (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to Doc</a>). If empty or not provided, your default account currency will be set |
| commission         | JSON   | JSON object containing `value`, `commission_regime` ("percent" or "amount"), `commission_mode` ("sales" or "purchase")                                                                                                                                                  |
| custom_fields      | JSON   | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                                                           |

### Response

JSON object indicating whether an error has occurred during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the product later on.

# Packages

## GET package

It retrieves information for a package record in Ezus. You must specify to the Ezus API which package you wish to retrieve, by indicating its appropriate reference in your query parameter.

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

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "reference": "package_reference",
  "title": "The best package",
  "capacity": "2",
  "info_notes": "A classical day in Paris",
  "info_number": "202306001-PK",
  "visual_url": "",
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

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter | Type   | Description                                                                                 |
| --------- | ------ | ------------------------------------------------------------------------------------------- |
| reference | String | <span style="color:red">(Required)</span> The reference of the package you wish to retrieve |

### Response

JSON object containing the package information.

| Property      | Type   | Description                                                                                      |
| ------------- | ------ | ------------------------------------------------------------------------------------------------ |
| reference     | String | The reference of the package you wish to retrieve                                                |
| title         | String | Name of the package                                                                              |
| capacity      | String | Maximum number of people for which the package can be used                                       |
| info_notes    | String | Notes on the package                                                                             |
| info_number   | String | File number that appears at the bottom of the package record. Not to be confused with reference! |
| visual_url    | String | URL of the Google Slides visual linked to the package                                            |
| products      | JSON   | JSON object products ([Products](#products))                                                     |
| suppliers     | JSON   | JSON object suppliers ([Suppliers](#suppliers))                                                  |
| medias        | JSON   | JSON object medias ([Medias](#medias))                                                           |
| langs         | Array  | Array of JSON langs ([Langs](#langs))                                                            |
| custom_fields | Array  | Array of JSON custom fields [Custom fields](#custom-fields)                                      |

## POST packages-upsert

It updates a package record if the provided reference does match one of the package references in your account, otherwise it creates a new package record with the provided reference (or with a random one if no reference is provided).

```shell
curl --location 'https://api.ezus.app/packages-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "reference": "package_reference",
    "title": "The best package",
    "capacity": "2",
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
  title: "The best package",
  capacity: "2",
  custom_fields: [{ name: "field_name", value: "field_value" }],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/packages-upsert", body, headers);
```

> It returns a JSON object structured like this:

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

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter     | Type   | Description                                                                                                                                                                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference     | String | If provided, the unique Ezus Reference associated to the package you want to update or create (in case the one you provided has never been used). If no reference is provided, a package will be created with a random one. |
| title         | String | This parameter is required if you create a new package                                                                                                                                                                      |
| capacity      | Number | Maximum number of people for which the package can be used . Leave blank `''` if not relevant                                                                                                                               |
| custom_fields | JSON   | Array of JSON custom fields [Custom fields](#custom-fields)                                                                                                                                                                 |

### Response

JSON object indicating whether an error has occurred during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the package later on.

# Invoices

## GET invoices

It returns a list of your invoices. The invoices are returned sorted by creation date, with the most recent invoices appearing first. You can specify filters as query parameters to narrow down your search. The list of invoices returned is paginated (50 per 50): to call the 50 next items in the list, call the route with the `next_token` query parameter.

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

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "next_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZW51X211bG11bCI6Im9wdDEiLCJudW1iZXIiOiIyMDAwMCIsInBhZ2UiOjEsInBlcnNvX2ludm9pY2UiOiJHRyIsInN0YWdlIjoicGFpZCIsIl9fdGltZSI6MTY5NzQ0NjEzNX0.jEs7aL3UzCNrjzwDtAUbq4Rt4T64nu2LBYC0NnQhHiA",
  "size": 338,
  "data_size": 50,
  "page": 1,
  "invoices": [
    {
      "error": "false",
      "reference": "invoice_reference",
      "info_number": "2023_101010",
      "url": "https://ezus.io/2023_101010.pdf",
      "stage": "completed",
      "type": "credit_note",
      "origin_reference": "origin_reference",
      "origin_info_number": "2023_101009",
      "created_date": "2023-10-10",
      "send_date": "2023-10-10",
      "due_date": "2023-10-10",
      "amount_ttc": 1200.0,
      "amount_ht": 1000.0,
      "vat": 200.0,
      "currency": "EUR",
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
      "project": {
        "reference": "project_reference",
        "info_title": "Paris fashion week 2024",
        "info_stage": "Confirmed",
        "info_number": "202306001-P",
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
      }
    },...
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/invoices`

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter      | Type   | Description                                                                                                                                                          |
| -------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token     | String | Specify this parameter if you want to retrieve the following elements of a given list query. If this parameter is filled, other parameters are ignored.              |
| stage          | String | You can filter your search only by invoices that are in a specific stage. The stage can be `paid`, `completed` or `draft`.                                           |
| technical_name | String | You can also filter invoices by one of their custom fields by adding the `technical_name` of the custom field as a query parameter and the desired value as a value. |

### Response

JSON object containing the invoice information.

| Property  | Type   | Description                                                                                                              |
| --------- | ------ | ------------------------------------------------------------------------------------------------------------------------ |
| error     | String | false if no errors occurs else true                                                                                      |
| token     | String | A token will be returned if all invoices have not been returned. Use it in another call to access the following invoices |
| size      | Number | The total number of invoices available with these filters                                                                |
| data_size | Number | Number of invoices returned                                                                                              |
| page      | Number | The page number                                                                                                          |
| invoices  | Array  | An array of JSON containing all the invoices returned formated like GET `invoice` ([GET invoice](#get-invoice))          |

## GET invoice

It retrieves information for an invoice record in Ezus. You must specify to the Ezus API which invoice you wish to retrieve, by indicating its appropriate reference in your query parameter.

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

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "reference": "invoice_reference",
  "info_number": "2023_101010",
  "url": "https://ezus.io/2023_101010.pdf",
  "stage": "draft",
  "type": "credit_note",
  "origin_reference": "origin_reference",
  "origin_info_number": "2023_101009",
  "created_date": "2023-10-10",
  "send_date": "2023-10-10",
  "due_date": "2023-10-10",
  "amount_ttc": 1200.0,
  "amount_ht": 1000.0,
  "vat": 200.0,
  "currency": "EUR",
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
  "project": {
    "reference": "project_reference",
    "info_title": "Paris fashion week 2024",
    "info_stage": "Confirmed",
    "info_number": "202306001-P",
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
  }
}
```

### HTTP Endpoint

`GET https://api.ezus.app/invoice`

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter | Type   | Description                                                                                 |
| --------- | ------ | ------------------------------------------------------------------------------------------- |
| reference | String | <span style="color:red">(Required)</span> The reference of the invoice you wish to retrieve |

### Response

JSON object containing the invoice information.

| Property           | Type   | Description                                                                                                                                                                                                       |
| ------------------ | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference          | String | The reference of the invoice you wish to retrieve                                                                                                                                                                 |
| info_number        | String | Title of the invoice                                                                                                                                                                                              |
| url                | String | URL of the invoice `.pdf` file                                                                                                                                                                                    |
| stage              | String | Stage of the invoice `draft` `completed` or `paid`                                                                                                                                                                |
| type               | String | Type of the invoice `invoice` or `credit_note`                                                                                                                                                                    |
| origin_reference   | String | This is only displayed if the type of the invoice is a `credit_note`. The reference of the origin invoice.                                                                                                        |
| origin_info_number | String | This is only displayed if the type of the invoice is a `credit_note`. Title of the origin invoice.                                                                                                                |
| created_date       | String | Date of the creation of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                    |
| send_date          | String | Sent date of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                               |
| due_date           | String | Due date of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                                |
| amount_ttc         | Number | Amount of the invoice including taxes                                                                                                                                                                             |
| amount_ht          | Number | Amount of the invoice excluding taxes                                                                                                                                                                             |
| vat                | Number | VAT amount of the invoice                                                                                                                                                                                         |
| currency           | String | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>) |
| forecast           | JSON   | JSON object forecast ([Invoices Amounts](#invoices-amounts))                                                                                                                                                      |
| actual             | JSON   | JSON object actual ([Invoices Amounts](#invoices-amounts))                                                                                                                                                        |
| project            | JSON   | JSON including: `reference`, `info_title`, `info_stage`, `info_number`, `currency` and `is_closed`                                                                                                                |
| alternative        | JSON   | JSON including: `sort_order` and `title`                                                                                                                                                                          |
| client             | JSON   | JSON including: `reference`, `type` (enterprise or individual), `company_name`, `first_name`, `last_name` and `email`                                                                                             |

## POST invoices-update

It updates an invoice record if the provided reference does match one of the invoices references in your account.

```shell
curl --location 'https://api.ezus.app/invoices-update' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
    "reference": "invoice_reference",
    "stage": "paid",
    "send_date": "2023-09-29",
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
  send_date: "2023-09-29",
  due_date: "2023-09-29",
  custom_fields: [{ name: "field_name", value: "field_value" }],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/invoices-update", body, headers);
```

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "message": "ok",
  "reference": "invoice_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/invoices-update`

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter     | Type   | Description                                                                                           |
| ------------- | ------ | ----------------------------------------------------------------------------------------------------- |
| reference     | String | The reference of the invoice you want to update                                                       |
| stage         | String | stage can be updated only if the invoice is a draft, the stage can be `completed` or `paid`           |
| send_date     | String | send_date can be updated only if the invoice is a draft, send_date can be only on format `YYYY-MM-DD` |
| due_date      | String | due_date can be updated only if the invoice is a draft, due_date can be only on format `YYYY-MM-DD`   |
| custom_fields | JSON   | Array of JSON custom fields ([Custom fields](#custom-fields))                                         |

### Response

JSON object indicating whether an error has occurred during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the invoice later on.

## GET invoice-supplier

It retrieves information for a supplier invoice record in Ezus. You must specify to the Ezus API which supplier invoice you wish to retrieve, by indicating its appropriate reference in your query parameter.

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

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "reference": "invoice_supplier_reference",
  "url": "https://ezus.io/2023_101010.pdf",
  "created_date": "2023-10-10",
  "due_date": "2023-10-20",
  "amount_ttc": 1200.0,
  "amount_ht": 1000.0,
  "vat": 200.0,
  "currency": "EUR",
  "payments": [
    {
      "date": "2023-10-10",
      "amount": 500.0,
      "payment_method": "Credit Card"
    },
    {
      "date": "2023-10-11",
      "amount": 500.0,
      "payment_method": "Wire"
    },
    {
      "date": "2023-10-12",
      "amount": 200.0,
      "payment_method": "Check"
    }
  ],
  "supplier": {
    "reference": "supplier_reference",
    "company_name": "The best hotel",
    "website": "www.the_best_hotel.com"
  },
  "project": {
    "reference": "project_reference",
    "info_title": "Paris fashion week 2024",
    "info_stage": "Confirmed",
    "info_number": "202306001-P",
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
  }
}
```

### HTTP Endpoint

`GET https://api.ezus.app/invoice-supplier`

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter | Type   | Description                                                                                 |
| --------- | ------ | ------------------------------------------------------------------------------------------- |
| reference | String | <span style="color:red">(Required)</span> The reference of the invoice you wish to retrieve |

### Response

JSON object containing the supplier invoice information.

| Property     | Type   | Description                                                                                                                                                                                                       |
| ------------ | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference    | String | The reference of the supplier invoice you wish to retrieve                                                                                                                                                        |
| url          | String | URL of the supplier invoice file                                                                                                                                                                                  |
| filename     | String | Filename of the supplier invoice                                                                                                                                                                                  |
| created_date | String | Date of the creation of the supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                            |
| due_date     | String | Due date of the supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                                        |
| amount_ttc   | Number | Amount of the supplier invoice excluding taxes                                                                                                                                                                    |
| amount_ht    | Number | Amount of the supplier invoice including taxes                                                                                                                                                                    |
| vat          | Number | VAT amount of the supplier invoice                                                                                                                                                                                |
| currency     | String | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>) |
| payments     | Array  | Array of JSON including: `date`, `amount` and `payment_method`                                                                                                                                                    |
| supplier     | JSON   | JSON including: `reference`, `company_name` and `website`                                                                                                                                                         |
| project      | JSON   | JSON including: `reference`, `info_title`, `info_stage`, `info_number`, `currency` and `is_closed`                                                                                                                |
| alternative  | JSON   | JSON including: `sort_order` and `title`                                                                                                                                                                          |
| client       | JSON   | JSON including: `reference`, `type` (enterprise or individual), `company_name`, `first_name`, `last_name` and `email`                                                                                             |

# Deposits

## PUT deposits-create

It creates a client deposit in the specified project.

```shell
curl --location --request PUT 'https://api.ezus.app/deposits-create' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
    "project_reference": "project_reference",
    "alternative_order": "0",
    "amount": 6855,
    "type": "deposit",
    "date": "2023-05-25",
    "payment_method": "card",
    "notes": "Up-front payment 2023-05-25",
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  project_reference: "project_reference",
  alternative_order: "0",
  amount: 6855,
  type: "deposit",
  date: "2023-05-25",
  payment_method: "card",
  notes: "Up-front payment 2023-05-25",
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.put(baseUrl + "/deposits-create", body, headers);
```

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "message": "ok"
}
```

### HTTP Endpoint

`PUT https://api.ezus.app/deposits-create`

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| x-api-key     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter         | Type    | Description                                                                                                                               |
| ----------------- | ------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| project_reference | String  | <span style="color:red">(Required)</span> The reference is mandatory and refers to the project to which the payment will be added.        |
| alternative_order | String  | Alternative number, if not entered, the payment will be added to the project's main alternative.                                          |
| amount            | Integer | The deposit amount in cents.                                                                                                              |
| type              | String  | Type can be `deposit`, `payment`, `final_payment`, `extra_paid`. By default the deposits will be a `deposit`                              |
| date              | String  | The date must be a string in "YYYY-MM-DD" format. If it is not filled in or is invalid, the payment will be assigned to the current date. |
| payment_method    | String  | Technical name of the payment method, you can find it in Settings - Custom fields                                                         |
| notes             | String  | Note attributed to the payment, this note is limited to 100 characters, all additional characters will not be saved.                      |

### Response

JSON object indicating whether an error has occurred during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the deposit later on.

# Webhooks

## GET webhooks

Returns a list of your webhook endpoints.

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

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "webhooks": [
    {
      "reference": "webhook_reference",
      "endpoint": "webhook_endpoint",
      "is_active": "true",
      "events_types": "projects.created,clients.created",
      "last_called_at": "2023-01-01 01:01:01"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/webhooks`

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| X-API-KEY     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Response

Array of JSON containing your webhooks information.

| Property | Type  | Description                                      |
| -------- | ----- | ------------------------------------------------ |
| webhooks | Array | Array of JSON webhooks ([Webhooks](#webhooks-2)) |

## POST webhooks-upsert

It updates a webhook record if the provided reference does match one of the webhooks in your account, otherwise it creates a new webhook record with the provided reference (or with a random one if no reference is provided).

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

> It returns a JSON object structured like this:

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

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| X-API-KEY     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter    | Type   | Description                                                                                                                                                                                                                 |
| ------------ | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference    | String | If provided, the unique Ezus Reference associated to the webhook you want to update or create (in case the one you provided has never been used). If no reference is provided, a webhook will be created with a random one. |
| endpoint     | String | This parameter is required if you create a new webhook. You cannot update the endpoint of an existing webhook.                                                                                                              |
| is_active    | String | Status of the webhook `true` or `false`                                                                                                                                                                                     |
| events_types | String | The list of events to enable for this endpoint. At least 1 required, separated by commas if more than one. ([Events](#events))                                                                                              |

### Response

JSON object indicating whether an error has occurred during the process and, if so, the associated message. If there is no error, it also returns a reference: you will need to store this reference if you need to update or retrieve the webhook later on.

# Nested Resources

### Address

```json
   "address": {
    "label": "58 Rue de Paradis",
    "zip": "75010",
    "city": "Paris",
    "country": "France"
  },
```

| Property | Type   | Description          |
| -------- | ------ | -------------------- |
| label    | String | Label of the address |
| city     | String | Name of the city     |
| country  | String | Name of the country  |
| zip      | String | Post code            |

### Alternatives

```json
  "alternatives": [
    {
      "alternative_title": "Main Alternative",
      "budget_actual": "88750",
      "trip_budget": "90000",
      "trip_people": "15",
      "trip_date_in": "2024-03-01",
      "trip_date_out": "2024-03-09",
      "trip_duration": "9",
      "trip_destination": "France",
      "trip_subdestination": "Paris",
      "client": {
        "reference": "client_reference",
        "type": "enterprise",
        "company_name": "MOKE INTERNATIONAL LIMITED",
        "first_name": "Jane",
        "last_name": "Doe",
        "email": "contact@moke-international.com"
      }
    }
  ]
```

| Property            | Type   | Description                                                                                                           |
| ------------------- | ------ | --------------------------------------------------------------------------------------------------------------------- |
| alternative_title   | String | Title of the alternative                                                                                              |
| budget_actual       | String | Actual budget for the alternative (corresponding to its associated Ezus program)                                      |
| trip_budget         | Number | Forecasted budget for the alternative (the one that is entered manually not the actual one)                           |
| trip_people         | String | Number of people                                                                                                      |
| trip_date_in        | String | Date of the beginning of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates   |
| trip_date_out       | String | Date of the end of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates         |
| trip_duration       | String | Number of days this alternative lasts                                                                                 |
| trip_destination    | String | Destination of the alternative                                                                                        |
| trip_subdestination | String | Subdestination of the alternative                                                                                     |
| client              | JSON   | JSON including: `reference`, `type` (enterprise or individual), `company_name`, `first_name`, `last_name` and `email` |

### Contacts

Only the last 10 contacts are returned in this object. Note that for upsert endpoints, only one contact is required (equivalent to a single JSON element in the contacts.data Array below).

```json
"contacts": {
    "data": [
      {
  "email": "elliot@fsociety.org",
  "first_name": "Elliot",
  "last_name": "Alderson",
  "title": "Developer",
  "gender": "Mr",
  "phone": "",
  "phone2": "",
  "birth_date": "1986-09-17"
  }
    ],
    "size": 1
  }
```

| Property   | Type   | Description                                                                                       |
| ---------- | ------ | ------------------------------------------------------------------------------------------------- |
| email      | String | Email of the contact                                                                              |
| first_name | String | First name of the contact as a string                                                             |
| last_name  | String | Last name of the contact as a string                                                              |
| title      | String | Title of the contact as a string                                                                  |
| gender     | String | `Mr`, `Ms` or `Undefined`                                                                         |
| phone      | String | Phone number of the contact as a string                                                           |
| phone2     | String | Second phone number of the contact as a string                                                    |
| birth_date | String | Contact's date of birth in a "YYYY-MM-DD" format string (supplier contacts have no date of birth) |

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
      "value": "urlLink.com"
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
| File              | File   | Not supported yet                                                                                                                                                                              |

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

Those objects provides insights into the invoice amounts, differentiating between actual figures and forecasts. Actual figures are available when the associated project is closed and the invoice is marked as `completed` or `paid`. Otherwise, `null` values are displayed.

| Property     | Type    | Description                                                                              |
| ------------ | ------- | ---------------------------------------------------------------------------------------- |
| is_automatic | Boolean | Automatically use the figures of the project to which this invoice/credit_note is linked |
| purchase     | Number  | Forecasted / Actual purchase                                                             |
| commission   | Number  | Forecasted / Actual commission                                                           |
| vat_deducted | Number  | Forecasted / Actual deductible VAT                                                       |
| amount_ht    | Number  | Forecasted / Actual amount excluding taxes                                               |

### Langs

```json
"langs": [
  {
    "lang": "american",
    "name": "My American product version",
    "short_description": "Short American Description",
    "long_description": "Long American Description"
  }
],
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

### Products

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
  ],
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
    "last_name": "Atkins"
}
```

| Property   | Type   | Description            |
| ---------- | ------ | ---------------------- |
| email      | String | Email of the user      |
| first_name | String | First name of the user |
| last_name  | String | Last name of the user  |

### Webhooks

```json
"webhooks": [
  {
    "reference": "webhook_reference",
    "endpoint": "webhook_endpoint",
    "is_active": "true",
    "events_types": "projects.created,clients.created",
    "last_called_at": "2023-01-01 01:01:01"
  },
]
```

| Property       | Type   | Description                                                           |
| -------------- | ------ | --------------------------------------------------------------------- |
| reference      | String | The reference of the webhook                                          |
| endpoint       | String | The endpoint URL of the webhook                                       |
| is_active      | String | The status of the webhook `true` or `false`                           |
| events_types   | String | The list of events for this endpoint ([Events](#events))              |
| last_called_at | String | The webhook last called date in a "YYYY-MM-DD hh:mm:ss" format string |

# Events

## Basic event information

This section provides an overview of the fundamental details related to a webhook event, including its unique identifier, type, creation timestamp, trigger source, and whether it's a duplication.

```json
{
  "id": "event_id",
  "object": "event",
  "type": "projects.created",
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
    "info_title": "Paris fashion week 2024",
    "trip_budget": "90000",
    "trip_people": "15",
    "trip_date_in": "2024-03-01",
    "trip_date_out": "2024-03-09",
    "trip_duration": "9",
    "info_number": "202306001-P"
  }
}
```

| Property      | Type   | Description                                                                                                          |
| ------------- | ------ | -------------------------------------------------------------------------------------------------------------------- |
| reference     | String | The reference of the project                                                                                         |
| info_title    | String | The title of the project                                                                                             |
| trip_budget   | String | Forecasted budget for the alternative (the one that is entered manually not the actual one)                          |
| trip_people   | String | Number of people                                                                                                     |
| trip_date_in  | String | Date of the beginning of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates. |
| trip_date_out | String | Date of the end of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates.       |
| trip_duration | String | Number of days this project lasts                                                                                    |
| info_number   | String | File number that appears at the bottom of the project record. Not to be confused with reference!                     |

## clients.created

This event is triggered whenever a client is created.

```json
{
  "data": {
    "reference": "client_reference",
    "type": "enterprise",
    "company_name": "MOKE INTERNATIONAL LIMITED",
    "activity": "Software",
    "first_name": "Jane",
    "last_name": "Doe",
    "email": "contact@moke-international.com",
    "gender": "Ms",
    "phone": "0101010101",
    "birth_date": "1986-09-17",
    "info_number": "202306001-C"
  }
}
```

| Property     | Type   | Description                                                                                     |
| ------------ | ------ | ----------------------------------------------------------------------------------------------- |
| reference    | String | The reference of the client                                                                     |
| type         | String | The type of the client can be either "enterprise" or "individual"                               |
| company_name | String | Name of the company of the client                                                               |
| activity     | String | Activity of the client (only for enterprise)                                                    |
| first_name   | String | First name of the main contact of the client                                                    |
| last_name    | String | Last name of the main contact of the client                                                     |
| email        | String | Email of the main contact of the client                                                         |
| gender       | String | `Mr`, `Ms` or `Undefined`                                                                       |
| phone        | String | Phone number of the contact as a string                                                         |
| birth_date   | String | Contact's date of birth in a "YYYY-MM-DD" format string                                         |
| info_number  | String | File number that appears at the bottom of the client record. Not to be confused with reference! |

## invoices.finalized

This event is triggered whenever an invoice is finalized (its stage goes from `draft` to `completed`).

```json
{
  "data": {
    "reference": "invoice_reference",
    "info_number": "2023_101010",
    "url": "https://ezus.io/2023_101010.pdf",
    "stage": "completed",
    "type": "credit_note",
    "origin_reference": "origin_reference",
    "origin_info_number": "2023_101009",
    "created_date": "2023-10-10",
    "send_date": "2023-10-10",
    "due_date": "2023-10-10",
    "amount_ttc": 1200.0,
    "amount_ht": 1000.0,
    "vat": 200.0,
    "currency": "EUR",
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
| reference          | String | The reference of the invoice                                                                                                                                                                                      |
| info_number        | String | Title of the invoice                                                                                                                                                                                              |
| url                | String | URL of the invoice `.pdf` file                                                                                                                                                                                    |
| stage              | String | Stage of the invoice `draft` `completed` or `paid`                                                                                                                                                                |
| type               | String | Type of the invoice `invoice` or `credit_note`                                                                                                                                                                    |
| origin_reference   | String | This is only displayed if the type of the invoice is a `credit_note`. The reference of the origin invoice.                                                                                                        |
| origin_info_number | String | This is only displayed if the type of the invoice is a `credit_note`. Title of the origin invoice.                                                                                                                |
| created_date       | String | Date of the creation of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                    |
| send_date          | String | Sent date of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                               |
| due_date           | String | Due date of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                                |
| amount_ttc         | Number | Amount of the invoice including taxes                                                                                                                                                                             |
| amount_ht          | Number | Amount of the invoice excluding taxes                                                                                                                                                                             |
| vat                | Number | VAT amount of the invoice                                                                                                                                                                                         |
| currency           | String | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>) |
| project_reference  | String | The reference of the project linked to this invoice                                                                                                                                                               |
| alternative        | JSON   | JSON including: `sort_order` and `title`                                                                                                                                                                          |

## invoices_suppliers.attached

This event is triggered whenever a file is added to a supplier invoice.

```json
{
  "data": {
    "reference": "invoice_supplier_reference",
    "url": "https://ezus.io/2023_101010.pdf",
    "filename": "2023_101010.pdf",
    "created_date": "2023-10-10",
    "due_date": "2023-10-20",
    "amount_ttc": 1200.0,
    "amount_ht": 1000.0,
    "vat": 200.0,
    "currency": "EUR",
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
| url                | String | URL of the supplier invoice file                                                                                                                                                                                  |
| filename           | String | Filename of the supplier invoice                                                                                                                                                                                  |
| created_date       | String | Date of the creation of this supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                           |
| due_date           | String | Due date of this supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                                       |
| amount_ttc         | Number | Amount of the supplier invoice including taxes                                                                                                                                                                    |
| amount_ht          | Number | Amount of the supplier invoice excluding taxes                                                                                                                                                                    |
| vat                | Number | VAT amount of the supplier invoice                                                                                                                                                                                |
| currency           | String | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>) |
| supplier_reference | String | The reference of the supplier linked to this supplier invoice                                                                                                                                                     |
| project_reference  | String | The reference of the project linked to this supplier invoice                                                                                                                                                      |
| alternative        | JSON   | JSON including: `sort_order` and `title`                                                                                                                                                                          |
