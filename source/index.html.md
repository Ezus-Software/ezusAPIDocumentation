---
title: API Reference

language_tabs: # must be one of https://github.com/rouge-ruby/rouge/wiki/List-of-supported-languages-and-lexers
  - javascript

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://ezus.io/'>Documentation Powered by Ezus</a>

includes:
  - errors

search: true

code_clipboard: true

meta:
  - name: description
    content: Documentation for the Ezus API
---

# Introduction

Welcome to the EZUS API! You can use our API to access Ezus API endpoints, which can get information on various users data or clients in our database.

We have language bindings in JavaScript! You can view code examples in the dark area to the right.

# Authentication

> To authorize, use this code:

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  login: "xxx",
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
    "token": "YOUR TOKEN"
  }
]
```

> Make sure to replace `YOUR TOKEN` to use our API in the next steps

EZUS uses API keys to allow access to the API. If you don't have an Ezus account, you can ask for a Demo on our [Website](https://ezus.io/).

Ezus expects for the API key to be included in all API requests to the server in a header that looks like the following:

`Authorization: ApiKey`

To get your API key, you have to ask to your Account Manager

### Headers

| Parameter | Description                           |
| --------- | ------------------------------------- |
| X-API-KEY | API Key given by your account manager |

### Body Parameters

| Parameter | Description           |
| --------- | --------------------- |
| email     | Your account email    |
| password  | Your account password |

<aside class="notice">
You must replace <code>ApiKey</code> with your personal API key.
</aside>

# Projects

## POST projects-upsert

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "test-ezus",
  info_title: "Ezus test",
  trip_people: "18",
  trip_budget: "300",
  trip_date_in: "2022-07-31",
  trip_date_out: "2022-08-02",
  custom_fields: [
    { name: "field1", value: "field1Value" },
    { name: "field2", value: "field2Value" },
  ],
  sales_manager_email: "emailofthesales@mail.com",
  client_reference: "client_reference",
  client_email: "emailoftheclient@mail.com",
};
const headers = { "X-API-KEY": "ApiKey" };

axios.post(baseUrl + "/projects-upsert", body, headers);
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

This endpoint upsert a Project. This endpoint take the reference as a Primary key, if the reference already exist, the project linked to the account will be updated, if the référence doesn't exist, a new project will be created with all the Given Params.

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/projects-upsert`

### Body Parameters

<aside class="comment">
If you do not add an Optionnal parameter, it will be empty for a creation or simply not updated for an update. If the parameter is empty (""), same behaviour
</aside>

| Parameter           | Type   | Optionnal  | Description                                                                                                                                                                                          |
| ------------------- | ------ | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference           | String | False      | The project Reference used as a primary key to check if the project already exist and UPDATE it or to create a new Project so be sure to use a unique Esus Référence for each of your project        |
| info_title          | String | True/False | Title of your project, mandatory if you create a New Project                                                                                                                                         |
| trip_people         | Number | True       | Number of people in your project                                                                                                                                                                     |
| trip_budget         | Number | True       | Budget of your project                                                                                                                                                                               |
| trip_date_in        | Date   | True       | Date of the beginning of your project formated like YYYY-MM-DD if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1day and date = today |
| trip_date_out       | Date   | True       | Date of the end of your project formated like YYYY-MM-DD if not formatted correctly, or if duration > 40 days or if trip_date_in > trip_date_out, project will be set as 1day and date = today       |
| custom_fields       | JSON   | True       | You can add Custom Fields for your client, this custom fields should be in your Ezus params and Write Exactly as they are wrote in your params Technical Name                                        |
| sales_manager_email | Email  | True       | Email of the Sales Manager, by default if no sales_manager or not found will be assignated to nobody                                                                                                 |
| client_reference    | String | True       | Esus Reference of the Client, if the reference don't match with a client, API will try with client_email if setted else, No clients will be assigned                                                 |
| client_email        | Email  | True       | Email of the Client, if the email don't match with a client, No clients will be assigned                                                                                                             |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>

## GET project

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = { "X-API-KEY": "ApiKey" };

axios.post(baseUrl + "/project?reference=reference", {}, headers);
```

> The above command returns JSON structured like this:

```json
{
  "erreur": "false",
  "reference": "esus-reference",
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
      "trip_budget": 0,
      "trip_date_in": "2022-07-31",
      "trip_date_out": "2022-08-02",
      "destination": "Destination",
      "subdestination": "Subdestination",
      "trip_duration": "2 days",
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
      "trip_budget": 300,
      "trip_date_in": "2022-07-31",
      "trip_date_out": "2022-08-02",
      "destination": "Destination",
      "subdestination": "Subdestination",
      "trip_duration": "2 days",
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

This endpoint get a Project

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/project?reference=reference`

### Returned Values

| Name              | Type   | Value                                                                  |
| ----------------- | ------ | ---------------------------------------------------------------------- |
| reference         | String | The Reference of the given project - The one you gave                  |
| info_title        | String | The Title of your project                                              |
| info_stage        | String | The Stage of your project (Confirmed, Received, Paid...)               |
| info_notes        | String | Notes on your project                                                  |
| info_reference    | String | Reference of your Project ex: "202208019-P"                            |
| traveler_designer | JSON   | Travel designer is a Json that contain email, first_name and last_name |
| project_manager   | JSON   | Project Manager is a Json that contain email, first_name and last_name |
| alternatives      | Array  | An Array of Alternatives                                               |
| custom_fields     | Array  | Array of custom Fields that contain name and value as String           |

### alternatives

| Name              | Type   | Value                                                                                                                     |
| ----------------- | ------ | ------------------------------------------------------------------------------------------------------------------------- |
| alternative_title | String | Title of the Alternative                                                                                                  |
| trip_people       | String | Number of people                                                                                                          |
| trip_budget       | Number | Budget of the Alternative                                                                                                 |
| trip_date_in      | String | Date of the begining of this alternative, formated like : YYYY-MM-DD                                                      |
| trip_date_out     | String | Date of the end of this alternative, formated like : YYYY-MM-DD                                                           |
| destination       | String | Destination of the alternative                                                                                            |
| subdestination    | String | Subdestination of the Alternative                                                                                         |
| trip_duration     | String | Number of days                                                                                                            |
| client            | JSON   | Json that contain : "reference", "type" (entreprise or individual), "company_name", "first_name", "last_name" and "email" |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>
## POST projects-documents-create

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "test-ezus",
  title: "Ezus test",
  link: "https://www.linktothedocument.pdf",
};
const headers = { "X-API-KEY": "ApiKey" };

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

This endpoint insert a document in a Project.

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/projects-documents-create`

### Body Parameters

| Parameter | Type   | Optionnal | Description                  |
| --------- | ------ | --------- | ---------------------------- |
| reference | String | False     | The project Reference        |
| title     | String | False     | Title of your document       |
| link      | Link   | False     | Link to the desired Document |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>

# Clients

## POST clients-upsert

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "client_reference",
  company_name: "test-ezus",
  contact: {
    firstname: "firstname",
    lastname: "lastname",
    gender: 1,
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
const headers = { "X-API-KEY": "ApiKey" };

axios.post(baseUrl + "/clients-upsert", body, headers);
```

> The above command returns JSON structured like this:

```json
[
  {
    "erreur": "false",
    "message": "Client created Successfully",
    "reference": "clientReference"
  }
]
```

This endpoint Upsert a Client. The reference should be unique and permit to update an existing client or Create a new Client. If reference is not given, the email params is used as a Primary Key for your clients If you have multiple clients with the same email, the first client will be taken. If a client with this email already exist. An Esus Reference will be returned you must have to save it for your next uses. `this one will be updated with the new Params Given here.`

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/clients-upsert`

### Body Parameters

<aside class="comment">
If you do not add an Optionnal parameter, it will be empty for a creation or simply not updated for an update. If the parameter is empty (""), same behaviour
</aside>
| Parameter    | Type   | Optionnal | Description                                                                                                     |
| ------------ | ------ | --------- | --------------------------------------------------------------------------------------------------------------- |
| reference     | String | True/False| Used as a primary Key in the Database, if no Reference, the Reference will be Generated automatically and returned|
| company_name | String | True      | Set a company name - If company name is empty, the client will be set as an Individual and the name of the client = name of the contact |                         |
| contact      | JSON   | False     | Contact is a JSON and email is needed                                                                           |
| address      | JSON   | True      | Address is a JSON and label is needed if you want to add or update the adresse of your client but not mandatory |
| custom_fields      | JSON   | True      | You can add Custom Fields for your client, this custom fields should be in your Ezus params and Write Exactly as they are wrote in your params Technical Name|

#### Contact Parameters

| Parameter | Type   | Optionnal | Description                                                                                          |
| --------- | ------ | --------- | ---------------------------------------------------------------------------------------------------- |
| email     | String | False     | Email will be used to identify which client will be updated or create a new client if no email found |
| firstname | String | False     | Firstname of the client as a string                                                                  |
| lastname  | String | True      | Lastname of the client as a string                                                                   |
| gender    | int    | True      | 1 = Men, 2 = Women, 0 = None                                                                         |
| phone     | String | True      | Phone of the client as a string                                                                      |
| birthdate | String | True      | Birthdate of the client formated like: YYYY-MM-DD if not formated correctly = NULL                   |

#### Address Parameters

| Parameter | Type   | Optionnal | Description          |
| --------- | ------ | --------- | -------------------- |
| label     | String | False     | Label of the address |
| city      | String | True      | Name of the City     |
| country   | String | True      | Name of the country  |
| zip       | String | True      | Post Code            |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>

## GET client

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = { "X-API-KEY": "ApiKey" };

axios.post(baseUrl + "/client?reference=reference", {}, headers);
```

> The above command returns JSON structured like this:

```json
{
  "erreur": "false",
  "reference": "esus-reference",
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
  "contacts": [
    {
      "first_name": "Firstname",
      "last_name": "Lastname",
      "email": "contact@email.com"
    }
  ],
  "projects": [
    {
      "reference": "reference",
      "info_title": "Project Title"
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

This endpoint get a Client

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/client?reference=reference`

### Returned Values

| Name           | Type   | Value                                                                       |
| -------------- | ------ | --------------------------------------------------------------------------- |
| reference      | String | The Reference of the given client - The one you gave                        |
| type           | String | The type of the client ["entreprise", "individual"]                         |
| company_name   | String | Name of the company of your client                                          |
| first_name     | String | First Name of the client                                                    |
| last_name      | String | Last Name of the Client                                                     |
| email          | String | Email of the Client                                                         |
| activity       | String | Activity Of the Client                                                      |
| vat_number     | String | VAT number of the Client                                                    |
| siret          | String | Siret Number of the Client                                                  |
| info_profile   | String | info_profile of the Client                                                  |
| info_origin    | String | Source of the client                                                        |
| info_notes     | String | Notes on the Client                                                         |
| info_reference | String | Reference of the Client                                                     |
| address        | JSON   | Address of the client JSON who contain "label", "zip", "city" and "country" |
| contacts       | Array  | Array of Json who contains "first_name", "last_name", "email"               |
| projects       | Array  | Array of Json who contains "reference", "info_title"                        |
| custom_fields  | Array  | Array of Json who contains "name", "value"                                  |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>

# Suppliers

## POST suppliers-upserts

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "suppliers_reference",
  company_name: "test-ezus",
  type: "accom, activity"
  contact: {q
    firstname: "firstname",
    lastname: "lastname",
    gender: 1,
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
const headers = { "X-API-KEY": "ApiKey" };

axios.post(baseUrl + "/suppliers-upsert", body, headers);
```

> The above command returns JSON structured like this:

```json
[
  {
    "erreur": "false",
    "message": "Supplier created Successfully",
    "reference": "SupplierReference"
  }
]
```

This endpoint Upsert a Supplier. The reference should be unique and permit to update an existing supplier or Create a new supplier. If reference is not given, the email params is used as a Primary Key for your suppliers If you have multiple suppliers with the same email, the first supplier will be taken. If a supplier with this email already exist. An Esus Reference will be returned you must have to save it for your next uses. `this one will be updated with the new Params Given here.`

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/suppliers-upsert`

### Body Parameters

<aside class="comment">
If you do not add an Optionnal parameter, it will be empty for a creation or simply not updated for an update. If the parameter is empty (""), same behaviour
</aside>
| Parameter    | Type   | Optionnal | Description                                                                                                     |
| ------------ | ------ | --------- | --------------------------------------------------------------------------------------------------------------- |
| reference     | String | True/False| Used as a primary Key in the Database, if no Reference, the Reference will be Generated automatically|
| type     | String | True| 3 Option : "accom", "activity", "transport". You can select multiple options by typing "accom, activity" for exemple, the new data will erase old data.|
| company_name | String | True      | Set a company name - If company name is empty, the supplier will be set as an Individual |                         |
| contact      | JSON   | False     | Contact is a JSON and email is needed                                                                           |
| address      | JSON   | True      | Address is a JSON and label is needed if you want to add or update the adresse of your supplier but not mandatory |
| custom_fields      | JSON   | True      | You can add Custom Fields for your client, this custom fields should be in your Ezus params and Write Exactly as they are wrote in your params Technical Name|

#### Contact Parameters

| Parameter | Type   | Optionnal | Description                                                                                              |
| --------- | ------ | --------- | -------------------------------------------------------------------------------------------------------- |
| email     | String | False     | Email will be used to identify which supplier will be updated or create a new supplier if no email found |
| firstname | String | False     | Firstname of the supplier as a string                                                                    |
| lastname  | String | True      | Lastname of the supplier as a string                                                                     |
| gender    | int    | True      | 1 = Men, 2 = Women, 0 = None                                                                             |
| phone     | String | True      | Phone of the supplier as a string                                                                        |
| birthdate | String | True      | Birthdate of the supplier formated like: YYYY-MM-DD if not formatted correctly = NULL                    |

#### Address Parameters

| Parameter | Type   | Optionnal | Description          |
| --------- | ------ | --------- | -------------------- |
| label     | String | False     | Label of the address |
| city      | String | True      | Name of the City     |
| country   | String | True      | Name of the country  |
| zip       | String | True      | Post Code            |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>
## GET supplier

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = { "X-API-KEY": "ApiKey" };

axios.post(baseUrl + "/supplier?reference=reference", {}, headers);
```

> The above command returns JSON structured like this:

```json
{
  "erreur": "false",
  "reference": "esus-reference",
  "company_name": "Company Name",
  "capacity": "Capacity",
  "info_notes": "Notes on the client",
  "info_reference": "Reference of the Client",
  "visual_url": "urlofthevisual.com",
  "user": {
    "email": "user@email.com",
    "first_name": "FirstName",
    "last_name": "LastName"
  },
  "langs": [
    {
      "lang": "american",
      "name": "American Name",
      "short_description": "Short American Description",
      "long_description": "Short American Description"
    }
  ],
  "medias": [
    {
      "media_name": "name.jpeg",
      "path_full": "https://ezus-cmtyhfgfzxdnjtahdgpfmgfj.s3.amazonaws.com/media/name.jpeg"
    }
  ],
  "address": {
    "label": "58 Rue de Paradis",
    "zip": "75009",
    "city": "Paris",
    "country": "France"
  },
  "contacts": [
    {
      "first_name": "Firstname",
      "last_name": "Lastname",
      "email": "contact@email.com"
    }
  ],
  "products": [
    {
      "esus_reference": "product-reference",
      "title": "Product Title"
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

This endpoint get a Supplier

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/supplier?reference=reference`

### Returned Values

| Name           | Type   | Value                                                                                                          |
| -------------- | ------ | -------------------------------------------------------------------------------------------------------------- |
| reference      | String | The Reference of the given supplier - The one you gave                                                         |
| company_name   | String | Name of the company of your supplier                                                                           |
| capacity       | String | Capacity of the supplier                                                                                       |
| info_notes     | String | Notes on the Supplier                                                                                          |
| info_reference | String | Reference of the Supplier                                                                                      |
| visual_url     | String | Link to the Slides of the Supplier                                                                             |
| user           | JSON   | user Assigned to the Supplier JSON who contain "email", "first_name", "last_name"                              |
| langs          | JSON   | Array of Json who contains "lang", "name", "short_description" and "long_description"                          |
| medias         | JSON   | Array of Json who contains "media_name", "path_full"                                                           |
| address        | JSON   | Address of the supplier JSON who contain "label", "zip", "city" and "country"                                  |
| contacts       | Array  | Contacts Assigned to the supplier formated in an Array of Json who contains "first_name", "last_name", "email" |
| projects       | Array  | Projects assigned to the supplier formated in an Array of Json who contains "reference", "info_title"          |
| custom_fields  | Array  | Array of Json who contains "name", "value"                                                                     |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>
# Products

## POST products-upsert

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "product_reference",
  title: "product_title",
  quantity: "3",
  supplier_reference: "supplier_reference",
  package_reference: "package_reference",
  purchase_price: 42.42,
  sales_price: 84.84,
  vat_regime: "none",
  vat_rate: 20,
  commission_regime: "percent",
  commission_mode: "default",
  commission: 20,
  currency: "USD",
  custom_fields: [
    { name: "field1", value: "field1Value" },
    { name: "field2", value: "field2Value" },
  ],
};
const headers = { "X-API-KEY": "ApiKey" };

axios.post(baseUrl + "/products-upsert", body, headers);
```

> The above command returns JSON structured like this:

```json
[
  {
    "erreur": "false",
    "message": "Product created Successfully",
    "reference": "productReference"
  }
]
```

This endpoint Upsert a Product. The reference should be unique and permit to update an existing product or Create a new Product. If reference is not given, the product will be created. An Esus Reference will be returned you must have to save it for your next updates of this product. `this one will be updated with the new Params Given here.`

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/products-upsert`

### Body Parameters

<aside class="comment">
If you do not add an Optionnal parameter, it will be empty for a creation or simply not updated for an update. If the parameter is empty (""), same behaviour
</aside>

| Parameter          | Type    | Optionnal  | Description                                                                                                                                                                                                                                                                                |
| ------------------ | ------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| reference          | String  | True/False | To Update a Product, Reference is mandatory, the Reference will be used as a Primary Key, in case of creation, a unique Reference will be returned if you create a new product you can give a unique reference this one will be used as Ezus Reference                                     |
| title              | String  | True/False | If no reference or reference not found, the title is mandatory                                                                                                                                                                                                                             |
| quantity           | Number  | True       | quantity is the default number of this product at his creation                                                                                                                                                                                                                             |
| supplier_reference | String  | True       | The reference to the Supplier, if you give a reference, the product will be added in the supplier                                                                                                                                                                                          |
| package_reference  | String  | True       | The reference to the Package, if you give a reference, the product will be added in the package                                                                                                                                                                                            |
| purchase_price     | Number  | True       | Purchase price as Number                                                                                                                                                                                                                                                                   |
| sales_price        | Number  | True       | Sales price, the margin Rate will be calculated in function of this price.                                                                                                                                                                                                                 |
| vat_regime         | Options | True       | 'classic', 'margin', 'none', Thoses options permit to choose your VAT Regime, in margin mode, VAT will be calculated on your margin. Classic mode, VAT will be calculated on your selling price. In none mode, no VAT will be applied. If empty will be set at your default account values |
| vat_rate           | Number  | True       | Default Vat Rate, if empty will be set at your default account VAT rate                                                                                                                                                                                                                    |
| commission_regime  | Options | True       | 'percent' OR 'flat' in percent mode, the amount will be a % of the total price, in euro mode, the amount will be an exact amount undepently of the total price. If empty, will be set at your default account values                                                                       |
| commission_mode    | Option  | True       | 'default', 'purchase' or 'sales', sales mode mean the commission will be calculated on the selling price, purchase on the buying price if empty, the commission_mode will be set on your account default value.                                                                            |
| commission         | Number  | True       | Number represent the % Or the amount of the commission                                                                                                                                                                                                                                     |
| currency           | Symbol  | True       | The ISO 4217 code who represent the currency you use (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to Doc</a>)                                                                                      |
| custom_fields      | JSON    | True       | You can add Custom Fields for your client, this custom fields should be in your Ezus params and Write Exactly as they are wrote in your params Technical Name                                                                                                                              |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>

## GET product

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = { "X-API-KEY": "ApiKey" };

axios.post(baseUrl + "/product?reference=reference", {}, headers);
```

> The above command returns JSON structured like this:

```json
{
  "erreur": "false",
  "reference": "esus-reference",
  "title": "Product Title",
  "capacity": "Capacity",
  "quantity": "Quantity of this Product",
  "vat_regime": "margin",
  "vat_rate": 15.0,
  "commission_mode": "default",
  "commission_regime": "%",
  "commission": "0",
  "currency": "0",
  "budget_text": "Option",
  "budget_form": "Important",
  "budget_variable": "Do not Diplay",
  "visual_url": "urloftheproduct.com",
  "langs": [
    {
      "lang": "french",
      "name": "ProductName in French",
      "short_description": "french Short Description",
      "long_description": "french Long Description"
    }
  ],
  "medias": [
    {
      "media_name": "imgname.jpeg",
      "path_full": "https://ezus-cmtyhfgfzxdnjtahdgpfmgfj.s3.amazonaws.com/media/imgname.jpeg"
    }
  ],
  "supplier": {
    "reference": "190e4c0e-b298-11ed-8c48-0aaafac61d09",
    "company_name": "Company Name"
  },
  "package": {
    "reference": "e2a428dc-b293-11ed-8c48-0aaafac61d09",
    "title": "Package Name"
  },
  "rates": [
    {
      "reference": null,
      "type": "default",
      "name": "",
      "purchase_price_pretax": 0.0,
      "margin_rate": 0.0,
      "sale_price_pretax": 0.0,
      "child": [
        {
          "reference": null,
          "type": "custom",
          "name": null,
          "purchase_price_pretax": 0.0,
          "margin_rate": 0.0,
          "sale_price_pretax": 0.0
        }
      ]
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

This endpoint get a product

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/product?reference=reference`

### Returned Values

| Name              | Type   | Value                                                                                                                                                                                                                                                                                                                         |
| ----------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference         | String | The Reference of the given product - The one you gave                                                                                                                                                                                                                                                                         |
| title             | String | Name of the product                                                                                                                                                                                                                                                                                                           |
| capacity          | String | Capacity of the product                                                                                                                                                                                                                                                                                                       |
| quantity          | String | Quantity available of the product                                                                                                                                                                                                                                                                                             |
| vat_regime        | String | VAT regime of the product - 3 options: VAT on margin ("margin"), Common law ("classic") or VAT non applicable ("none")                                                                                                                                                                                                        |
| vat_rate          | String | Default % of the VAT on the product                                                                                                                                                                                                                                                                                           |
| commission_mode   | String | "default" or "purchase" Default mode is base on the buying price, Purchase mode based on the selling price                                                                                                                                                                                                                    |
| commission_regime | String | The commission regime can be "%" (Commission is a percent of the Buying/Selling price) OR "currency" (Commission is a Fix Value)                                                                                                                                                                                              |
| commission        | String | Commission as Number                                                                                                                                                                                                                                                                                                          |
| currency          | Number | Address of the product JSON who contain "label", "zip", "city" and "country"                                                                                                                                                                                                                                                  |
| budget_text       | String | "Option", "On Demand" or NULL, If it's Option/On demand, by default the product will be an Option/On demand                                                                                                                                                                                                                   |
| buget_form        | String | "Important", "Normal", "Low" represent how the product will be highlight on the budget By Default                                                                                                                                                                                                                             |
| budget_variable   | String | "Display", "Do not Display", This option tells if the product will be displayed or not in the budget                                                                                                                                                                                                                          |
| visual_url        | String | URL of the slide of this product                                                                                                                                                                                                                                                                                              |
| langs             | Array  | Array of Json who contains "lang":"language name", "name":"product name in this language", "short_description", "long_description"                                                                                                                                                                                            |
| medias            | Array  | Array of Json who contains "media_name", "path_full": Full path to the image                                                                                                                                                                                                                                                  |
| supplier          | Array  | Array of Json who contains "reference", "company_name"                                                                                                                                                                                                                                                                        |
| package           | Array  | Array of Json who contains "name", "value"                                                                                                                                                                                                                                                                                    |
| rates             | Array  | Array of Json who contains "reference", "type", "name", "purchase_price_pretax", "margin_rate", "sale_price_pretax", "child" - Childs are tariffs contains in the rates tariff, a product can have multiple tariffs and multiple seasons, a season can have multiple tariffs levels also. "type" can be "default" OR "season" |
| custom_fields     | Array  | Array of Json who contains "name", "value"                                                                                                                                                                                                                                                                                    |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>
                                                                                                                    |

# Package

## POST package_upsert

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  reference: "package_reference",
  title: "package_title",
  supplier_reference: "supplier_reference",
  capacity: "3",
  custom_fields: [
    { name: "field1", value: "field1Value" },
    { name: "field2", value: "field2Value" },
  ],
};
const headers = { "X-API-KEY": "ApiKey" };

axios.post(baseUrl + "/package-upsert", body, headers);
```

> The above command returns JSON structured like this:

```json
[
  {
    "erreur": "false",
    "message": "Package Created Successfully",
    "reference": "packageReference"
  }
]
```

This endpoint Upsert a Package. The reference should be unique and permit to update an existing package or Create a new Package. If reference is not given, the package will be created. An Esus Reference will be returned you must have to save it for your next updates of this package. `this one will be updated with the new Params Given here.`

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/products-upsert`

### Body Parameters

<aside class="comment">
If you do not add an Optionnal parameter, it will be empty for a creation or simply not updated for an update. If the parameter is empty (""), same behaviour
</aside>

| Parameter          | Type   | Optionnal  | Description                                                                                                                                                   |
| ------------------ | ------ | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
| reference          | String | True/False | To Update a Package, Reference is mandatory, the Reference will be used as a Primary Key, in case of creation, a unique Reference will be returned            |
| title              | String | True/False | If no reference or reference not found, the title is mandatory                                                                                                |
| supplier_reference | String | True       | If supplier_reference given, the package will be associated to a supplier                                                                                     |
| capacity           | Number | True       | capacity is the default number of this package at his creation                                                                                                |     |
| custom_fields      | JSON   | True       | You can add Custom Fields for your client, this custom fields should be in your Ezus params and Write Exactly as they are wrote in your params Technical Name |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>

## GET package

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const headers = { "X-API-KEY": "ApiKey" };

axios.post(baseUrl + "/package?reference=reference", {}, headers);
```

> The above command returns JSON structured like this:

```json
{
  "erreur": "false",
  "reference": "esus-reference",
  "title": "package Title",
  "capacity": "Capacity",
  "info_notes": "Notes on the Package",
  "visual_url": "urlofthepackage.com",
  "langs": [
    {
      "lang": "french",
      "name": "packageName in French",
      "short_description": "french Short Description",
      "long_description": "french Long Description"
    }
  ],
  "medias": [
    {
      "media_name": "imgname.jpeg",
      "path_full": "https://ezus-cmtyhfgfzxdnjtahdgpfmgfj.s3.amazonaws.com/media/imgname.jpeg"
    }
  ],
  "supplier": {
    "reference": "190e4c0e-b298-11ed-8c48-0aaafac61d09",
    "company_name": "Company Name"
  },
  "product": {
    "reference": "e2a428dc-b293-11ed-8c48-0aaafac61d09",
    "title": "Product Name"
  },
  "custom_fields": [
    {
      "name": "CustomField",
      "value": "Value"
    }
  ]
}
```

This endpoint get a package

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/package?reference=reference`

### Returned Values

| Name          | Type   | Value                                                                                                                              |
| ------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| reference     | String | The Reference of the given package - The one you gave                                                                              |
| title         | String | Name of the package                                                                                                                |
| capacity      | String | Capacity of the package                                                                                                            |
| info_notes    | String | Notes on the package budget                                                                                                        |
| visual_url    | String | URL of the google slide of this package                                                                                            |
| langs         | Array  | Array of Json who contains "lang":"language name", "name":"package name in this language", "short_description", "long_description" |
| medias        | Array  | Array of Json who contains "media_name", "path_full": Full path to the image                                                       |
| supplier      | Array  | Array of Json who contains "reference", "company_name"                                                                             |
| products      | Array  | Array of Json who contains "name", "value"                                                                                         |
| custom_fields | Array  | Array of Json who contains "name", "value"                                                                                         |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>

# OPTION custom_fields

```json
  "custom_fields": [
    {
      "name": "Text",
      "value": "Value"
    },
    {
      "name": "Number",
      "value": 42
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
      "name": "Dropdown",
      "value": "ExactOption"
    }
  ]
}
```

### Custom Fields

<aside class="success">
The cusotm_fields must be called with their technical_name which you can find in your custom field settings, and must respect the given formatting, if they do not respect this formatting, they will not be updated or updated with their default settings.
</aside>

<aside class="warning">
Warning: the custom_fields of the projects route must have their real name and not their technical_name in "name"
</aside>

### Options

| Options  | Type          | Value                                                                        |
| -------- | ------------- | ---------------------------------------------------------------------------- |
| Text     | String        | Simple String like Text Area                                                 |
| Dropdown | Options       | The option must be written exactly as in the parameters, respecting the case |
| Date     | String        | The date must be written exactly in YYYY-MM-DD format                        |
| Time     | String        | The time must be written exactly in the format: YYYY-MM-DDTHH:MM:SS+01:00    |
| Checkbox | String        | A String must contain "true" (checked) OR "false" (unchecked)                |
| Number   | Number        | Number type should be a Number without other character                       |
| File     | Not Supported | Actually we can't upload files with the API                                  |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>
