# Authentication

## Principles

Ezus API employs a robust authentication scheme that leverages <a href='https://swagger.io/docs/specification/authentication/api-keys/' target="_blank">API Keys</a> and <a href='https://swagger.io/docs/specification/authentication/bearer-authentication/' target="_blank">Bearer authentication</a>. To interact with the Ezus API effectively, you'll need two crucial elements:

- An Ezus API key
- User credentials for an active Ezus account

<span style="text-decoration:underline">API key</span>

Ezus uses API keys to control access to its API. To obtain your `<YOUR_API_KEY>`, kindly request it from your account manager. Every request you make to the Ezus API must include this API key as the `x-api-key` header parameter, like so:

`x-api-key: <YOUR_API_KEY>`

<span style="text-decoration:underline">Bearer Authentication</span>

Upon successfully calling the `/login` endpoint with valid credentials, you will receive a bearer token, referred to as `<YOUR_TOKEN>`. This token remains valid for a duration of 12 hours. The Ezus API requires this bearer token to be included in the Authorization header parameter of all subsequent requests.

`Authorization: Bearer <YOUR_TOKEN>`

## POST login

> To initiate authentication, your first step is to make a request to the `/login` endpoint:

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

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "token": "<YOUR_TOKEN>"
}
```

> In subsequent requests, remember to replace `<YOUR_TOKEN>` in the Authorization header parameter with the token you received during this authentication process.

### HTTP Endpoint

`POST https://api.ezus.app/login`

### Header Parameters

| Parameter | Type   | Description                                                                 |
| --------- | ------ | --------------------------------------------------------------------------- |
| x-api-key | String | <span class="label label-red float-right">Required</span> Your Ezus API key |

### Body Parameters (application/json)

| Parameter | Type   | Description                                                                     |
| --------- | ------ | ------------------------------------------------------------------------------- |
| email     | String | <span class="label label-red float-right">Required</span> Your account email    |
| password  | String | <span class="label label-red float-right">Required</span> Your account password |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message. If successful, it also returns a `token` that you must retain for future API requests.
