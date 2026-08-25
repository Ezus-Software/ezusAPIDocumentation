# Suppliers

## GET suppliers

Returns a list of your suppliers, sorted by creation date from newest to oldest, with the most recent suppliers appearing first. The list of suppliers returned is paginated (50 per 50): to call the 50 next items in the list, call the route with the `next_token` query parameter.

```shell
curl --location 'https://api.ezus.app/suppliers' \
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

axios.get(baseUrl + "/suppliers", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "next_token": "<NEXT_TOKEN>",
  "size": 338,
  "data_size": 50,
  "page": 1,
  "suppliers": [
    {
      "reference": "supplier_reference",
      "info_number": "202306001-S",
      "type": "accom, activity",
      "company_name": "The best hotel",
      "info_notes": "Emily confirmed: this hotel really is the best in town.",
      "website": "www.the_best_hotel.com",
      "capacity": "200",
      "user": {
        "email": "travel-design@e-corp.com",
        "first_name": "Alice",
        "last_name": "Tate",
        "agency": "Paris Agency"
      },
      "destination": {
        "reference": "destination_reference",
        "name": "France",
        "subdestination_reference": "subdestination_reference",
        "subdestination_name": "Paris"
      },
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

`GET https://api.ezus.app/suppliers`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter  | Type   | Description                                                                                  |
| ---------- | ------ | -------------------------------------------------------------------------------------------- |
| next_token | String | Specify this parameter if you want to retrieve the following elements of a given list query. |

### Response

A JSON object containing the supplier information with properties like:

| Property   | Type   | Description                                                                                                                                                                                     |
| ---------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| next_token | String | A token will be returned if all suppliers have not been returned. Use it in another call to access the following suppliers                                                                      |
| size       | Number | The total number of suppliers available with these filters                                                                                                                                      |
| data_size  | Number | Number of suppliers returned on the current page                                                                                                                                                |
| page       | Number | The page number                                                                                                                                                                                 |
| suppliers  | Array  | An array of JSON objects, each representing a supplier. These objects are formatted according to a simplified version of the GET `supplier` response structure. ([GET supplier](#get-supplier)) |

## GET supplier

This API endpoint retrieves detailed information about a specific supplier in Ezus.

```shell
curl --location 'https://api.ezus.app/supplier?reference=supplier_reference' \
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

axios.get(baseUrl + "/supplier?reference=supplier_reference", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "reference": "supplier_reference",
  "info_number": "202306001-S",
  "type": "accom, activity",
  "company_name": "The best hotel",
  "info_notes": "Emily confirmed: this hotel really is the best in town.",
  "website": "www.the_best_hotel.com",
  "capacity": "200",
  "visual_url": "https://docs.google.com/presentation/d/10GoT7nVkSIScaHUQEPh-EyUms5o6D7bcgUYsJlyql94",
  "user": {
    "email": "travel-design@e-corp.com",
    "first_name": "Alice",
    "last_name": "Tate",
    "agency": "Paris Agency"
  },
  "category": {
    "reference": "category_reference",
    "name": "Accommodation / Lodging",
    "subcategory_reference": "subcategory_reference",
    "subcategory_name": "Hotel Room"
  },
  "destination": {
    "reference": "destination_reference",
    "name": "France",
    "subdestination_reference": "subdestination_reference",
    "subdestination_name": "Paris"
  },
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
  "medias": {
    "data": [
      {
        "media_name": "The lobby",
        "path_full": "www.the_best_hotel.com/media/loby.jpg"
      }
    ],
    "size": 1
  },
  "products": {
    "data": [
      {
        "reference": "product_reference",
        "title": "2-bed room with breakfast"
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
        "is_main": false
      }
    ],
    "size": 2
  },
  "langs": [
    {
      "lang": "american",
      "name": "The best hotel",
      "short_description": "The best hotel: Parisian luxury redefined.",
      "long_description": "Welcome to The best hotel, a luxurious Parisian hotel nestled in the heart of..."
    },
    {
      "lang": "spanish",
      "name": "The best hotel",
      "short_description": "Luz y lujo en París: The best hotel.",
      "long_description": "Bienvenido a The best hotel, un lujoso hotel parisino ubicado en el corazón de..."
    }
  ],
  "custom_fields": [
    {
      "name": "Stars",
      "value": "5"
    }
  ],
  "tags": [
    {
      "reference": "mice",
      "type": "supplier",
      "name": "MICE"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/supplier`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter | Type   | Description                                                                                         |
| --------- | ------ | --------------------------------------------------------------------------------------------------- |
| reference | String | <span class="label label-red float-right">Required</span> The reference of the supplier to retrieve |

### Response

A JSON object containing the supplier information with properties like:

| Property      | Type   | Description                                                                                                                                                  |
| ------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| reference     | String | The reference of the supplier                                                                                                                                |
| info_number   | String | File number that appears in the supplier record. Not to be confused with reference                                                                           |
| type          | String | 3 options: `accom`, `activity`, `transport`. A supplier can have no type, 1 type or several types. In this case, the different types are separated by commas |
| company_name  | String | Name of the company of the supplier                                                                                                                          |
| info_notes    | String | The notes about the product                                                                                                                                  |
| website       | String | Website of the supplier                                                                                                                                      |
| capacity      | String | Maximum number of people for which the supplier can be used                                                                                                  |
| visual_url    | String | URL of the Google Slides visual linked to the supplier                                                                                                       |
| user          | JSON   | JSON object user ([User](#user))                                                                                                                             |
| category      | JSON   | JSON object category ([Category](#category))                                                                                                                 |
| destination   | JSON   | JSON object destination ([Destination](#destination))                                                                                                        |
| address       | JSON   | JSON object address ([Address](#address))                                                                                                                    |
| medias        | JSON   | JSON object medias ([Medias](#medias))                                                                                                                       |
| products      | JSON   | JSON object products ([Products](#products-2))                                                                                                               |
| contacts      | Array  | Array of JSON contacts ([Contacts](#contacts))                                                                                                               |
| langs         | Array  | Array of JSON langs ([Langs](#langs))                                                                                                                        |
| custom_fields | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                |
| tags          | Array  | Array of JSON tags ([Tags](#tags-2))                                                                                                                         |

## POST suppliers-upsert

It updates a supplier record if the provided reference (or the email) does match one of the supplier references in your account, otherwise it creates a new supplier record with the provided reference (or with a random one if no reference is provided). Note that for this endpoint, the email of the supplier can also be used as a primary key for the upsert.

### Error messages

- Email ambiguity: if several suppliers in your account have a primary contact with the same email, the email cannot be used as a matching key. The request is rejected with an `AMBIGUOUS_EMAIL_REFERENCE` error and no record is updated or created. Use the supplier's unique reference instead.

```shell
curl --location 'https://api.ezus.app/suppliers-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
  "reference": "supplier_reference",
  "info_number": "202306001-S",
  "type": "accom, activity",
  "company_name": "The best hotel",
  "website": "www.the_best_hotel.com",
  "capacity": "200",
  "user": "sam@proton.me",
  "contact": {
      "email": "bob@proton.me",
      "first_name": "Bob",
      "last_name": "Morane",
      "title": "Project Manager",
      "gender": "Mr",
      "phone": "0606060606",
      "phone2": "0707070707"
  },
  "address": {
      "label": "58 Rue de Paradis",
      "city": "Paris",
      "country": "France",
      "zip": "75010"
  },
  "destination_reference": "destination_reference",
  "subdestination_reference": "subdestination_reference",
  "category_reference": "category_reference",
  "subcategory_reference": "subdestination_reference",
  "custom_fields": [
      {"name": "field_name", "value": "field_value"}
  ],
  "tags": ["tag_1", "tag_2", "tag_3"],
  "langs": [
    {
      "lang": "french",
      "name": "Mon fournisseur",
      "short_description": "Une description courte en français",
      "long_description": "Une description longue en français"
    },
    {
      "lang": "american",
      "name": "My supplier",
      "short_description": "Short American Description",
      "long_description": "Long American Description"
    }
  ]
}
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "supplier_reference",
  info_number: "202306001-S",
  type: "accom, activity",
  company_name: "The best hotel",
  website: "www.the_best_hotel.com",
  capacity: 200,
  user: "sam@proton.me",
  contact: {
    email: "bob@proton.me",
    first_name: "Bob",
    last_name: "Morane",
    title: "Project Manager",
    gender: "Mr",
    phone: "0606060606",
    phone2: "0707070707",
  },
  address: {
    label: "58 Rue de Paradis",
    city: "Paris",
    country: "France",
    zip: "75010",
  },
  destination_reference: "destination_reference",
  subdestination_reference: "subdestination_reference",
  category_reference: "category_reference",
  subcategory_reference: "subcategory_reference",
  custom_fields: [{ name: "field_name", value: "field_value" }],
  tags: ["tag_1", "tag_2", "tag_3"],
  langs: [
    {
      lang: "french",
      name: "Mon fournisseur",
      short_description: "Une description courte en français",
      long_description: "Une description longue en français",
    },
    {
      lang: "american",
      name: "My supplier",
      short_description: "Short American Description",
      long_description: "Long American Description",
    },
  ],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/suppliers-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Supplier successfully created",
  "reference": "supplier_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/suppliers-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter                | Type   | Description                                                                                                                                                                                                                                      |
| ------------------------ | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --- |
| reference                | String | If provided, the unique reference associated to the supplier you want to update or create (in case the one you provided has never been used). If no reference is provided, a supplier will be created with a random one.                         |
| info_number              | String | File number that appears in the supplier record. Not to be confused with reference                                                                                                                                                               |
| type                     | String | Either `undefined` or a combination of these 3 options: `accom`, `activity`, `transport`. You can select multiple options by separating them with comas ("accom, activity" for instance). Enter "undefined" if you want to reset this parameter. |
| company_name             | String | <span class="label label-red float-right">Required</span> Name of the supplier. This parameter is required if you create a new supplier                                                                                                          |     |
| website                  | String | Website of the supplier                                                                                                                                                                                                                          |
| capacity                 | Number | Maximum number of people for which the supplier can be used. Leave blank `''` if not relevant                                                                                                                                                    |
| user                     | Email  | Email of the Ezus user that will be set as the owner of the supplier. By default, if no owner is provided or the provided email do not match any user on this account, the owner will be assigned to everyone                                    |
| contact                  | JSON   | Contact is a single JSON and email is needed. Note that only one contact can be upsert this way (the main contact of the supplier) ([Contact](#contacts)) To reset the main contact, you can put `'0'`                                           |
| address                  | JSON   | JSON object address ([Address](#address)) To reset the address, you can put `'0'`. **Geolocation data cannot be modified during an upsert**.                                                                                                     |
| destination_reference    | String | Reference of the destination to link to the supplier. To reset the destination, you can put `'0'`.                                                                                                                                               |
| subdestination_reference | String | Reference of the sub-destination to link to the supplier. To reset the sub-destination, you can put `'0'`. If the `destination_reference` is not provided, the `subdestination_reference` will be ignored.                                       |
| category_reference       | String | Reference of the category to link to the supplier. To reset the category, you can put `'0'`.                                                                                                                                                     |
| subcategory_reference    | String | Reference of the sub-category to link to the supplier. To reset the sub-category, you can put `'0'`. If the `category_reference` is not provided, the `subcategory_reference` will be ignored.                                                   |
| custom_fields            | Array  | Array of JSON custom fields ([Custom fields](#custom-fields))                                                                                                                                                                                    |
| tags                     | Array  | Array of strings representing tag technical names. If an empty array (`[]`) is provided, all existing product tags are removed. Otherwise, the provided tags fully replace the current ones.                                                     |
| langs                    | Array  | Array of JSON langs representing the descriptions associated with this supplier. The specified language must be enabled for the given account ([Langs](#langs))                                                                                  |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                               |
| --------- | ------ | ----------------------------------------------------------------------------------------- |
| action    | String | Indicates type of supplier action was created                                             |
| reference | String | The `reference` for the supplier, which you should store for future updates or retrievals |
