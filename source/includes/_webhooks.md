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
