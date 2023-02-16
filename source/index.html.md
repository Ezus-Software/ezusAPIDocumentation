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
  custom_fields: { custom: "I'm custom" },
  sales_manager_mail: "mailofthesales@mail.com",
  client_mail: "mailoftheclient@mail.com",
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

| Parameter          | Type   | Optionnal  | Description                                                                                                                                                                                   |
| ------------------ | ------ | ---------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference          | String | False      | The project Reference used as a primary key to check if the project already exist and UPDATE it or to create a new Project so be sure to use a unique Esus Référence for each of your project |
| info_title         | String | True/False | Title of your project, mandatory if you create a New Project                                                                                                                                  |
| trip_people        | Number | True       | Number of people in your project                                                                                                                                                              |
| trip_budget        | Number | True       | Budget of your project                                                                                                                                                                        |
| trip_date_in       | Date   | True       | Date of the beginning of your project formated like YYYY-MM-DD                                                                                                                                |
| trip_date_out      | Date   | True       | Date of the end of your project formated like YYYY-MM-DD                                                                                                                                      |
| custom_field       | JSON   | True       | If you want you can specified some custom Fiels (They have to be created in ezus and called exactly the same)                                                                                 |
| sales_manager_mail | Email  | True       | Email of the Sales Manager, if the email don't match with a sales manager, the default sales manager will be you                                                                              |
| client_email       | Email  | True       | Email of the Client, if the email don't match with a client, No clients will be assigned                                                                                                      |

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
  custom_fields: {
    field1: "value",
    field2: "value",
  },
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
| company_name | String | True      | Set a company name - If company name is empty, the client will be set as an Individual                          |
| contact      | JSON   | False     | Contact is a JSON and email is needed                                                                           |
| address      | JSON   | True      | Address is a JSON and label is needed if you want to add or update the adresse of your client but not mandatory |
| custom_fields      | JSON   | True      | You can add Custom Fields for your client, this custom fields should be in your Ezus params and Write Exactly as they are wrote in your params ex: <code>custom_fields: {"field1" : "value1", "field2" : "value2"}</code>|

#### Contact Parameters

| Parameter | Type   | Optionnal | Description                                                                                          |
| --------- | ------ | --------- | ---------------------------------------------------------------------------------------------------- |
| email     | String | False     | Email will be used to identify which client will be updated or create a new client if no email found |
| firstname | String | False     | Firstname of the client as a string                                                                  |
| lastname  | String | True      | Lastname of the client as a string                                                                   |
| gender    | int    | True      | 1 = Men, 2 = Women, 0 = None                                                                         |
| phone     | String | True      | Phone of the client as a string                                                                      |
| birthdate | String | True      | Birthdate of the client formated like: YYYY-MM-DD                                                    |

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
