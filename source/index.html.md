---
title: Ezus API Reference

language_tabs: # must be one of https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers
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

Welcome to the Ezus API. The Ezus API is organized around <a href='https://en.wikipedia.org/wiki/Representational_state_transfer' target="_blank">REST</a>. It supplies a collection of HTTP methods that underpin Ezus main functionalities. Its main objective is to enable you to manage your Ezus projects, customers and catalog (suppliers/products/packages) programmatically.

If you need an overview of some common use cases that you can setup with our API you can look at our help center section <a href='https://help.ezus.io/en/collections/3016686-integrations' target="_blank">Integrations</a>

If you want to dive into the list of available methods, you've come to the right place. This documentation provides a technical description (reference) for each method in the left-hand section, as well as code examples in the right-hand section.

<aside class="success">
You can find here a <a href="#" target="_blank"> Postman Collection</a> of our endpoints containing moke data to directly test it
</aside>

Each method has its own specification, but as a general rule :

For any request, you must provide <a href='https://swagger.io/docs/specification/describing-parameters/#header-parameters' target="_blank">header parameters</a>

For GET requests, you must also provide provide <a href='https://swagger.io/docs/specification/describing-parameters/#query-parameters'>querry parameters</a>

For POST requests, you must also provide provide <a href='https://swagger.io/docs/specification/2-0/describing-request-body'>body parameters</a> structured in a JSON payload (application/json)

# Authentication

> To authenticate, you will need first to call our /login endpoint:

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

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
  "erreur": "false",
  "token": "<YOUR_TOKEN>"
}
```

> In subsequent requests, be sure to replace `<YOUR_TOKEN>` in the Authorization header parameter with the token returned to you here.

Ezus authentication scheme is based on <a href='https://swagger.io/docs/specification/authentication/api-keys/' target="_blank">API Keys</a> and <a href='https://swagger.io/docs/specification/authentication/bearer-authentication/' target="_blank">Bearer authentication</a>. So, you will need 2 things to be able to interact with our API:

- An Ezus API key
- User credentials of an Ezus account

<span style="text-decoration:underline">API key</span>

Ezus uses API keys to control access to its API. To get `<YOUR_API_KEY>`, ask your account manager. The Ezus API requires this API key to be included in the X-API-KEY header parameter of all your requests.

`X-API-KEY: <YOUR_API_KEY>`

<span style="text-decoration:underline">Bearer authentication</span>

After calling the /login endpoint with valid credentials, a bearer token will be returned to you: `<YOUR_TOKEN>`. This token is then valid for 12 hours. The Ezus API requires this bearer token to be included in the Authorization header parameter of all subsequent requests.

`Authorization: Bearer <YOUR_TOKEN>`

### HTTP Endpoint

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/login`

### Header parameters

| Parameter | Description                                                 |
| --------- | ----------------------------------------------------------- |
| X-API-KEY | <span style="color:red">(Required)</span> Your Ezus API key |

### Body parameters (application/json)

| Parameter | Description                                                     |
| --------- | --------------------------------------------------------------- |
| email     | <span style="color:red">(Required)</span> Your account email    |
| password  | <span style="color:red">(Required)</span> Your account password |

### Response

JSON object indicating whether an error has occured during the process and, if so, the associated message. If there is no error, it also returns a `token`: you will need to store this token for future API requests.

# Projects

## GET project

Retrieve information for a project record in Ezus. You must specify to the Ezus API which project you wish to retrieve, by indicating the appropriate reference in your query parameter.

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = {
  "X-API-KEY": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/project?reference=project_reference_1234", {}, headers);
```

> It returns a JSON object structured like this:

```json
{
  "erreur": "false",
  "reference": "project_reference_1234",
  "info_title": "Project Title",
  "info_stage": "Confirmed",
  "info_notes": "The notes about this project",
  "info_number": "202306001-P",
  "sales_manager": {
    "email": "traveldesigner@email.com",
    "first_name": "FirstName",
    "last_name": "LastName"
  },
  "project_manager": {
    "email": "projectmanager@email.com",
    "first_name": "FirstName",
    "last_name": "LastName"
  },
  "alternatives": [
    {
      "alternative_title": "Alternative 1",
      "trip_people": "15",
      "trip_budget": "0",
      "trip_date_in": "2022-07-31",
      "trip_date_out": "2022-08-02",
      "trip_duration": "2",
      "trip_destination": "France",
      "trip_subdestination": "Paris",
      "client": {
        "reference": "client_reference_1234",
        "type": "entreprise",
        "company_name": "Client Company Name",
        "first_name": "Client First Name",
        "last_name": "Client Last Name",
        "email": "client@email.com"
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

`GET https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/project`

### Header parameters

| Parameter     | Description                                                 |
| ------------- | ----------------------------------------------------------- |
| X-API-KEY     | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter | Type   | Description                                                                                 |
| --------- | ------ | ------------------------------------------------------------------------------------------- |
| reference | String | <span style="color:red">(Required)</span> The reference of the project you wish to retrieve |

### Response

JSON object containing the project information.

| Property        | Type   | Description                                                                                      |
| --------------- | ------ | ------------------------------------------------------------------------------------------------ |
| reference       | String | The reference of the project you wish to retrieve                                                |
| info_title      | String | The title of your project                                                                        |
| info_stage      | String | The stage of your project (Confirmed, Received, Paid...)                                         |
| info_notes      | String | Notes on your project                                                                            |
| info_number     | String | File number that appears at the bottom of the project record. Not to be confused with reference! |
| sales_manager   | JSON   | JSON object containing `email`, `first_name` and `last_name`                                     |
| project_manager | JSON   | JSON object containing `email`, `first_name` and `last_name`                                     |
| alternatives    | Array  | Array of JSON alternatives ([Alternatives](#alternatives))                                       |
| custom_fields   | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                    |

## POST projects-upsert

Update a project record if the provided reference do matches one of the project references in your account, otherwise create a new project record with the provided reference (or with a random one if no reference is provided).

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "project_reference_1234",
  info_title: "project_title",
  trip_people: "15",
  trip_budget: "3000",
  trip_date_in: "2022-07-31",
  trip_date_out: "2022-08-02",
  sales_manager_email: "emailofthesales@mail.com",
  client_reference: "client_reference_1234",
  custom_fields: [
    { name: "Text", value: "I am a text" },
    { name: "Dropdown", value: "nameOption2" },
    { name: "Date", value: "2012-11-24" },
    { name: "Time", value: "2006-10-07T12:06:56.568+01:00" },
    { name: "Checkbox", value: "true" },
  ],
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
  "erreur": "false",
  "message": "ok",
  "action": "Project Updated Successfuly",
  "reference": "project_reference_1234"
}
```

### HTTP Endpoint

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/projects-upsert`

### Header parameters

| Parameter     | Description                                                 |
| ------------- | ----------------------------------------------------------- |
| X-API-KEY     | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter           | Type   | Description                                                                                                                                                                                                                                              |
| ------------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference           | String | If provided, the unique reference associated to the project you want to update or insert (in case the one you provided has never been used). If not provided, a project will be inserted with a random one.                                              |
| info_title          | String | Title of your project, mandatory if you create a new project                                                                                                                                                                                             |
| trip_people         | Number | Number of people in your project                                                                                                                                                                                                                         |
| trip_budget         | Number | Budget of your project                                                                                                                                                                                                                                   |
| trip_date_in        | Date   | Date of the beginning of your project formated like YYYY-MM-DD if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1day and date = today. If project is without Date, no date will be setted |
| trip_date_out       | Date   | Date of the end of your project formated like YYYY-MM-DD if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1day and date = today. If project is without Date, no date will be setted       |
| sales_manager_email | Email  | Email of the Sales Manager, by default if no sales_manager or not found will be assignated to nobody                                                                                                                                                     |
| client_reference    | String | reference or Email of the Client, if the reference don't match with a client, API will try with client_email if setted else, No clients will be assigned                                                                                                 |
| custom_fields       | JSON   | You can add Custom Fields for your project, this custom fields should be in your Ezus params and Write Exactly as they are written in your params technical name ([Custom fields](#custom-fields))                                                       |

### Response

JSON object indicating whether an error has occured during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the project later on.

## POST projects-documents-create

Create a document within a specific project based on its url

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "document_reference",
  title: "Document test",
  link: "https://www.linktothedocument.pdf",
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
  "erreur": "false",
  "message": "ok"
}
```

### HTTP Endpoint

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/projects-documents-create`

### Header parameters

| Parameter     | Description                                                 |
| ------------- | ----------------------------------------------------------- |
| X-API-KEY     | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter | Type   | Description                                                                                            |
| --------- | ------ | ------------------------------------------------------------------------------------------------------ |
| reference | String | <span style="color:red">(Required)</span> The project reference in which you want to insert a document |
| title     | String | <span style="color:red">(Required)</span> Title of your document                                       |
| link      | Link   | <span style="color:red">(Required)</span> HTTP link of your document (only PDF)                        |

### Response

JSON object indicating whether an error has occured during the process and, if so, the associated message.

# Clients

## GET client

Retrieve information for a client record in Ezus. You must specify to the Ezus API which client you wish to retrieve, by indicating the appropriate reference in your query parameter.

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = {
  "X-API-KEY": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/client?reference=client_reference_1234", {}, headers);
```

> It returns a JSON object structured like this:

```json
{
  "erreur": "false",
  "reference": "client_reference_1234",
  "type": "entreprise",
  "company_name": "Company Name",
  "first_name": "Fistname",
  "last_name": "Lastname",
  "email": "client@email.com",
  "activity": "Client Activity",
  "vat_number": "Client VAT Number",
  "siret": "Client Siret",
  "info_profile": "Client",
  "info_origin": "Client Source",
  "info_notes": "Notes on the client",
  "info_number": "202306001-C",
  "user": {
    "email": "user@email.com",
    "first_name": "FirstName",
    "last_name": "LastName"
  },
  "address": {
    "label": "58 Rue de Paradis",
    "zip": "75009",
    "city": "Paris",
    "country": "France"
  },
  "projects": {
    "data": [
      {
        "reference": "project_reference_1234",
        "info_title": "Project title"
      }
    ],
    "size": 1
  },
  "contacts": [
    {
      "first_name": "Firstname",
      "last_name": "Lastname",
      "email": "contact@email.com"
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

`GET https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/client`

### Header parameters

| Parameter     | Description                                                 |
| ------------- | ----------------------------------------------------------- |
| X-API-KEY     | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter | Type   | Description                                                                                |
| --------- | ------ | ------------------------------------------------------------------------------------------ |
| reference | String | <span style="color:red">(Required)</span> The reference of the client you wish to retrieve |

### Response

JSON object containing the client information.

| Property      | Type   | Description                                                                                                                                                           |
| ------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference     | String | The reference of the client you wish to retrieve                                                                                                                      |
| type          | String | The type of the client ["entreprise", "individual"]                                                                                                                   |
| company_name  | String | Name of the company of your client                                                                                                                                    |
| first_name    | String | First name of the client                                                                                                                                              |
| last_name     | String | Last name of the client                                                                                                                                               |
| email         | String | Email of the client                                                                                                                                                   |
| activity      | String | Activity of the client (Only for entreprise)                                                                                                                          |
| vat_number    | String | VAT number of the client (Only for entreprise)                                                                                                                        |
| siret         | String | Siret number of the client (Only for entreprise)                                                                                                                      |
| info_profile  | String | Profile of the client                                                                                                                                                 |
| info_origin   | String | Source of the client                                                                                                                                                  |
| info_notes    | String | Notes on the client                                                                                                                                                   |
| info_number   | String | File number that appears at the bottom of the client record. Not to be confused with reference!                                                                       |
| user          | JSON   | JSON object containing `email`, `first_name` and `last_name`                                                                                                          |
| address       | JSON   | JSON object containing `label`, `zip`, `city` and `country` ([Address](#address))                                                                                     |
| projects      | JSON   | Projects linked to the client (return only the 10 first projects). JSON object containing `data` (Array of JSON objects containing `reference`, `info_title`), `size` |
| contacts      | Array  | Array of JSON contacts ([Contacts](#contacts))                                                                                                                        |
| custom_fields | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                         |

## POST clients-upsert

Update a client record if the provided reference (or the email) do matches one of the client references in your account, otherwise create a new client record with the provided reference (or with a random one if no reference is provided). Note that for this endpoint, the email of the client can also be used as a primary key for the upsert.

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "client_reference",
  company_name: "client_company_name",
  contact: {
    firstname: "firstname",
    lastname: "lastname",
    gender: "Mr",
    email: "email@email.email",
    phone: "0606060606",
    birthdate: "2023-01-01",
  },
  address: {
    label: "58 Rue de Paradis",
    city: "Paris",
    country: "France",
    zip: "75009",
  },
  custom_fields: [
    { name: "field1", value: "field1Value" },
    { name: "field2", value: "field2Value" },
  ],
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
  "erreur": "false",
  "message": "ok",
  "action": "Client updated Successfully",
  "reference": "client_reference_1234"
}
```

### HTTP Endpoint

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/clients-upsert`

### Header parameters

| Parameter     | Description                                                 |
| ------------- | ----------------------------------------------------------- |
| X-API-KEY     | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter     | Type   | Description                                                                                                                                                                                                                                                             |
| ------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| reference     | String | If provided, the unique reference associated to the client you want to update or insert (in case the one you provided has never been used). If not provided, a client will be inserted with a random one.                                                               |
| company_name  | String | <span style="color:red">(Required)</span> Set a company name - If company name is empty, the client will be set as an individual and the name of the client = name of the contact and if the company name is not empty, the name of the client will be the company name |     |
| contact       | JSON   | Contact is a JSON and email is needed ([Contact](#contact))                                                                                                                                                                                                             |
| address       | JSON   | Address is a JSON and label is needed if you want to add or update the adresse of your client but not mandatory ([Address](#address))                                                                                                                                   |
| custom_fields | JSON   | You can add custom fields for your client, this custom fields should be in your Ezus params and Write exactly as they are written in your params technical name ([Custom fields](#custom-fields))                                                                       |

### Response

JSON object indicating whether an error has occured during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the client later on.

# Suppliers

## GET supplier

Retrieve information for a supplier record in Ezus. You must specify to the Ezus API which supplier you wish to retrieve, by indicating the appropriate reference in your query parameter.

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = {
  "X-API-KEY": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(
  baseUrl + "/supplier?reference=supplier_reference_1234",
  {},
  headers
);
```

> It returns a JSON object structured like this:

```json
{
  "erreur": "false",
  "reference": "supplier_reference_1234",
  "company_name": "Company Name",
  "capacity": "3",
  "type": "accom, activity",
  "info_notes": "Notes on the supplier",
  "info_number": "202306001-S",
  "visual_url": "urlofthevisual.com",
  "user": {
    "email": "user@email.com",
    "first_name": "FirstName",
    "last_name": "LastName"
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
  "address": {
    "label": "58 Rue de Paradis",
    "zip": "75009",
    "city": "Paris",
    "country": "France"
  },
  "products": {
    "data": [
      {
        "reference": "product_reference_1234",
        "title": "product_title"
      }
    ],
    "size": 1
  },
  "contacts": [
    {
      "first_name": "Firstname",
      "last_name": "Lastname",
      "email": "contact@email.com"
    }
  ],
  "langs": [
    {
      "lang": "american",
      "name": "American Name",
      "short_description": "Short American Description",
      "long_description": "Short American Description"
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

`GET https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/supplier`

### Header parameters

| Parameter     | Description                                                 |
| ------------- | ----------------------------------------------------------- |
| X-API-KEY     | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter | Type   | Description                                                                                  |
| --------- | ------ | -------------------------------------------------------------------------------------------- |
| reference | String | <span style="color:red">(Required)</span> The reference of the supplier you wish to retrieve |

### Response

JSON object containing the supplier information.

| Property      | Type   | Description                                                                                                                                           |
| ------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference     | String | The reference of the supplier you wish to retrieve                                                                                                    |
| company_name  | String | Name of the company of your supplier                                                                                                                  |
| capacity      | String | Capacity of the supplier                                                                                                                              |
| type          | String | Type of the supplier, the different types are separated by commas                                                                                     |
| info_notes    | String | Notes on the supplier                                                                                                                                 |
| info_number   | String | File number that appears at the bottom of the supplier record. Not to be confused with reference!                                                     |
| visual_url    | String | Link to the google Slides linked to the supplier in Ezus                                                                                              |
| user          | JSON   | One of the following option: `Everyone`, `User Group`, the User assigned to this supplier (JSON object containing `email`, `first_name`, `last_name`) |
| medias        | JSON   | JSON object medias ([Medias](#medias))                                                                                                                |
| address       | JSON   | JSON object address ([Address](#address))                                                                                                             |
| products      | JSON   | JSON object products ([Products](#products))                                                                                                          |
| contacts      | Array  | Array of JSON contacts ([Contacts](#contacts))                                                                                                        |
| langs         | Array  | Array of JSON langs ([Langs](#langs))                                                                                                                 |
| custom_fields | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                         |

## POST suppliers-upsert

Update a supplier record if the provided reference do matches one of the supplier references in your account, otherwise create a new supplier record with the provided reference (or with a random one if no reference is provided).

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "supplier_reference_1234",
  company_name: "supplier_company_name",
  capacity: 2,
  type: "accom, activity"
  contact: {
    firstname: "firstname",
    lastname: "lastname",
    gender: "Ms",
    email: "email@email.email",
    phone: "0606060606",
    birthdate: "2023-01-01",
  },
  address: {
    label: "58 Rue de Paradis",
    city: "Paris",
    country: "France",
    zip: "75009",
  },
  custom_fields: [
    { name: "field1", value: "field1Value" },
    { name: "field2", value: "field2Value" },
  ],
};
const headers = { "X-API-KEY": "<YOUR_API_KEY>", "Authorization": "Bearer <YOUR_TOKEN>" };

axios.post(baseUrl + "/suppliers-upsert", body, headers);
```

> It returns a JSON object structured like this:

```json
{
  "erreur": "false",
  "message": "ok",
  "action": "Supplier created Successfully",
  "reference": "supplier_reference_1234"
}
```

### HTTP Endpoint

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/suppliers-upsert`

### Header parameters

| Parameter     | Description                                                 |
| ------------- | ----------------------------------------------------------- |
| X-API-KEY     | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter     | Type   | Description                                                                                                                                                                                                       |
| ------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| reference     | String | If provided, the unique reference associated to the supplier you want to update or insert (in case the one you provided has never been used). If not provided, a supplier will be inserted with a random one.     |
| company_name  | String | Set a company name - If company name is empty, the supplier will be set as an individual and the name of the supplier will be the name of the contact                                                             |     |
| capacity      | Number | Capacity of the Supplier                                                                                                                                                                                          |
| type          | String | 3 Options: `accom`, `activity`, `transport`. You can select multiple options by typing "accom, activity" for exemple, the new data will erase old data. To add multiple options they must be separated by a comma |
| contact       | JSON   | Contact is a JSON and email is needed ([Contact](#contact))                                                                                                                                                       |
| address       | JSON   | Address is a JSON and label is needed if you want to add or update the adresse of your supplier but not mandatory ([Address](#address))                                                                           |
| custom_fields | JSON   | You can add custom fields for your supplier, this custom fields should be in your Ezus params and Write Exactly as they are written in your params technical name ([Custom fields](#custom-fields))               |

### Response

JSON object indicating whether an error has occured during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the supplier later on.

# Products

## GET product

Retrieve information for a product record in Ezus. You must specify to the Ezus API which product you wish to retrieve, by indicating the appropriate reference in your query parameter.

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = {
  "X-API-KEY": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/product?reference=product_reference_1234", {}, headers);
```

> It returns a JSON object structured like this:

```json
{
  "erreur": "false",
  "reference": "product_reference_1234",
  "title": "product_title",
  "capacity": 5,
  "quantity": "P",
  "vat_regime": "margin",
  "vat_rate": 20.0,
  "currency": "EUR",
  "budget_text": "Option",
  "budget_form": "Important",
  "budget_variable": "Display",
  "visual_url": "",
  "medias": {
    "data": [
      {
        "media_name": "img.jpeg",
        "path_full": "https://link-img.jpeg"
      }
    ],
    "size": 1
  },
  "supplier": {
    "reference": "supplier_reference_1234",
    "company_name": "supplier_company"
  },
  "package": {
    "reference": "package_reference_1234",
    "title": "packages_title"
  },
  "commission": {
    "commission_mode": "purchase",
    "commission_regime": "percent",
    "value": "10"
  },
  "langs": [
    {
      "lang": "french",
      "name": "product_title",
      "short_description": "",
      "long_description": ""
    }
  ],
  "tariffs": [
    {
      "reference": "tariff_reference_1234",
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
      "name": "CustomField",
      "value": "Value"
    }
  ]
}
```

### HTTP Endpoint

`GET https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/product`

### Header parameters

| Parameter     | Description                                                 |
| ------------- | ----------------------------------------------------------- |
| X-API-KEY     | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter | Type   | Description                                                                                 |
| --------- | ------ | ------------------------------------------------------------------------------------------- |
| reference | String | <span style="color:red">(Required)</span> The reference of the product you wish to retrieve |

### Response

JSON object containing the product information.

| Property        | Type   | Description                                                                                                                                                                                                      |
| --------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference       | String | The reference of the product you wish to retrieve                                                                                                                                                                |
| title           | String | Name of the product                                                                                                                                                                                              |
| capacity        | Number | Capacity of the product                                                                                                                                                                                          |
| quantity        | String | Quantity is the default number of this product at his creation (P = Number of people in the project, D = Number of days in the project, N = Number of nights in the project)                                     |
| vat_regime      | String | VAT regime of the product - 3 options: VAT on margin ("margin"), Common law ("classic") or VAT non applicable ("none")                                                                                           |
| vat_rate        | Number | Default % of the VAT on the product                                                                                                                                                                              |
| currency        | String | The ISO 4217 code who represent the currency you use (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>)            |
| budget_text     | String | `Option`, `On Demand` or `""`, if it's Option/On demand, by default the product will be an Option/On demand, the mention will be added on your documents. If it's empty no options will be applied on the budget |
| buget_form      | String | `Important`, `Normal`, `Low` represent how the product will be highlight on the budget By Default                                                                                                                |
| budget_variable | String | `Display`, `Do not Display`, this option tells if the product will be displayed or not in the budget                                                                                                             |
| visual_url      | String | URL of the Google slides linked to this product record in Ezus                                                                                                                                                   |
| medias          | JSON   | JSON object medias ([Medias](#medias))                                                                                                                                                                           |
| supplier        | JSON   | JSON object containing `reference`, `company_name`                                                                                                                                                               |
| package         | JSON   | JSON object containing `reference`, `title`                                                                                                                                                                      |
| commission      | JSON   | JSON object containing `value`, `commission_regime`, `commission_mode`                                                                                                                                           |
| langs           | Array  | Array of JSON langs ([Langs](#langs))                                                                                                                                                                            |
| tariffs         | Array  | Array of JSON tariffs ([Tariffs](#tariffs))                                                                                                                                                                      |
| custom_fields   | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                    |

## POST products-upsert

Update a product record if the provided reference do matches one of the product references in your account, otherwise create a new product record with the provided reference (or with a random one if no reference is provided).

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "product_reference_1234",
  title: "product_title",
  quantity: "3",
  capacity: 3,
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
  custom_fields: [
    { name: "field1", value: "field1Value" },
    { name: "field2", value: "field2Value" },
  ],
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
  "erreur": "false",
  "message": "ok",
  "action": "Product Created Successfully",
  "reference": "product_reference_1234"
}
```

### HTTP Endpoint

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/products-upsert`

### Header parameters

| Parameter     | Description                                                 |
| ------------- | ----------------------------------------------------------- |
| X-API-KEY     | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter          | Type    | Description                                                                                                                                                                                                                                                                                                                                         |
| ------------------ | ------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference          | String  | If provided, the unique reference associated to the product you want to update or insert (in case the one you provided has never been used). If not provided, a product will be inserted with a random one.                                                                                                                                         |
| title              | String  | If no reference or reference not found, the title is mandatory                                                                                                                                                                                                                                                                                      |
| quantity           | String  | Quantity is the default number of this product at his creation (P = Number of people in the project, D = Number of days in the project, N = Number of nights in the project)                                                                                                                                                                        |
| capacity           | Int     | Capacity is the default capacity of the product                                                                                                                                                                                                                                                                                                     |
| supplier_reference | String  | The reference to the supplier, if you give a reference, the product will be added in the supplier                                                                                                                                                                                                                                                   |
| package_reference  | String  | The reference to the package, if you give a reference, the product will be added in the package                                                                                                                                                                                                                                                     |
| purchase_price     | float   | Purchase price as number                                                                                                                                                                                                                                                                                                                            |
| sales_price        | float   | Sales price as number                                                                                                                                                                                                                                                                                                                               |
| vat_regime         | Options | 'classic', 'margin', 'none', Thoses options allows to choose your VAT Regime, in margin mode, VAT will be calculated on your margin. Classic mode, VAT will be calculated on your selling price. In none mode, no VAT will be applied. If empty will be set at your default account values                                                          |
| vat_rate           | float   | Default VAT rate, if empty will be set at your default account VAT rate                                                                                                                                                                                                                                                                             |
| currency           | String  | The ISO 4217 code who represent the currency you use (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to Doc</a>) If the currency is not set in your account, your default currency will be set                                                                 |
| commission         | JSON    | JSON object containing `value`: Commission as number, `commission_regime`: The commission regime can be "percent" (commission is a percent of the buying/selling price) or "currency" (commission is a fix value) and `commission_mode`: "default" or "purchase" default mode is base on the buying price, purchase mode based on the selling price |
| custom_fields      | JSON    | You can add Custom Fields for your product, this custom fields should be in your Ezus params and Write Exactly as they are written in your params technical name ([Custom fields](#custom-fields))                                                                                                                                                  |

### Response

JSON object indicating whether an error has occured during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the product later on.

# Package

## GET package

Retrieve information for a package record in Ezus. You must specify to the Ezus API which package you wish to retrieve, by indicating the appropriate reference in your query parameter.

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = {
  "X-API-KEY": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/package?reference=package_reference_1234", {}, headers);
```

> It returns a JSON object structured like this:

```json
{
  "erreur": "false",
  "reference": "package_reference_1234",
  "title": "packages_title",
  "capacity": "3",
  "info_notes": "Notes on the Package",
  "visual_url": "urlofthepackage.com",
  "medias": {
    "data": [
      {
        "media_name": "img.jpeg",
        "path_full": "https://link-img.jpeg"
      }
    ],
    "size": 1
  },
  "suppliers": {
    "data": [
      {
        "reference": "supplier_reference_1234",
        "company_name": "supplier_company"
      }
    ],
    "size": 1
  },
  "products": {
    "data": [
      {
        "reference": "product_reference_1234",
        "title": "product_title"
      }
    ],
    "size": 1
  },
  "langs": [
    {
      "lang": "french",
      "name": "packages_title (FR)",
      "short_description": "short_description (FR)",
      "long_description": "long_description (FR)"
    },
    {
      "lang": "english",
      "name": "packages_title (GB)",
      "short_description": "short_description (GB)",
      "long_description": "long_description (GB)"
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

`GET https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/package`

### Header parameters

| Parameter     | Description                                                 |
| ------------- | ----------------------------------------------------------- |
| X-API-KEY     | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | <span style="color:red">(Required)</span> Your Bearer token |

### Query parameters

| Parameter | Type   | Description                                                                                 |
| --------- | ------ | ------------------------------------------------------------------------------------------- |
| reference | String | <span style="color:red">(Required)</span> The reference of the package you wish to retrieve |

### Response

JSON object containing the package information.

| Property      | Type   | Description                                                 |
| ------------- | ------ | ----------------------------------------------------------- |
| reference     | String | The reference of the package you wish to retrieve           |
| title         | String | Name of the package                                         |
| capacity      | String | Capacity of the package                                     |
| info_notes    | String | Notes on the package budget                                 |
| visual_url    | String | URL of the google slides linked to this package             |
| medias        | JSON   | JSON object medias ([Medias](#medias))                      |
| suppliers     | JSON   | JSON object suppliers ([Suppliers](#suppliers))             |
| products      | JSON   | JSON object products ([Products](#products))                |
| langs         | Array  | Array of JSON langs ([Langs](#langs))                       |
| custom_fields | Array  | Array of JSON custom fields [Custom fields](#custom-fields) |

## POST packages_upsert

Update a package record if the provided reference do matches one of the package references in your account, otherwise create a new package record with the provided reference (or with a random one if no reference is provided).

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "package_reference",
  title: "package_title",
  capacity: "3",
  custom_fields: [
    { name: "field1", value: "field1Value" },
    { name: "field2", value: "field2Value" },
  ],
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
  "erreur": "false",
  "message": "ok",
  "action": "Package Created Successfully",
  "reference": "package_reference_1234"
}
```

### HTTP Endpoint

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/packages-upsert`

### Header parameters

| Parameter     | Description                                                 |
| ------------- | ----------------------------------------------------------- |
| X-API-KEY     | <span style="color:red">(Required)</span> Your Ezus API key |
| Authorization | <span style="color:red">(Required)</span> Your Bearer token |

### Body parameters (application/json)

| Parameter     | Type   | Description                                                                                                                                                                                                      |
| ------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| reference     | String | If provided, the unique Ezus Reference associated to the package you want to update or insert (in case the one you provided has never been used). If not provided, a package will be inserted with a random one. |
| title         | String | If no reference or reference not found, the title is mandatory                                                                                                                                                   |
| capacity      | Number | capacity is the default number of this package at his creation                                                                                                                                                   |     |
| custom_fields | JSON   | You can add custom fields for your client, this custom fields should be in your Ezus params and Write exactly as they are written in your params technical name ([Custom fields](#custom-fields))                |

### Response

JSON object indicating whether an error has occured during the process and, if so, the associated message. If there is no error, it also returns a `reference`: you will need to store this reference if you need to update or retrieve the package later on.

# Nested Resource

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

### Custom Fields

<aside class="success">
In an upsert, the custom_fields must be called with their technical_name which you can find in your custom field settings
</aside>

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

### Alternatives

```json
  "alternatives": [
    {
      "alternative_title": "Alternative 1",
      "trip_people": "15",
      "trip_budget": "0",
      "trip_date_in": "2022-07-31",
      "trip_date_out": "2022-08-02",
      "trip_duration": "2",
      "trip_destination": "France",
      "trip_subdestination": "Paris",
      "client": {
        "reference": "client_reference_1234",
        "type": "entreprise",
        "company_name": "Client Company Name",
        "first_name": "Client First Name",
        "last_name": "Client Last Name",
        "email": "client@email.com"
      }
    }
  ]
```

| Property            | Type   | Description                                                                                                              |
| ------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------ |
| alternative_title   | String | Title of the alternative                                                                                                 |
| trip_people         | String | Number of people                                                                                                         |
| trip_budget         | Number | Forecasted budget of the alternative (the one that is entered manually not the actual one)                               |
| trip_date_in        | String | Date of the begining of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project have no dates      |
| trip_date_out       | String | Date of the end of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project have no dates           |
| trip_duration       | String | Number of days this alternative last                                                                                     |
| trip_destination    | String | Destination of the alternative                                                                                           |
| trip_subdestination | String | Subdestination of the alternative                                                                                        |
| client              | JSON   | JSON that contain: `reference`, `type` (entreprise or individual), `company_name`, `first_name`, `last_name` and `email` |

### Address

```json
   "address": {
    "label": "58 Rue de Paradis",
    "zip": "75009",
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

### Contact

```json
"contact": {
  "first_name": "first_name",
  "last_name": "last_name",
  "gender": "Ms",
  "email": "contact@email.com",
  "phone": "0606060606",
  "birth_date": "2023-01-01",
},

```

| Property   | Type   | Description                                             |
| ---------- | ------ | ------------------------------------------------------- |
| email      | String | Email of the contact                                    |
| first_name | String | First name of the contact as a string                   |
| last_name  | String | Last name of the contact as a string                    |
| gender     | String | `Mr`, `Ms` or `Undefined`                               |
| phone      | String | Phone of the contact as a string                        |
| birth_date | String | Contact's date of birth in a "YYYY-MM-DD" format string |

### Tariffs

```json
  "tariffs": [
    {
      "reference": "tariff_1234",
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
