# Tags

## GET tags

Retrieves a list of your tags (`product`, `supplier`, `client`, or `package`) sorted by type. The list of tags returned is paginated (50 per 50): to call the 50 next items in the list, call the route with the next_token query parameter.

```shell
curl --location 'https://api.ezus.app/tags' \
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

axios.get(baseUrl + "/tags", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "next_token": "<NEXT_TOKEN>",
  "size": 338,
  "data_size": 50,
  "page": 1,
  "tags": [
    {
      "reference": "partner",
      "type": "client",
      "name": "Partner"
    },
    {
      "reference": "premium",
      "type": "package",
      "name": "Premium"
    },
    {
      "reference": "mice",
      "type": "product",
      "name": "MICE"
    },
    {
      "reference": "mice",
      "type": "supplier",
      "name": "MICE"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/tags`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| X-API-KEY     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter  | Type   | Description                                                                                        |
| ---------- | ------ | -------------------------------------------------------------------------------------------------- |
| next_token | String | Specify this parameter if you want to retrieve the following elements of a given list query        |
| type       | String | Specifies the tag type to retrieve. Possible values: `product`, `supplier`, `client`, or `package` |

### Response

An array of JSON that contains your tags information.

| Property   | Type   | Description                                                                                                      |
| ---------- | ------ | ---------------------------------------------------------------------------------------------------------------- |
| next_token | String | A token will be returned if all tags have not been returned. Use it in another call to access the following tags |
| size       | Number | The total number of tags available with these filters                                                            |
| data_size  | Number | Number of tags returned on the current page                                                                      |
| page       | Number | The page number                                                                                                  |
| tags       | Array  | Array of JSON tags ([Tags](#tags-2))                                                                             |
