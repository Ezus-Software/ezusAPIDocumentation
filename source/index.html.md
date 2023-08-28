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

Welcome to the Ezus API. The Ezus API is organized around <a href='https://en.wikipedia.org/wiki/Representational_state_transfer' target="_blank">REST</a>. It supplies a collection of HTTP methods that underpin Ezus main functionalities. Its main objective is to enable you to manage your Ezus projects, clients and catalog (suppliers/products/packages) programmatically.

If you need an overview of some common use cases that you can setup with our API you can look at our help center section <a href='https://help.ezus.io/en/collections/3016686-integrations' target="_blank">Integrations</a>

If you wantt to dive into the list of available methods, you've come to the right place. This documentation provides a technical description (reference) for each method in the left-hand section, as well as code examples in the right-hand section.

Each method has its own specification, but as a general rule:

For any request, you must provide <a href='https://swagger.io/docs/specification/describing-parameters/#header-parameters' target="_blank">header parameters</a>

For GET requests, you must also provide <a href='https://swagger.io/docs/specification/describing-parameters/#query-parameters' target="_blank">querry parameters</a>

For POST requests, you must also provide <a href='https://swagger.io/docs/specification/2-0/describing-request-body' target="_blank">body parameters</a> structured in a JSON payload (application/json)

<aside class="warning">
Quick tip: You can <a href="https://ezus-public-documentation.s3.eu-west-1.amazonaws.com/ezus_api_postman.json"  target="_blank">download here</a> a Postman export of this API
</aside>

# Authentication

## Principles

Ezus authentication scheme is based on <a href='https://swagger.io/docs/specification/authentication/api-keys/' target="_blank">API Keys</a> and <a href='https://swagger.io/docs/specification/authentication/bearer-authentication/' target="_blank">Bearer authentication</a>. So, you will need 2 things to be able to interact with our API:

- An Ezus API key
- User credentials of an Ezus account

<span style="text-decoration:underline">API key</span>

Ezus uses API keys to control access to its API. To get `<YOUR_API_KEY>`, ask your account manager. The Ezus API requires this API key to be included in the X-API-KEY header parameter of all your requests.

`X-API-KEY: <YOUR_API_KEY>`

<span style="text-decoration:underline">Bearer authentication</span>

After calling the /login endpoint with valid credentials, a bearer token will be returned to you: `<YOUR_TOKEN>`. This token is then valid for 12 hours. The Ezus API requires this bearer token to be included in the Authorization header parameter of all subsequent requests.

`Authorization: Bearer <YOUR_TOKEN>`

## POST login

> To authenticate, you will need first to call our /login endpoint:

```shell
curl --location 'https://api.ezus.app/login' \
--header 'X-API-KEY: <YOUR_API_KEY>' \
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
const headers = { "X-API-KEY": "<YOUR_API_KEY>" };

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
| X-API-KEY | String | <span style="color:red">(Required)</span> Your Ezus API key |

### Body parameters (application/json)

| Parameter | Type   | Description                                                     |
| --------- | ------ | --------------------------------------------------------------- |
| email     | String | <span style="color:red">(Required)</span> Your account email    |
| password  | String | <span style="color:red">(Required)</span> Your account password |

### Response

JSON object indicating whether an error has occured during the process and, if so, the associated message. If there is no error, it also returns a `token`: you will need to store this token for future API requests.

# Projects

## GET project

Retrieve information for a project record in Ezus. You must specify to the Ezus API which project you wish to retrieve, by indicating its appropriate reference in your query parameter.

```shell
curl --location 'https://api.ezus.app/project?reference=project_reference' \
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

axios.post(baseUrl + "/project?reference=project_reference", {}, headers);
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
        "type": "entreprise",
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
| X-API-KEY     | String | <span style="color:red">(Required)</span> Your Ezus API key |
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
| sales_manager   | JSON   | JSON object user ([User](#user))                                                                 |
| project_manager | JSON   | JSON object user ([User](#user))                                                                 |
| alternatives    | Array  | Array of JSON alternatives ([Alternatives](#alternatives))                                       |
| custom_fields   | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                    |

## POST projects-upsert

Update a project record if the provided reference does match one of the project references in your account, otherwise create a new project record with the provided reference (or with a random one if no reference is provided).

```shell
curl --location 'https://api.ezus.app/projects-upsert' \
--header 'X-API-KEY: <YOUR_API_KEY>' \
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
  "X-API-KEY": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/projects-upsert", body, headers);
```

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Project Updated Successfuly",
  "reference": "project_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/projects-upsert`

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| X-API-KEY     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter           | Type   | Description                                                                                                                                                                                                                              |
| ------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference           | String | If provided, the unique reference associated to the project you want to update or create (in case the one you provided has never been used). If no reference is provided, a project will be created with a random one.                   |
| info_title          | String | Title of the project. This parameter is required if you create a new project                                                                                                                                                             |
| trip_budget         | Number | Forecasted budget for the project                                                                                                                                                                                                        |
| trip_people         | Number | Number of people in the project                                                                                                                                                                                                          |
| trip_date_in        | Date   | Date of the beginning of the project in a "YYYY-MM-DD" format string. If not provided or if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1 day and trip_date_in as today |
| trip_date_out       | Date   | Date of the end of the project in a "YYYY-MM-DD" format string. If not provided or if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1 day and trip_date_out as today      |
| sales_manager_email | Email  | Email of the Ezus user that will be set as the sales manager of the project. By default, if no sales manager is provided or the provided email do not match any user on this account, the project will be assignated to None             |
| client_reference    | String | This can be a reference or the email of a client already created in this Ezus account. By default, the project will not be linked to any client. If you want to update the project's client to None, you must enter 0.                   |
| custom_fields       | JSON   | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                            |

### Response

JSON object indicating whether an error has occured during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the project later on.

## POST projects-documents-create

Create a PDF document based on the link you provide within the project using project_reference as its reference.

```shell
curl --location 'https://api.ezus.app/projects-documents-create' \
--header 'X-API-KEY: <YOUR_API_KEY>' \
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
  "X-API-KEY": "<YOUR_API_KEY>",
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
| X-API-KEY     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter         | Type   | Description                                                                                                          |
| ----------------- | ------ | -------------------------------------------------------------------------------------------------------------------- |
| project_reference | String | <span style="color:red">(Required)</span> The project reference in which you want to create a document               |
| title             | String | Title of the document                                                                                                |
| link              | Link   | <span style="color:red">(Required)</span> URL of the document (only PDF). Make sure this link is publicly accessible |

### Response

JSON object indicating whether an error has occured during the process and, if so, the associated message.

# Clients

## GET client

Retrieve information for a client record in Ezus. You must specify to the Ezus API which client you wish to retrieve, by indicating its appropriate reference in your query parameter.

```shell
curl --location 'https://api.ezus.app/client?reference=client_reference' \
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

axios.post(baseUrl + "/client?reference=client_reference", {}, headers);
```

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "reference": "client_reference",
  "type": "entreprise",
  "company_name": "MOKE INTERNATIONAL LIMITED",
  "website": "www.moke_ltd.com",
  "first_name": "Jane",
  "last_name": "Doe",
  "email": "contact@moke-international.com",
  "activity": "Sofware",
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
| X-API-KEY     | String | <span style="color:red">(Required)</span> Your Ezus API key |
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
| type          | String | The type of the client can be either "entreprise" or "individual"                                                                                                     |
| company_name  | String | Name of the company of the client                                                                                                                                     |
| website       | String | Website of the client                                                                                                                                                 |
| first_name    | String | Frist name of the main contact of the client                                                                                                                          |
| last_name     | String | Last name of the main contact of the client                                                                                                                           |
| email         | String | Email of the main contact of the client                                                                                                                               |
| activity      | String | Activity of the client (only for entreprise)                                                                                                                          |
| vat_number    | String | VAT number of the client (only for entreprise)                                                                                                                        |
| siret         | String | Company registration number of the client (only for entreprise)                                                                                                       |
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

Update a client record if the provided reference (or the email) does match one of the client references in your account, otherwise create a new client record with the provided reference (or with a random one if no reference is provided). Note that for this endpoint, the email of the client can also be used as a primary key for the upsert.

```shell
curl --location 'https://api.ezus.app/clients-upsert' \
--header 'X-API-KEY: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
    "reference": "client_reference",
    "company_name": "MOKE INTERNATIONAL LIMITED",
    "website": "www.moke_ltd.com",
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
  "X-API-KEY": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/clients-upsert", body, headers);
```

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Client updated Successfully",
  "reference": "client_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/clients-upsert`

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| X-API-KEY     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter     | Type   | Description                                                                                                                                                                                                                                                             |
| ------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference     | String | If provided, the unique reference associated to the client you want to update or create (in case the one you provided has never been used). If no reference is provided, a client will be created with a random one.                                                    |
| company_name  | String | <span style="color:red">(Required)</span> Set a company name - If company name is empty, the client will be set as an individual and the name of the client = name of the contact and if the company name is not empty, the name of the client will be the company name |
| website       | String | Website of the client                                                                                                                                                                                                                                                   |
| contact       | JSON   | Contact is a single JSON element and email is needed. Note that only one contact can be upsert this way (the main contact of the client) ([Contacts](#contacts))                                                                                                        |
| address       | JSON   | JSON object address` ([Address](#address))                                                                                                                                                                                                                              |
| custom_fields | JSON   | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                                                           |

### Response

JSON object indicating whether an error has occured during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the client later on.

# Suppliers

## GET supplier

Retrieve information for a supplier record in Ezus. You must specify to the Ezus API which supplier you wish to retrieve, by indicating its appropriate reference in your query parameter.

```shell
curl --location 'https://api.ezus.app/supplier?reference=supplier_reference' \
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

axios.post(baseUrl + "/supplier?reference=supplier_reference", {}, headers);
```

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "reference": "supplier_reference",
  "company_name": "The best hotel",
  "website": "www.the_best_hotel.com",
  "capacity": 200,
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
        "phone2": "0707070707",
        "birth_date": "1986-09-17"
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
| X-API-KEY     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter | Type   | Description                                                                                  |
| --------- | ------ | -------------------------------------------------------------------------------------------- |
| reference | String | <span style="color:red">(Required)</span> The reference of the supplier you wish to retrieve |

### Response

JSON object containing the supplier information.

| Property      | Type   | Description                                                                                                                                                 |
| ------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference     | String | The reference of the supplier you wish to retrieve                                                                                                          |
| company_name  | String | Name of the company of the supplier                                                                                                                         |
| website       | String | Website of the supplier                                                                                                                                     |
| capacity      | String | Maximum number of people for which the supplier can be used                                                                                                 |
| type          | String | 3 options: `accom`, `activity`, `transport`. A supplier can have no type, 1 type or serval types. In this case, the different types are separated by commas |
| info_notes    | String | Notes on the supplier                                                                                                                                       |
| info_number   | String | File number that appears at the bottom of the supplier record. Not to be confused with reference!                                                           |
| visual_url    | String | URL of the Google Slides visual linked to the supplier                                                                                                      |
| user          | JSON   | JSON object user ([User](#user))                                                                                                                            |
| address       | JSON   | JSON object address ([Address](#address))                                                                                                                   |
| products      | JSON   | JSON object products ([Products](#products))                                                                                                                |
| contacts      | Array  | Array of JSON contacts ([Contacts](#contacts))                                                                                                              |
| medias        | JSON   | JSON object medias ([Medias](#medias))                                                                                                                      |
| langs         | Array  | Array of JSON langs ([Langs](#langs))                                                                                                                       |
| custom_fields | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                               |

## POST suppliers-upsert

Update a supplier record if the provided reference (or the email) does match one of the supplier references in your account, otherwise create a new supplier record with the provided reference (or with a random one if no reference is provided). Note that for this endpoint, the email of the supplier can also be used as a primary key for the upsert.

```shell
curl --location 'https://api.ezus.app/suppliers-upsert' \
--header 'X-API-KEY: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
    "reference": "supplier_reference",
    "company_name": "The best hotel",
    "website": "www.the_best_hotel.com",
    "capacity": 200,
    "type": "accom, activity",
    "contact": {
        "email": "bob@proton.me",
        "first_name": "Bob",
        "last_name": "Morane",
        "title": "Project Manager",
        "gender": "Mr",
        "phone": "0606060606",
        "phone2": "0707070707",
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
  reference: "supplier_reference",
  company_name: "The best hotel",
  website: "www.the_best_hotel.com",
  capacity: 200,
  type: "accom, activity"
  contact: {
    email: "bob@proton.me",
      first_name: "Bob",
      last_name: "Morane",
      title: "Project Manager",
      gender: "Mr",
      phone: "0606060606",
      phone2: "0707070707",
      birth_date: "1986-09-17"
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
const headers = { "X-API-KEY": "<YOUR_API_KEY>", "Authorization": "Bearer <YOUR_TOKEN>" };

axios.post(baseUrl + "/suppliers-upsert", body, headers);
```

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Supplier created Successfully",
  "reference": "supplier_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/suppliers-upsert`

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| X-API-KEY     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter     | Type   | Description                                                                                                                                                                                                                                   |
| ------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| reference     | String | If provided, the unique reference associated to the supplier you want to update or create (in case the one you provided has never been used). If no reference is provided, a supplier will be created with a random one.                      |
| company_name  | String | Name of the supplier. This parameter is required if you create a new supplier                                                                                                                                                                 |     |
| website       | String | Website of the supplier                                                                                                                                                                                                                       |
| capacity      | Number | Maximum number of people for which the supplier can be used. Leave blank `''` if not relevant                                                                                                                                                 |
| type          | String | Either `undefined` or a combinaison of these 3 options: `accom`, `activity`, `transport`. You can select multiple options by separating them with comas ("accom, activity" for instance). Enter "undefined" if you want to reset this params. |
| contact       | JSON   | Contact is a single JSON and email is needed. Note that only one contact can be upsert this way (the main contact of the supplier) ([Contact](#contacts))                                                                                     |
| address       | JSON   | JSON object address ([Address](#address))                                                                                                                                                                                                     |
| custom_fields | JSON   | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                                 |

### Response

JSON object indicating whether an error has occured during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the supplier later on.

# Products

## GET product

Retrieve information for a product record in Ezus. You must specify to the Ezus API which product you wish to retrieve, by indicating its appropriate reference in your query parameter.

```shell
curl --location 'https://api.ezus.app/product?reference=product_reference' \
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

axios.post(baseUrl + "/product?reference=product_reference", {}, headers);
```

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "reference": "product_reference",
  "title": "2-bed room with breakfast",
  "capacity": 2,
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
| X-API-KEY     | String | <span style="color:red">(Required)</span> Your Ezus API key |
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
| currency        | String | The ISO 4217 code who represent the currency you use (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>)                                    |
| budget_text     | String | `Option`, `On Demand` or `""`, if it's Option/On demand, by default the product will be an Option/On demand, the mention will be added on your documents. If it's empty no options will be applied on the budget                         |
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

Update a product record if the provided reference does match one of the product references in your account, otherwise create a new product record with the provided reference (or with a random one if no reference is provided).

```shell
curl --location 'https://api.ezus.app/products-upsert' \
--header 'X-API-KEY: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "reference": "product_reference",
    "title": "2-bed room with breakfast",
    "quantity": "1",
    "capacity": 2,
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
  "X-API-KEY": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/products-upsert", body, headers);
```

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Product Created Successfully",
  "reference": "product_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/products-upsert`

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| X-API-KEY     | String | <span style="color:red">(Required)</span> Your Ezus API key |
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

JSON object indicating whether an error has occured during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the product later on.

# Packages

## GET package

Retrieve information for a package record in Ezus. You must specify to the Ezus API which package you wish to retrieve, by indicating its appropriate reference in your query parameter.

```shell
curl --location 'https://api.ezus.app/package?reference=package_reference' \
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

axios.post(baseUrl + "/package?reference=package_reference", {}, headers);
```

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "reference": "package_reference",
  "title": "The best package",
  "capacity": 2,
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
| X-API-KEY     | String | <span style="color:red">(Required)</span> Your Ezus API key |
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

Update a package record if the provided reference does match one of the package references in your account, otherwise create a new package record with the provided reference (or with a random one if no reference is provided).

```shell
curl --location 'https://api.ezus.app/packages-upsert' \
--header 'X-API-KEY: <YOUR_API_KEY>' \
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
  "X-API-KEY": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/packages-upsert", body, headers);
```

> It returns a JSON object structured like this:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Package Created Successfully",
  "reference": "package_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/packages-upsert`

### Header parameters

| Parameter     | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| X-API-KEY     | String | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | String | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter     | Type   | Description                                                                                                                                                                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference     | String | If provided, the unique Ezus Reference associated to the package you want to update or create (in case the one you provided has never been used). If no reference is provided, a package will be created with a random one. |
| title         | String | This parameter is required if you create a new package                                                                                                                                                                      |
| capacity      | Number | Maximum number of people for which the package can be used . Leave blank `''` if not relevant                                                                                                                               |
| custom_fields | JSON   | You can add custom fields for your client, this custom fields should be in your Ezus params and Write exactly as they are written in your params technical name ([Custom fields](#custom-fields))                           |

### Response

JSON object indicating whether an error has occured during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the package later on.

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
        "type": "entreprise",
        "company_name": "MOKE INTERNATIONAL LIMITED",
        "first_name": "Jane",
        "last_name": "Doe",
        "email": "contact@moke-international.com"
      }
    }
  ]
```

| Property            | Type   | Description                                                                                                              |
| ------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------ |
| alternative_title   | String | Title of the alternative                                                                                                 |
| budget_actual       | String | Actual budget for the alternative (corresponding to its associated Ezus program)                                         |
| trip_budget         | Number | Forecasted budget for the alternative (the one that is entered manually not the actual one)                              |
| trip_people         | String | Number of people                                                                                                         |
| trip_date_in        | String | Date of the begining of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates       |
| trip_date_out       | String | Date of the end of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates            |
| trip_duration       | String | Number of days this alternative lasts                                                                                    |
| trip_destination    | String | Destination of the alternative                                                                                           |
| trip_subdestination | String | Subdestination of the alternative                                                                                        |
| client              | JSON   | JSON that contain: `reference`, `type` (entreprise or individual), `company_name`, `first_name`, `last_name` and `email` |

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

| Property   | Type   | Description                                             |
| ---------- | ------ | ------------------------------------------------------- |
| email      | String | Email of the contact                                    |
| first_name | String | First name of the contact as a string                   |
| last_name  | String | Last name of the contact as a string                    |
| title      | String | Title of the contact as a string                        |
| gender     | String | `Mr`, `Ms` or `Undefined`                               |
| phone      | String | Phone number of the contact as a string                 |
| phone2     | String | Second phone number of the contact as a string          |
| birth_date | String | Contact's date of birth in a "YYYY-MM-DD" format string |

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
| purchase_price | Number | Purchase price incl taxes                                                             |
| margin_rate    | Number | The margin rate is based on the sales price                                           |
| sales_price    | Number | Sales price incl taxes                                                                |
| childs         | Array  | Childs are sub-tariffs contained by this tariff (only season tariffs can have childs) |

### User

One of the following options: `None`, `Everyone`, `User Group` or the following JSON object corresponding to an active Ezus user of this account

```json
"user":{
    "email": "tommy@e-corp.com",
    "first_name": "Tommy",
    "last_name": "Atkins"
  },
```

| Property   | Type   | Description            |
| ---------- | ------ | ---------------------- |
| email      | String | Email of the user      |
| first_name | String | First name of the user |
| last_name  | String | Last name of the user  |
