# Travellers

## GET travellers

Returns a list of your travellers. The list returned is paginated (50 per 50): to call the 50 next items in the list, call the route with the `next_token` query parameter.

```shell
curl --location 'https://api.ezus.app/travelllers' \
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

axios.get(baseUrl + "/travellers", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "next_token": "<NEXT_TOKEN>",
  "size": 363,
  "data_size": 50,
  "page": 1,
  "travellers": [
    {
      "esus_reference": "<TRAVELLER_REFERENCE>",
      "created_at": "2026-08-24 01:23:45",
      "updated_at": "2026-08-24 12:34:56",
      "first_name": "John",
      "last_name": "Smith",
      "email": "john.smith@travellers.example",
      "phone": "+1-555-123-4567",
      "projects": [
        {
          "project_reference": "<PROJECT_REFERENCE>",
          "alternative_reference": "<ALTERNATIVE_REFERENCE>"
        }
      ],
      "my_custom_field": "my custom value"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/travellers`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter             | Type    | Description                                                                                                                                                                                        |
| --------------------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token            | String  | Specify this parameter if you want to retrieve the following elements of a given list query                                                                                                        |

### Response

A JSON object containing the project information with properties like:

| Property   | Type   | Description                                                                                                                  |
|------------|--------|------------------------------------------------------------------------------------------------------------------------------|
| next_token | String | A token will be returned if all travellers have not been returned. Use it in another call to access the following travellers |
| size       | Number | The total number of travellers available with these filters                                                                  |
| data_size  | Number | Number of travellers returned on the current page                                                                            |
| page       | Number | The page number                                                                                                              |
| travellers | Array  | An array of JSON objects, each representing a traveller.                                                                     | 

