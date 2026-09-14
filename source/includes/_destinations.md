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

| Property     | Type   | Description                                                                 |
|--------------|--------|-----------------------------------------------------------------------------|
| size         | Number | The total number of destinations                                            |
| destinations | Array  | Array of JSON destinations ([Destinations](#nested-resources-destinations)) |

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
|-----------------------|--------|---------------------------------------------------------------|
| reference             | String | The reference of the sub-destination                          |
| name                  | String | Name of the sub-destination                                   |
| destination_reference | String | The reference of the destination                              |
| destination_name      | String | Name of the destination                                       |
| visual_url            | String | URL of the Google Slides visual linked to the sub-destination |
| medias                | JSON   | JSON object medias ([Medias](#nested-resources-medias))       |
| langs                 | Array  | Array of JSON langs ([Langs](#nested-resources-langs))        |

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
    "name": "Paris",
    "langs": [
    {
      "lang": "french",
      "name": "Ma sous-destination",
      "short_description": "Une description courte en français",
      "long_description": "Une description longue en français"
    },
    {
      "lang": "american",
      "name": "My sub-destination",
      "short_description": "Short American Description",
      "long_description": "Long American Description"
    }
  ]
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "subdestination_reference",
  destination_reference: "destination_reference"
  name: "Paris",
  langs: [
    {
      lang: "french",
      name: "Ma sous-destination",
      short_description: "Une description courte en français",
      long_description: "Une description longue en français",
    },
    {
      lang: "american",
      name: "My sub-destination",
      short_description: "Short American Description",
      long_description: "Long American Description",
    },
  ],
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
|-----------------------|--------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| reference             | String | If provided, the unique reference associated to the sub-destination you want to update or create (in case the one you provided has never been used). If no reference is provided, a sub-destination will be created with a random one. |
| destination_reference | String | This parameter is required and must match an existing destination.                                                                                                                                                                     |
| name                  | String | This parameter is required. Name of the sub-destination to create or update. If a sub-destination already exists with this name, it will return an error.                                                                              |
| langs                 | Array  | Array of JSON langs representing the descriptions associated with this sub-destination. The specified language must be enabled for the given account ([Langs](#nested-resources-langs))                                                |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                                      |
| --------- | ------ | ------------------------------------------------------------------------------------------------ |
| action    | String | Indicates type of sub-destination action was created                                             |
| reference | String | The `reference` for the sub-destination, which you should store for future updates or retrievals |
