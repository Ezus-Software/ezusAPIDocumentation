# Packages

## GET package

This API endpoint retrieves detailed information about a specific package in Ezus.

```shell
curl --location 'https://api.ezus.app/package?reference=package_reference' \
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

axios.get(baseUrl + "/package?reference=package_reference", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "reference": "package_reference",
  "info_number": "202306001-PK",
  "title": "The best package",
  "info_notes": "A classical day in Paris",
  "capacity": "2",
  "visual_url": "https://docs.google.com/presentation/d/10GoT7nVkSIScaHUQEPh-EyUms5o6D7bcgUYsJlyql94",
  "suppliers": {
    "data": [
      {
        "reference": "supplier_reference",
        "company_name": "The best hotel"
      }
    ],
    "size": 1
  },
  "medias": {
    "data": [],
    "size": 0
  },
  "products": {
    "data": [
      {
        "reference": "product_reference",
        "title": "2-bed room with breakfast"
      },
      {
        "reference": "product_reference_1235",
        "title": "A gourmet menu for 2"
      }
    ],
    "size": 2
  },
  "langs": [
    {
      "lang": "american",
      "name": "The best package",
      "short_description": "A classical day in Paris",
      "long_description": "Immerse yourself in the romance and elegance of a classical Parisian day, as our hotel and restaurant capture the essence of this magical city."
    },
    {
      "lang": "french",
      "name": "Le meilleur package",
      "short_description": "Une journée classique à Paris",
      "long_description": "Plongez dans le romantisme et l'élégance d'une journée parisienne classique, car notre hôtel et notre restaurant capturent l'essence de cette ville magique."
    }
  ],
  "custom_fields": [
    {
      "name": "Is for children?",
      "value": "False"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/package`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter | Type   | Description                                                                                        |
| --------- | ------ | -------------------------------------------------------------------------------------------------- |
| reference | String | <span class="label label-red float-right">Required</span> The reference of the package to retrieve |

### Response

A JSON object containing the package information with properties like:

| Property      | Type   | Description                                                                       |
|---------------|--------|-----------------------------------------------------------------------------------|
| reference     | String | The reference of the package                                                      |
| info_number   | String | File number that appears in the package record. Not to be confused with reference |
| title         | String | Name of the package                                                               |
| info_notes    | String | Notes on the package                                                              |
| capacity      | String | Maximum number of people for which the package can be used                        |
| visual_url    | String | URL of the Google Slides visual linked to the package                             |
| suppliers     | JSON   | JSON object suppliers ([Suppliers](#nested-resources-suppliers))                  |
| medias        | JSON   | JSON object medias ([Medias](#nested-resources-medias))                           |
| products      | JSON   | JSON object products ([Products](#nested-resources-products))                     |
| langs         | Array  | Array of JSON langs ([Langs](#nested-resources-langs))                            |
| custom_fields | Array  | Array of JSON custom fields [Custom fields](#nested-resources-custom-fields)      |

## POST packages-upsert

It updates a package record if the provided reference does match one of the package references in your account, otherwise it creates a new package record with the provided reference (or with a random one if no reference is provided).

```shell
curl --location 'https://api.ezus.app/packages-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "reference": "package_reference",
    "info_number": "202306001-PK",
    "title": "The best package",
    "capacity": "2",
    "destination_reference": "destination_reference",
    "subdestination_reference": "subdestination_reference",
    "category_reference": "category_reference",
    "subcategory_reference": "subcategory_reference",
    "custom_fields": [
        {"name": "field_name", "value": "field_value"}
    ],
    "langs": [
    {
      "lang": "french",
      "name": "Mon package",
      "short_description": "Une description courte en français",
      "long_description": "Une description longue en français"
    },
    {
      "lang": "american",
      "name": "My package",
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
  reference: "package_reference",
  info_number: "202306001-PK",
  title: "The best package",
  capacity: "2",
  destination_reference: "destination_reference",
  subdestination_reference: "subdestination_reference",
  category_reference: "category_reference",
  subcategory_reference: "subcategory_reference",
  custom_fields: [{ name: "field_name", value: "field_value" }],
  langs: [
    {
      lang: "french",
      name: "Mon package",
      short_description: "Une description courte en français",
      long_description: "Une description longue en français",
    },
    {
      lang: "american",
      name: "My package",
      short_description: "Short American Description",
      long_description: "Long American Description",
    },
  ],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/packages-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Package successfully created",
  "reference": "package_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/packages-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter                | Type   | Description                                                                                                                                                                                                            |
|--------------------------|--------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| reference                | String | If provided, the unique reference associated to the package you want to update or create (in case the one you provided has never been used). If no reference is provided, a package will be created with a random one. |
| info_number              | String | File number that appears in the package record. Not to be confused with reference                                                                                                                                      |
| title                    | String | This parameter is required if you create a new package                                                                                                                                                                 |
| capacity                 | Number | Maximum number of people for which the package can be used . Leave blank `''` if not relevant                                                                                                                          |
| destination_reference    | String | Reference of the destination to link to the package. To reset the destination, you can put `'0'`.                                                                                                                      |
| subdestination_reference | String | Reference of the sub-destination to link to the package. To reset the sub-destination, you can put `'0'`. If the `destination_reference` is not provided, the `subdestination_reference` will be ignored.              |
| category_reference       | String | Reference of the category to link to the package. To reset the category, you can put `'0'`.                                                                                                                            |
| subcategory_reference    | String | Reference of the sub-category to link to the package. To reset the sub-category, you can put `'0'`. If the `category_reference` is not provided, the `subcategory_reference` will be ignored.                          |
| custom_fields            | Array  | Array of JSON custom fields [Custom fields](#nested-resources-custom-fields)                                                                                                                                           |
| langs                    | Array  | Array of JSON langs representing the descriptions associated with this package. The specified language must be enabled for the given account ([Langs](#nested-resources-langs))                                        |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                              |
| --------- | ------ | ---------------------------------------------------------------------------------------- |
| action    | String | Indicates type of package action was created                                             |
| reference | String | The `reference` for the package, which you should store for future updates or retrievals |
