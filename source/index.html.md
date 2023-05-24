---
title: API Reference

language_tabs: # must be one of https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers
  - javascript

toc_footers:
  - <a href='https://ezus.io/'>Documentation Powered by Ezus</a>

includes:
  - errors

search: true

code_clipboard: true

meta:
  - name: description
    content: Documentation for the Ezus API
---

<aside class="success">
The api is not yet online, it will be released in the coming weeks
</aside>

# Introduction

Welcome to the EZUS API! You can use our API to access Ezus API endpoints, which can get information on various users data or clients in our database.

We have language bindings in JavaScript! You can view code examples in the dark area to the right.

<aside class="success">
You can find here a (<a href="https://ezus-team.postman.co/workspace/Ezus-APIs~523409cf-e5b3-429b-8b49-0eb1e1273aa6/collection/24284707-8922dc39-5057-49b9-b6e8-bdfc13dec333?action=share&creator=24284707" target="_blank"> Postman Collection</a>) with all the API routes with test data
</aside>

# Authentication

> To authorize, use this code:

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  email: "xxx",
  password: "xx",
};
const headers = { "X-API-KEY": "ApiKey" };

axios.post(baseUrl + "/login", body, headers);
```

> The above command returns JSON structured like this:

```json
[
  {
    "message": "ok",
    "erreur": "false",
    "token": "<YOUR_TOKEN>"
  }
]
```

> Make sure to replace `<YOUR_TOKEN>` in the Authorization Header to use our API in the next steps

EZUS uses API keys to allow access to the API. If you don't have an Ezus account, you can ask for a demo on our [Website](https://ezus.io/).

Ezus expects for the API key to be included in all API requests to the server in a header that looks like the following:

`X-API-KEY: ApiKey`

To get your API key, you have to ask to your account manager

After calling the login route, a bearer token will be returned to you, it must be included in the header of all your calls to the Ezus APIBody Parameters (JSON)

`Authorization: Bearer <YOUR_TOKEN>`

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/login`

### Headers

| Parameter | Description                           |
| --------- | ------------------------------------- |
| X-API-KEY | API key given by your account manager |

### Body Parameters (JSON)

| Parameter | Description           |
| --------- | --------------------- |
| email     | Your account email    |
| password  | Your account password |

<aside class="notice">
You must replace <code>ApiKey</code> with your personal API key.
</aside>

# Projects

## POST projects-upsert

In Ezus, a project is a travel or event project, with or without destination, dates, budget and a number of people. It contains prestations, transportation and accommodation.

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "projects_reference",
  info_title: "project_title",
  trip_people: "15",
  trip_budget: "3000",
  trip_date_in: "2022-07-31",
  trip_date_out: "2022-08-02",
  sales_manager_email: "emailofthesales@mail.com",
  client_reference: "client_reference",
  custom_fields: [
    { name: "Text", value: "I am not a text" },
    { name: "Dropdown", value: "nameOption2" },
    { name: "Date", value: "2012-11-24" },
    { name: "Time", value: "2006-10-07T12:06:56.568+01:00" },
    { name: "Checkbox", value: "true" },
  ],
};
const headers = { "X-API-KEY": "ApiKey", Authorization: "Bearer <YOUR_TOKEN>" };

axios.post(baseUrl + "/projects-upsert", body, headers);
```

> The above command returns JSON structured like this:

```json
[
  {
    "erreur": "false",
    "message": "ok",
    "id": "89e48bb3-26ef-4b1e-aa60-b86ce714253d",
    "action": "Project Updated Successfuly",
    "reference": "89e48bb3-26ef-4b1e-aa60-b86ce714253d"
  }
]
```

This endpoint upsert a project. This endpoint take the reference as a primary key, if the reference already exist, the project linked to the account will be updated, if the reference doesn't exist, a new project will be created with all the given params.

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/projects-upsert`

### Body Parameters (JSON)

<aside class="comment">
If you do not add an optionnal parameter, it will be empty for a creation or simply not updated for an update. If the parameter is empty (""), same behaviour
</aside>

| Parameter           | Type   | Description                                                                                                                                                                                                                                              |
| ------------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference           | String | The project Reference used as a primary key to check if the project already exist and UPDATE it or to create a new Project so be sure to use a unique Ezus Reference for each of your project                                                            |
| info_title          | String | Title of your project, mandatory if you create a New Project                                                                                                                                                                                             |
| trip_people         | Number | Number of people in your project                                                                                                                                                                                                                         |
| trip_budget         | Number | Budget of your project                                                                                                                                                                                                                                   |
| trip_date_in        | Date   | Date of the beginning of your project formated like YYYY-MM-DD if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1day and date = today. If project is without Date, no date will be setted |
| trip_date_out       | Date   | Date of the end of your project formated like YYYY-MM-DD if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1day and date = today. If project is without Date, no date will be setted       |
| sales_manager_email | Email  | Email of the Sales Manager, by default if no sales_manager or not found will be assignated to nobody                                                                                                                                                     |
| client_reference    | String | Ezus Reference or Email of the Client, if the reference don't match with a client, API will try with client_email if setted else, No clients will be assigned                                                                                            |
| custom_fields       | JSON   | You can add Custom Fields for your client, this custom fields should be in your Ezus params and Write Exactly as they are written in your params technical name ([Custom fields](#custom-fields))                                                        |

<aside class="success">
Remember — You have to be authenticated to call this API with your bearer token
</aside>

## GET project

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = { "X-API-KEY": "ApiKey", Authorization: "Bearer <YOUR_TOKEN>" };

axios.post(baseUrl + "/project?reference=reference", {}, headers);
```

> The above command returns JSON structured like this:

```json
{
  "erreur": "false",
  "reference": "project-reference",
  "info_title": "Project Title",
  "info_stage": "Confirmed",
  "info_notes": "Notes on the project",
  "info_reference": "202302061-P",
  "traveler_designer": {
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
      "destination": "Destination",
      "subdestination": "Subdestination",
      "trip_duration": "2",
      "client": {
        "reference": "Client reference",
        "type": "entreprise",
        "company_name": "Client Company Name",
        "first_name": "Client First Name",
        "last_name": "Client Last Name",
        "email": "melchiorbengtsson@gmail.com"
      }
    },
    {
      "alternative_title": "Main Alternative",
      "trip_people": "15",
      "trip_budget": "300",
      "trip_date_in": "2022-07-31",
      "trip_date_out": "2022-08-02",
      "destination": "Destination",
      "subdestination": "Subdestination",
      "trip_duration": "2",
      "client": {
        "reference": "Client Reference",
        "type": "individual",
        "company_name": "Client Company Name",
        "first_name": "Client First Name",
        "last_name": "Client Last Name",
        "email": "melchiorbengtsson@gmail.com"
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

### HTTP Request

`GET https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/project?reference=reference`

### Returned Values

| Name              | Type   | Value                                                                                                                                                  |
| ----------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| reference         | String | The Reference of the given project - The one you gave                                                                                                  |
| info_title        | String | The title of your project                                                                                                                              |
| info_stage        | String | The stage of your project (Confirmed, Received, Paid...)                                                                                               |
| info_notes        | String | Notes on your project                                                                                                                                  |
| info_reference    | String | Reference of your project ex: "202208019-P" (It is a project number that appears at the bottom of the project file. Not to be confused with reference) |
| traveler_designer | JSON   | Travel designer is a Json that contain `email`, `first_name` and `last_name`                                                                           |
| project_manager   | JSON   | Project manager is a Json that contain `email`, `first_name` and `last_name`                                                                           |
| alternatives      | Array  | An array of alternatives                                                                                                                               |
| custom_fields     | Array  | Array of custom fields that contain name and value as string ([Custom fields](#custom-fields))                                                         |

### alternatives

| Name              | Type   | Value                                                                                                                     |
| ----------------- | ------ | ------------------------------------------------------------------------------------------------------------------------- |
| alternative_title | String | Title of the alternative                                                                                                  |
| trip_people       | String | Number of people                                                                                                          |
| trip_budget       | Number | Budget of the alternative                                                                                                 |
| trip_date_in      | String | Date of the begining of this alternative, formated like : YYYY-MM-DD if it's empty, the project have no dates             |
| trip_date_out     | String | Date of the end of this alternative, formated like : YYYY-MM-DD if it's empty, the project have no dates                  |
| destination       | String | Destination of the alternative                                                                                            |
| subdestination    | String | Subdestination of the alternative                                                                                         |
| trip_duration     | String | Number of days                                                                                                            |
| client            | JSON   | Json that contain : `reference`, `type` (entreprise or individual), `company_name`, `first_name`, `last_name` and `email` |

<aside class="success">
Remember — You have to be authenticated to call this API with your bearer token
</aside>
## POST projects-documents-create

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "document_reference",
  title: "Document test",
  link: "https://www.linktothedocument.pdf",
};
const headers = { "X-API-KEY": "ApiKey", Authorization: "Bearer <YOUR_TOKEN>" };

axios.post(baseUrl + "/projects-documents-create", body, headers);
```

> The above command returns JSON structured like this:

```json
[
  {
    "erreur": "false",
    "message": "ok",
    "id": "89e48bb3-26ef-4b1e-aa60-b86ce714253d"
  }
]
```

This endpoint insert a document in a project.

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/projects-documents-create`

### Body Parameters (JSON)

| Parameter | Type   | Description                             |
| --------- | ------ | --------------------------------------- |
| reference | String | The project reference                   |
| title     | String | Title of your document                  |
| link      | Link   | Link to the desired document (ONLY PDF) |

<aside class="success">
Remember — You have to be authenticated to call this API with your bearer token
</aside>

# Clients

## POST clients-upsert

In Ezus, a client is a person or a company to whom you will sell your projects

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
const headers = { "X-API-KEY": "ApiKey", Authorization: "Bearer <YOUR_TOKEN>" };

axios.post(baseUrl + "/clients-upsert", body, headers);
```

> The above command returns JSON structured like this:

```json
[
  {
    "erreur": "false",
    "message": "ok",
    "action": "Client updated Successfully",
    "reference": "clientReference"
  }
]
```

This endpoint Upsert a Client. The reference should be unique and allows to update an existing client or create a new client. If reference is not given, the email params is used as a primary key for your clients If you have multiple clients with the same email, the first client will be taken. If a client with this email already exist. An Ezus reference will be returned you must have to save it for your next uses. `this one will be updated with the new Params Given here.`

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/clients-upsert`

### Body Parameters (JSON)

<aside class="comment">
If you do not add an optionnal parameter, it will be empty for a creation or simply not updated for an update. If the parameter is empty (""), same behaviour
</aside>
| Parameter    | Type    | Description                                                                                                     |
| ------------ | ------  | --------------------------------------------------------------------------------------------------------------- |
| reference     | String | Used as a primary key in the database, if no reference, the reference will be generated automatically and returned|
| company_name | String       | Set a company name - If company name is empty, the client will be set as an individual and the name of the client = name of the contact and if the company name is not empty, the name of the client will be the company name |                         |
| contact      | JSON        | Contact is a JSON and email is needed ([Contact](#contact))                                                                            |
| address      | JSON         | Address is a JSON and label is needed if you want to add or update the adresse of your client but not mandatory ([Address](#address)) |
| custom_fields      | JSON         | You can add custom fields for your client, this custom fields should be in your Ezus params and Write exactly as they are written in your params technical name ([Custom fields](#custom-fields))   |

<aside class="success">
Remember — You have to be authenticated to call this API with your bearer token
</aside>

## GET client

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = { "X-API-KEY": "ApiKey", Authorization: "Bearer <YOUR_TOKEN>" };

axios.post(baseUrl + "/client?reference=reference", {}, headers);
```

> The above command returns JSON structured like this:

```json
{
  "erreur": "false",
  "reference": "client_reference",
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
  "info_reference": "Reference of the Client",
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
        "reference": "project_reference",
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

### HTTP Request

`GET https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/client?reference=reference`

### Returned Values

| Name           | Type   | Value                                                                                                                                                    |
| -------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference      | String | The reference of the given client - The one you gave                                                                                                     |
| type           | String | The type of the client ["entreprise", "individual"]                                                                                                      |
| company_name   | String | Name of the company of your client                                                                                                                       |
| first_name     | String | First name of the client                                                                                                                                 |
| last_name      | String | Last name of the client                                                                                                                                  |
| email          | String | Email of the client                                                                                                                                      |
| activity       | String | Activity of the client (Only for entreprise)                                                                                                             |
| vat_number     | String | VAT number of the client (Only for entreprise)                                                                                                           |
| siret          | String | Siret number of the client (Only for entreprise)                                                                                                         |
| info_profile   | String | info_profile of the client                                                                                                                               |
| info_origin    | String | Source of the client                                                                                                                                     |
| info_notes     | String | Notes on the client                                                                                                                                      |
| info_reference | String | Reference of the client (It is a client number that appears at the bottom of the client file. Not to be confused with reference)                         |
| user           | JSON   | User assigned to the client is a JSON who contain `email`, `first_name` and `last_name`                                                                  |
| address        | JSON   | Address of the client JSON who contain `label`, `zip`, `city` and `country` ([Address](#address))                                                        |
| projects       | JSON   | "data": Array of json who contains {`reference`, `info_title`} Only 10 projects returned, "size": Contain number of projects where the client is present |
| contacts       | Array  | Array of json who contains `first_name`, `last_name`, `email`                                                                                            |
| custom_fields  | Array  | Array of json who contains `name`, `value` ([Custom fields](#custom-fields))                                                                             |

<aside class="success">
Remember — You have to be authenticated to call this API with your bearer token
</aside>

# Suppliers

## POST suppliers-upserts

In Ezus, a supplier is a company, which will charge you for prestations. It can be a hotel, an airline or a kanoe club

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "suppliers_reference",
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
const headers = { "X-API-KEY": "ApiKey", Authorization: "Bearer <YOUR_TOKEN>" };

axios.post(baseUrl + "/suppliers-upsert", body, headers);
```

> The above command returns JSON structured like this:

```json
[
  {
    "erreur": "false",
    "message": "ok",
    "action": "Supplier created Successfully",
    "reference": "SupplierReference"
  }
]
```

This endpoint upsert a supplier. The reference should be unique and allows to update an existing supplier or Create a new supplier. If reference is not given, the email params is used as a primary key for your suppliers If you have multiple suppliers with the same email, the first supplier will be taken. If a supplier with this email already exist. An Ezus reference will be returned you must have to save it for your next uses. `this one will be updated with the new Params Given here.`

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/suppliers-upsert`

### Body Parameters (JSON)

<aside class="comment">
If you do not add an Optionnal parameter, it will be empty for a creation or simply not updated for an update. If the parameter is empty (""), same behaviour
</aside>
| Parameter    | Type    | Description                                                                                                     |
| ------------ | ------  | --------------------------------------------------------------------------------------------------------------- |
| reference     | String | Used as a primary key in the database, if no reference, the reference will be generated automatically|
| company_name | String       | Set a company name - If company name is empty, the supplier will be set as an individual and the name of the supplier will be the name of the contact |                         |
| capacity     | Number | Capacity of the Supplier|
| type     | String | 3 Option : `accom`, `activity`, `transport`. You can select multiple options by typing "accom, activity" for exemple, the new data will erase old data. To add multiple options they must be separated by a comma|
| contact      | JSON        | Contact is a JSON and email is needed ([Contact](#contact))                                                                          |
| address      | JSON         | Address is a JSON and label is needed if you want to add or update the adresse of your supplier but not mandatory ([Address](#address))|
| custom_fields      | JSON         | You can add custom fields for your client, this custom fields should be in your Ezus params and Write Exactly as they are written in your params technical name ([Custom fields](#custom-fields))   |

<aside class="success">
Remember — You have to be authenticated to call this API with your bearer token
</aside>

## GET supplier

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = { "X-API-KEY": "ApiKey", Authorization: "Bearer <YOUR_TOKEN>" };

axios.post(baseUrl + "/supplier?reference=reference", {}, headers);
```

> The above command returns JSON structured like this:

```json
{
  "erreur": "false",
  "reference": "supplier_reference",
  "company_name": "Company Name",
  "capacity": "3",
  "type": "accom, activity",
  "info_notes": "Notes on the supplier",
  "info_reference": "Reference of the Supplier",
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
        "reference": "products_reference",
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

### HTTP Request

`GET https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/supplier?reference=reference`

### Returned Values

| Name           | Type   | Value                                                                                                                                            |
| -------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| reference      | String | The Reference of the given supplier - The one you gave                                                                                           |
| company_name   | String | Name of the company of your supplier                                                                                                             |
| capacity       | String | Capacity of the supplier                                                                                                                         |
| type           | String | Type of the supplier, the different types are separated by commas                                                                                |
| info_notes     | String | Notes on the supplier                                                                                                                            |
| info_reference | String | Reference of the supplier (It is a supplier number that appears at the bottom of the supplier file. Not to be confused with reference)           |
| visual_url     | String | Link to the google Slides linked to the supplier in Ezus                                                                                         |
| user           | JSON   | User assigned to the supplier JSON who contain `email`, `first_name`, `last_name`                                                                |
| medias         | JSON   | Medias linked to the supplier, `data` contain Array of json who contains {`media_name`, `path_full`} and `size`. Return only the 10 first images |
| address        | JSON   | Address of the supplier JSON who contain `label`, `zip`, `city` and `country` ([Address](#address))                                              |
| products       | JSON   | `data` contain Array of json who contains `reference`, `title` and `size`. Return only the 10 first products                                     |
| contacts       | Array  | Contacts Assigned to the supplier formated in an Array of Json who contains `first_name`, `last_name`, `email`                                   |
| langs          | Array  | Array of Json who contains `lang`, `name`, `short_description` and `long_description` ([Langs](#langs))                                          |
| custom_fields  | Array  | Array of Json who contains `name`, `value` ([Custom fields](#custom-fields))                                                                     |

<aside class="success">
Remember — You have to be authenticated to call this API with your bearer token
</aside>
# Products

## POST products-upsert

In Ezus, a product is an element that can be included in a project or a step, like a night in a hotel, a flight from Paris to Tokyo or a parachute jump

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "product_reference",
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
    commission_regime: "%",
    value: "10",
  },
  custom_fields: [
    { name: "field1", value: "field1Value" },
    { name: "field2", value: "field2Value" },
  ],
};
const headers = {
  "X-API-KEY": "ApiKey",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/products-upsert", body, headers);
```

> The above command returns JSON structured like this:

```json
[
  {
    "erreur": "false",
    "message": "ok",
    "action": "Product Created Successfully",
    "reference": "productReference"
  }
]
```

This endpoint upsert a product. The reference should be unique and allows to update an existing product or create a new product. If reference is not given, the product will be created. An Ezus reference will be returned you must have to save it for your next updates of this product. `this one will be updated with the new Params Given here.`

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/products-upsert`

### Body Parameters (JSON)

<aside class="comment">
If you do not add an optionnal parameter, it will be empty for a creation or simply not updated for an update. If the parameter is empty (""), same behaviour
</aside>

| Parameter          | Type    | Description                                                                                                                                                                                                                                                                                                                               |
| ------------------ | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference          | String  | To update a product, reference is mandatory, the reference will be used as a Primary Key, in case of creation, a unique reference will be returned if you create a new product you can give a unique reference this one will be used as Ezus reference                                                                                    |
| title              | String  | If no reference or reference not found, the title is mandatory                                                                                                                                                                                                                                                                            |
| quantity           | String  | Quantity is the default number of this product at his creation (P = Number of people in the project, D = Number of days in the project, N = Number of nights in the project)                                                                                                                                                              |
| capacity           | Int     | Capacity is the default capacity of the product                                                                                                                                                                                                                                                                                           |
| supplier_reference | String  | The reference to the supplier, if you give a reference, the product will be added in the supplier                                                                                                                                                                                                                                         |
| package_reference  | String  | The reference to the package, if you give a reference, the product will be added in the package                                                                                                                                                                                                                                           |
| purchase_price     | float   | Purchase price as number                                                                                                                                                                                                                                                                                                                  |
| sales_price        | float   | Sales price, the margin rate will be calculated in function of this price.                                                                                                                                                                                                                                                                |
| vat_regime         | Options | 'classic', 'margin', 'none', Thoses options allows to choose your VAT Regime, in margin mode, VAT will be calculated on your margin. Classic mode, VAT will be calculated on your selling price. In none mode, no VAT will be applied. If empty will be set at your default account values                                                |
| vat_rate           | float   | Default VAT rate, if empty will be set at your default account VAT rate                                                                                                                                                                                                                                                                   |
| currency           | String  | The ISO 4217 code who represent the currency you use (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to Doc</a>)                                                                                                                                     |
| commission         | JSON    | JSON who contain: `value`: Commission as number, `commission_regime` : The commission regime can be "%" (commission is a percent of the buying/selling price) or "currency" (commission is a fix value) and `commission_mode`: "default" or "purchase" default mode is base on the buying price, purchase mode based on the selling price |
| custom_fields      | JSON    | You can add Custom Fields for your client, this custom fields should be in your Ezus params and Write Exactly as they are written in your params technical name ([Custom fields](#custom-fields))                                                                                                                                         |

<aside class="success">
Remember — You have to be authenticated to call this API with your bearer token
</aside>

## GET product

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = { "X-API-KEY": "ApiKey", Authorization: "Bearer <YOUR_TOKEN>" };

axios.post(baseUrl + "/product?reference=reference", {}, headers);
```

> The above command returns JSON structured like this:

```json
{
  "erreur": "false",
  "reference": "products_reference",
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
    "reference": "suppliers_reference",
    "company_name": "supplier_company"
  },
  "package": {
    "reference": "packages_reference",
    "title": "packages_title"
  },
  "commission": {
    "commission_mode": "purchase",
    "commission_regime": "%",
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
  "rates": [
    {
      "id": "fbb69d5a-bebb-45bd-a8ad-d6a18ac36109",
      "reference": null,
      "type": "default",
      "name": "",
      "purchase_price_pretax": 100.0,
      "margin_rate": 50.0,
      "sale_price_pretax": 200.0,
      "prestation_id": "48b25fd1-bb7b-4c49-a774-214ffa22fbb6",
      "tariff_id": null,
      "child": []
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

### HTTP Request

`GET https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/product?reference=reference`

### Returned Values

| Name            | Type   | Value                                                                                                                                                                                                                                                                                                                                     |
| --------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference       | String | The reference of the given product - The one you gave                                                                                                                                                                                                                                                                                     |
| title           | String | Name of the product                                                                                                                                                                                                                                                                                                                       |
| capacity        | Number | Capacity of the product                                                                                                                                                                                                                                                                                                                   |
| quantity        | String | Quantity is the default number of this product at his creation (P = Number of people in the project, D = Number of days in the project, N = Number of nights in the project)                                                                                                                                                              |
| vat_regime      | String | VAT regime of the product - 3 options: VAT on margin ("margin"), Common law ("classic") or VAT non applicable ("none")                                                                                                                                                                                                                    |
| vat_rate        | Number | Default % of the VAT on the product                                                                                                                                                                                                                                                                                                       |
| currency        | String | The ISO 4217 code who represent the currency you use (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>)                                                                                                                                     |
| budget_text     | String | `Option`, `On Demand` or `""`, if it's Option/On demand, by default the product will be an Option/On demand, the mention will be added on your documents. If it's empty no options will be applied on the budget                                                                                                                          |
| buget_form      | String | `Important`, `Normal`, `Low` represent how the product will be highlight on the budget By Default                                                                                                                                                                                                                                         |
| budget_variable | String | `Display`, `Do not Display`, this option tells if the product will be displayed or not in the budget                                                                                                                                                                                                                                      |
| visual_url      | String | URL of the Google slides linked to this product record in Ezus                                                                                                                                                                                                                                                                            |
| medias          | JSON   | Medias linked to the product, `data` contain Array of json who contains {`media_name`, `path_full`} and `size`. Return only the 10 first images                                                                                                                                                                                           |
| supplier        | JSON   | JSON who contains `reference`, `company_name`                                                                                                                                                                                                                                                                                             |
| package         | JSON   | JSON who contains `reference`, `title`                                                                                                                                                                                                                                                                                                    |
| commission      | JSON   | JSON who contain: `value`: Commission as number, `commission_regime` : The commission regime can be "%" (commission is a percent of the buying/selling price) or "currency" (commission is a fix value) and `commission_mode`: "default" or "purchase" default mode is base on the buying price, purchase mode based on the selling price |
| langs           | Array  | Array of json who contains `lang`, `name`, `short_description`, `long_description` ([Langs](#langs))                                                                                                                                                                                                                                      |
| rates           | Array  | Array of json who contains `reference`, `type`, `name`, `purchase_price_pretax`, `margin_rate`, `sale_price_pretax`, `child` ([Rates](#rates))                                                                                                                                                                                            |
| custom_fields   | Array  | Array of json who contains `name`, `value` ([Custom fields](#custom-fields))                                                                                                                                                                                                                                                              |

<aside class="success">
Remember — You have to be authenticated to call this API with your bearer token
</aside>
                                                                                                                    |

# Package

## POST package_upsert

In Ezus, a package is a group of products and is intended to be added more easily to a project

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
const headers = { "X-API-KEY": "ApiKey", Authorization: "Bearer <YOUR_TOKEN>" };

axios.post(baseUrl + "/package-upsert", body, headers);
```

> The above command returns JSON structured like this:

```json
[
  {
    "erreur": "false",
    "message": "ok",
    "action": "Package Created Successfully",
    "reference": "packageReference"
  }
]
```

This endpoint upsert a package. The reference should be unique and allows to update an existing package or create a new package. If reference is not given, the package will be created. An Ezus reference will be returned you must have to save it for your next updates of this package. `this one will be updated with the new Params Given here.`

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/package-upsert`

### Body Parameters (JSON)

<aside class="comment">
If you do not add an Optionnal parameter, it will be empty for a creation or simply not updated for an update. If the parameter is empty (""), same behaviour
</aside>

| Parameter     | Type   | Description                                                                                                                                                                                       |
| ------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| reference     | String | To update a package, Reference is mandatory, the reference will be used as a primary key, in case of creation, a unique reference will be returned                                                |
| title         | String | If no reference or reference not found, the title is mandatory                                                                                                                                    |
| capacity      | Number | capacity is the default number of this package at his creation                                                                                                                                    |     |
| custom_fields | JSON   | You can add custom fields for your client, this custom fields should be in your Ezus params and Write exactly as they are written in your params technical name ([Custom fields](#custom-fields)) |

<aside class="success">
Remember — You have to be authenticated to call this API with your bearer token
</aside>

## GET package

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = { "X-API-KEY": "ApiKey", Authorization: "Bearer <YOUR_TOKEN>" };

axios.post(baseUrl + "/package?reference=reference", {}, headers);
```

> The above command returns JSON structured like this:

```json
{
  "erreur": "false",
  "reference": "packages_reference",
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
        "reference": "suppliers_reference",
        "company_name": "supplier_company"
      }
    ],
    "size": 1
  },
  "products": {
    "data": [
      {
        "reference": "products_reference",
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

### HTTP Request

`GET https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/package?reference=reference`

### Returned Values

| Name          | Type   | Value                                                                                                                                          |
| ------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| reference     | String | The reference of the given package - The one you gave                                                                                          |
| title         | String | Name of the package                                                                                                                            |
| capacity      | String | Capacity of the package                                                                                                                        |
| info_notes    | String | Notes on the package budget                                                                                                                    |
| visual_url    | String | URL of the google slides linked to this package                                                                                                |
| medias        | JSON   | Medias linked to the package `data` contain Array of json who contains {`media_name`, `path_full`} and `size`. Return only the 10 first images |
| suppliers     | JSON   | `data` contain Array of json who contains {`reference`, `company_name`} and `size`. Return only the 10 first suppliers                         |
| products      | JSON   | `data` contain Array of json who contains {`reference`, `title`} and `size`. Return only the 10 first products                                 |
| langs         | Array  | Array of json who contains `lang`, `name`, `short_description`, `long_description` ([Langs](#langs))                                           |
| custom_fields | Array  | Array of json who contains `name`, `value` [Custom fields](#custom-fields)                                                                     |

<aside class="success">
Remember — You have to be authenticated to call this API with your bearer token
</aside>

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
The custom_fields must be called with their technical_name which you can find in your custom field settings, and should respect the given formatting, if they do not respect this formatting, they will be updated with their default values.
</aside>

<aside class="warning">
Warning: the custom_fields of the projects route must have their real name and not their technical_name in "name"
</aside>

| Options           | Type   | Value                                                                                                                                                                                          |
| ----------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Text              | String | Simple string like Text Area                                                                                                                                                                   |
| Dropdown          | String | The option must be written exactly as in the parameters, respecting the case                                                                                                                   |
| Multiple Dropdown | String | The option must be written exactly as in the parameters, respecting the case, for Multiple Answer you should enter Option1/-/Option2/-/Option3 in a string, "/-/" should separate each options |
| Date              | String | The date must be written exactly in YYYY-MM-DD format                                                                                                                                          |
| Time              | String | The time must be written exactly in the format: YYYY-MM-DDTHH:MM:SS+01:00                                                                                                                      |
| Checkbox          | String | A string must contain "true" (checked) OR "false" (unchecked)                                                                                                                                  |
| Number            | String | Number type should be a Number without other character                                                                                                                                         |
| File              | File   | Not supported yet                                                                                                                                                                              |

### Address

```json
   "address": {
    "label": "58 Rue de Paradis",
    "zip": "75009",
    "city": "Paris",
    "country": "France"
  },
```

| Parameter | Type   | Description          |
| --------- | ------ | -------------------- |
| label     | String | Label of the address |
| city      | String | Name of the city     |
| country   | String | Name of the country  |
| zip       | String | Post code            |

### Contact

```json
"contact": {
  "firstname": "firstname",
  "lastname": "lastname",
  "gender": "Ms",
  "email": "email@email.email",
  "phone": "0606060606",
  "birthdate": "2023-01-01",
},

```

| Parameter | Type   | Description                                                                                          |
| --------- | ------ | ---------------------------------------------------------------------------------------------------- |
| email     | String | Email will be used to identify which client will be updated or create a new client if no email found |
| firstname | String | Firstname of the client as a string                                                                  |
| lastname  | String | Lastname of the client as a string                                                                   |
| gender    | String | 3 Options : `Mr`, `Ms` or `Undefined`                                                                |
| phone     | String | Phone of the client as a string                                                                      |
| birthdate | String | Birthdate of the client formated like: YYYY-MM-DD if not formated correctly = NULL                   |

### Rates

```json
  "rates": [
    {
      "id": "fbb69d5a-bebb-45bd-a8ad-d6a18ac36109",
      "reference": null,
      "type": "default",
      "name": "",
      "purchase_price_pretax": 100.0,
      "margin_rate": 50.0,
      "sale_price_pretax": 200.0,
      "prestation_id": "48b25fd1-bb7b-4c49-a774-214ffa22fbb6",
      "tariff_id": null,
      "child": []
    }
  ],
```

| Parameter             | Type   | Description                                                                                                          |
| --------------------- | ------ | -------------------------------------------------------------------------------------------------------------------- |
| id                    | String | id of the rates                                                                                                      |
| reference             | String | reference refer to the rates reference                                                                               |
| type                  | String | `type` can be `default` OR `season` If it's season, it means this rates is based on some seasons so on special dates |
| name                  | String | Name of the prestation                                                                                               |
| purchase_price_pretax | Number | Purchase price before taxes of the prestation                                                                        |
| margin_rate           | Number | The margin Rates is calculated depend to the sales price                                                             |
| sale_price_pretax     | Number | Sales price before taxes as a Number                                                                                 |
| prestation_id         | String | id of the prestations who have this rates                                                                            |
| tariff_id             | String | If reference to a special tarif, reference to the parent tarif Id                                                    |
| child                 | Array  | Childs are tariffs contains in the rates tariff                                                                      |

### Langs

```json
"langs": [
  {
    "lang": "american",
    "name": "American Name",
    "short_description": "Short American Description",
    "long_description": "Short American Description"
  }
],
```

| Parameter         | Type   | Description                                      |
| ----------------- | ------ | ------------------------------------------------ |
| lang              | String | Language name in lower case                      |
| name              | String | language name                                    |
| short_description | String | Short description of the object in this language |
| long_description  | String | Long description of the object in ths language   |

<aside class="success">
Remember — You have to be authenticated to call this API with your bearer token
</aside>
