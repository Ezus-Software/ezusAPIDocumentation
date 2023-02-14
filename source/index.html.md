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

We have language bindings in Shell, Ruby, Python, and JavaScript! You can view code examples in the dark area to the right, and you can switch the programming language of the examples with the tabs in the top right.

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

# Upsert Project

## Post Upsert Project

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

This endpoint upsert a Project.

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/projects-upsert`

### Body Parameters

| Parameter          | Type   | Description                                                                                                      |
| ------------------ | ------ | ---------------------------------------------------------------------------------------------------------------- |
| reference          | String | The project Reference                                                                                            |
| info_title         | String | Title of your project                                                                                            |
| trip_people        | Number | Number of people in your project                                                                                 |
| trip_budget        | Number | Budget of your project                                                                                           |
| trip_date_in       | Date   | Date of the beginning of your project                                                                            |
| trip_date_out      | Date   | Date of the end of your project                                                                                  |
| custom_field       | JSON   | If you want you can specified some custom Fiels (They have to be created in ezus and called exactly the same)    |
| sales_manager_mail | Email  | Email of the Sales Manager, if the email don't match with a sales manager, the default sales manager will be you |
| client_email       | Email  | Email of the Client, if the email don't match with a client, No clients will be assigned                         |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>

## Post Upsert Document Create

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

| Parameter | Type   | Description                  |
| --------- | ------ | ---------------------------- |
| reference | String | The project Reference        |
| title     | String | Title of your document       |
| link      | Link   | Link to the desired Document |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>

## Post Upsert Client

```javascript
const axios = require("axios");
const baseUrl = "https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1";

const body = {
  company_name: "test-ezus",
  contact: {
    firstname: "firstname",
    lastname: "lastname",
    gender: 1,
    email: "email@email.email",
    phone: "0606060606",
    birthdate: "01-01-2023",
  },
  address: {
    label: "58 Rue de Paradis",
    city: "Paris",
    country: "France",
    zip: "75009",
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
    "client": "email@email.email"
  }
]
```

This endpoint Upsert a Client. The email params is used as a Primary Key for your clients If you have multiple clients with the same email, the first client will be taken. If a client with this email already exist, `this one will be updated with the new Params Given here.`

### HTTP Request

`POST https://66af9sr048.execute-api.eu-west-1.amazonaws.com/v1/clients-upsert`

### Body Parameters

| Parameter    | Type   | Description                                                                            |
| ------------ | ------ | -------------------------------------------------------------------------------------- |
| company_name | String | Set a company name - If company name is empty, the client will be set as an Individual |
| contact      | JSON   | Contact is a JSON and email is needed                                                  |
| address      | JSON   | Address is a JSON and label is needed                                                  |

#### Contact Parameters

| Parameter | Type   | Description                                                                                          |
| --------- | ------ | ---------------------------------------------------------------------------------------------------- |
| email     | String | Email will be used to identify which client will be updated or create a new client if no email found |
| firstname | String | Firstname of the client as a string                                                                  |
| lastname  | String | Lastname of the client as a string                                                                   |
| gender    | int    | 1 = Men, 2 = Women, 0 = None                                                                         |
| phone     | String | Phone of the client as a string                                                                      |
| birthdate | String | Birthdate of the client formated like: DD-MM-YYYY                                                    |

#### Address Parameters

| Parameter | Type   | Description          |
| --------- | ------ | -------------------- |
| label     | String | Label of the address |
| city      | String | Name of the City     |
| country   | String | Name of the country  |
| zip       | String | Post Code            |

<aside class="success">
Remember — You have to be authenticated to call this API with your Baerer TOKEN
</aside>
