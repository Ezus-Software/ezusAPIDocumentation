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
      "predefined_net_margin_rate": 15,
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

| Parameter   | Type                                         | Description                                                                                                                               |
|-------------|----------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------|
| next_token  | String                                       | Specify this parameter if you want to retrieve the following elements of a given list query.                                              |
| reference   | [Dynamic filter](#filtering-dynamic-filters) | You can filter clients with a specific reference                                                                                          |
| info_number | [Dynamic filter](#filtering-dynamic-filters) | You can filter clients with a specific info_number, file number that appears in the client record. Not to be confused with reference      |
| type        | String                                       | You can filter clients by their type. Either `enterprise` or `individual`                                                                 |
| email       | [Dynamic filter](#filtering-dynamic-filters) | You can filter clients by email. This filter works for both `enterprise` clients (uses the main contact’s email) and `individual` clients |

### Response

A JSON object containing the client information with properties like:

| Property   | Type   | Description                                                                                                                                                                                     |
|------------|--------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| next_token | String | A token will be returned if all clients have not been returned. Use it in another call to access the following clients                                                                          |
| size       | Number | The total number of clients available with these filters                                                                                                                                        |
| data_size  | Number | Number of clients returned on the current page                                                                                                                                                  |
| page       | Number | The page number                                                                                                                                                                                 |
| clients    | Array  | An array of JSON objects, each representing a client. These objects are formatted according to a simplified version of the GET `client` response structure. ([GET client](#clients-get-client)) |

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
  "predefined_net_margin_rate": 15,
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

| Property                   | Type   | Description                                                                                      |
|----------------------------|--------|--------------------------------------------------------------------------------------------------|
| reference                  | String | The reference of the client                                                                      |
| info_number                | String | File number that appears in the client record. Not to be confused with reference                 |
| type                       | String | The type of the client (either "enterprise" or "individual")                                     |
| company_name               | String | Name of the client's company (if applicable)                                                     |
| info_notes                 | String | Notes on the client                                                                              |
| website                    | String | Website of the client                                                                            |
| vat_number                 | String | VAT number of the client (only for "enterprise" clients)                                         |
| company_number             | String | Company registration number of the client (only for "enterprise" clients)                        |
| predefined_net_margin_rate | Number | Predefined net margin rate in percentage (e.g., `15` for 15%). Leave blank `''` if not set       |
| user                       | JSON   | JSON object representing the user ([User](#nested-resources-user)) associated with the client    |
| email                      | String | Email of the main contact at the client's organization                                           |
| first_name                 | String | First name of the main contact at the client's organization                                      |
| last_name                  | String | Last name of the main contact at the client's organization                                       |
| address                    | JSON   | JSON object representing the address ([Address](#nested-resources-address)) of the client        |
| projects                   | JSON   | Projects linked to the client (returns the first 10 projects)                                    |
| contacts                   | Array  | An array of JSON contacts ([Contacts](#nested-resources-contacts)) associated with the client    |
| custom_fields              | Array  | An array of JSON custom fields ([Custom fields](#nested-resources-custom-fields)) for the client |

## POST clients-upsert

This API endpoint updates a client record if the provided reference or email matches an existing client in your account. If no match is found, a new client record is created with the provided reference, or a randomly generated one if no reference is supplied. The client's email can be used as the primary key for upsert operations.

### Duplicate Prevention Rules

- **Enterprise clients**: A client cannot be created or updated if another enterprise client already exists with the same **company name**.
- **Individual clients**: A client cannot be created or updated if another individual client already exists with the same **first name, last name, and email**.

### Error messages

- Enterprise client duplication → `A client with this name already exists`
- Individual client duplication → `A client with this first name, last name and email already exists`
- Email ambiguity: if several clients in your account have a primary contact with the same email, the email cannot be used as a matching key. The request is rejected with an `AMBIGUOUS_EMAIL_REFERENCE` error and no record is updated or created. Use the client's unique reference instead.

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
        "mode": "upsert_main",
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
    mode: "upsert_main",
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

| Parameter      | Type   | Description                                                                                                                                                                                                                                                                                                      |
|----------------|--------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| reference      | String | If provided, the unique reference associated with the client you want to update or create (or a random one will be generated).                                                                                                                                                                                   |
| info_number    | String | File number that appears in the client record. Not to be confused with reference                                                                                                                                                                                                                                 |
| type           | String | Optional parameter. Specifies the client type (`enterprise` or `individual`). If `enterprise`, `company_name` is required. If `individual`, provide contact.first_name or contact.last_name.                                                                                                                     |
| company_name   | String | <span class="label label-red float-right">Required</span> Name of the client's company (if applicable). If empty, the client will be considered an individual, and the name of the client will be the same as the name of the contact.                                                                           |
| website        | String | Website of the client                                                                                                                                                                                                                                                                                            |
| vat_number     | String | VAT number of the client (only for "enterprise" clients)                                                                                                                                                                                                                                                         |
| company_number | String | Company registration number of the client (only for "enterprise" clients)                                                                                                                                                                                                                                        |
| user           | Email  | Email of the Ezus user to be set as the owner of the client                                                                                                                                                                                                                                                      |
| contact        | JSON   | Main contact object ([Contacts](#nested-resources-contacts)). Optional extra parameter <code>mode</code> in this endpoint. Mode values can either be: `insert_main` (default, creates and sets a main contact even if one exists) or `upsert_main` (updates the main contact if it exists, otherwise creates it) |
| address        | JSON   | JSON object address ([Address](#nested-resources-address)) To reset the address, you can put `'0'`. **Geolocation data cannot be modified during an upsert**.                                                                                                                                                    |
| custom_fields  | Array  | Array of JSON custom fields ([Custom fields](#nested-resources-custom-fields))                                                                                                                                                                                                                                   |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                             |
| --------- | ------ | --------------------------------------------------------------------------------------- |
| action    | String | Indicates type of client action was created                                             |
| reference | String | The `reference` for the client, which you should store for future updates or retrievals |
