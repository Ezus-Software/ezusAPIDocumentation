# Categories

## GET categories

Returns a list of all categories and sub-categories. The list is not paginated and is theoretically limited to 1000 objects (categories and sub-categories), although higher limits may work depending on the payload size. The order of the categories and sub-categories matches their order in Ezus.

```shell
curl --location 'https://api.ezus.app/categories' \
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

axios.get(baseUrl + "/categories", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "size": 1,
  "categories": [
    {
      "reference": "category_reference",
      "name": "Experiences",
      "subcategories": [
        {
          "reference": "subcategory_reference",
          "name": "Relaxation"
        }
      ]
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/categories`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Response

A JSON object containing the category information, with properties like:

| Property   | Type   | Description                                                           |
|------------|--------|-----------------------------------------------------------------------|
| size       | Number | The total number of categories                                        |
| categories | Array  | Array of JSON categories ([Categories](#nested-resources-categories)) |
