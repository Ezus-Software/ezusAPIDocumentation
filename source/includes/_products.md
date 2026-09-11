# Products

## GET products

Returns a list of your products, sorted by creation date from newest to oldest, with the most recent products appearing first. The list of products returned is paginated (50 per 50): to call the 50 next items in the list, call the route with the `next_token` query parameter.

```shell
curl --location 'https://api.ezus.app/products' \
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

axios.get(baseUrl + "/products", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "next_token": "<NEXT_TOKEN>",
  "size": 338,
  "data_size": 50,
  "page": 1,
  "products": [
    {
      "reference": "product_reference",
      "info_number": "202306001-PR",
      "title": "2-bed room with breakfast",
      "capacity": "2",
      "quantity": "1",
      "currency": "EUR",
      "vat_rate": 20.0,
      "vat_regime": "margin",
      "commission": {
        "commission_mode": "purchase",
        "commission_regime": "percent",
        "value": "10"
      },
      "supplier_reference": "supplier_reference",
      "package_reference": "package_reference",
      "destination": {
        "reference": "destination_reference",
        "name": "France",
        "subdestination_reference": "subdestination_reference",
        "subdestination_name": "Paris"
      },
      "budget_form": "Important",
      "budget_variable": "Display"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/products`

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

A JSON object containing the product information with properties like:

| Property   | Type   | Description                                                                                                                                                                                          |
|------------|--------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| next_token | String | A token will be returned if all products have not been returned. Use it in another call to access the following products                                                                             |
| size       | Number | The total number of products available with these filters                                                                                                                                            |
| data_size  | Number | Number of products returned on the current page                                                                                                                                                      |
| page       | Number | The page number                                                                                                                                                                                      |
| products   | Array  | An array of JSON objects, each representing a product. These objects are formatted according to a simplified version of the GET `product` response structure. ([GET product](#products-get-product)) |

## GET product

This API endpoint retrieves detailed information about a specific product in Ezus.

```shell
curl --location 'https://api.ezus.app/product?reference=product_reference' \
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

axios.get(baseUrl + "/product?reference=product_reference", headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "reference": "product_reference",
  "info_number": "202306001-PR",
  "title": "2-bed room with breakfast",
  "info_notes": "Product's notes",
  "capacity": "2",
  "quantity": "1",
  "currency": "EUR",
  "vat_rate": 20.0,
  "vat_regime": "margin",
  "visual_url": "https://docs.google.com/presentation/d/10GoT7nVkSIScaHUQEPh-EyUms5o6D7bcgUYsJlyql94",
  "commission": {
    "commission_mode": "purchase",
    "commission_regime": "percent",
    "value": "10"
  },
  "supplier": {
    "reference": "supplier_reference",
    "company_name": "The best hotel"
  },
  "package": {
    "reference": "package_reference",
    "title": "packages_title"
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
  "budget_form": "Important",
  "budget_text": "Option",
  "budget_variable": "Display",
  "medias": {
    "data": [
      {
        "media_name": "img.jpeg",
        "path_full": "https://link-img.jpeg"
      }
    ],
    "size": 1
  },
  "tariffs": [
    {
      "reference": "tariff_reference",
      "type": "default",
      "name": "",
      "purchase_price": "100",
      "margin_rate": "33.33",
      "sales_price": "150",
      "limit_start": "",
      "limit_end": "",
      "is_yearly": false,
      "children": [
        {
          "reference": "",
          "type": "custom",
          "name": "",
          "purchase_price": "100",
          "margin_rate": "33.33",
          "sales_price": "150",
          "limit_start": "0",
          "limit_end": "11",
          "is_yearly": false
        },
        {
          "reference": "",
          "type": "custom",
          "name": "",
          "purchase_price": "100",
          "margin_rate": "23.08",
          "sales_price": "130",
          "limit_start": "12",
          "limit_end": "Infinity",
          "is_yearly": false
        }
      ]
    },
    {
      "reference": "tariff_reference",
      "type": "season",
      "name": "",
      "purchase_price": "100.0",
      "margin_rate": "50.0",
      "sales_price": "200.0",
      "limit_start": "2026-05-01",
      "limit_end": "2026-08-31",
      "is_yearly": true,
      "children": [
        {
          "reference": "",
          "type": "custom",
          "name": "",
          "purchase_price": "100",
          "margin_rate": "9.09",
          "sales_price": "110",
          "limit_start": "0",
          "limit_end": "10",
          "is_yearly": false
        },
        {
          "reference": "",
          "type": "custom",
          "name": "",
          "purchase_price": "100",
          "margin_rate": "16.66",
          "sales_price": "120",
          "limit_start": "11",
          "limit_end": "Infinity",
          "is_yearly": false
        }
      ]
    }
  ],
  "langs": [
    {
      "lang": "french",
      "name": "Chambre à 2 lits avec petit déjeuner",
      "short_description": "",
      "long_description": ""
    }
  ],
  "custom_fields": [
    {
      "name": "View",
      "value": "Parking"
    }
  ],
  "tags": [
    {
      "reference": "mice",
      "type": "product",
      "name": "MICE"
    }
  ]
}
```

### HTTP Endpoint

`GET https://api.ezus.app/product`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Query Parameters

| Parameter | Type   | Description                                                                                        |
| --------- | ------ | -------------------------------------------------------------------------------------------------- |
| reference | String | <span class="label label-red float-right">Required</span> The reference of the product to retrieve |

### Response

A JSON object containing the product information with properties like:

| Property        | Type   | Description                                                                                                                                                                                                                              |
|-----------------|--------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------| 
| reference       | String | The reference of the product                                                                                                                                                                                                             |
| info_number     | String | File number that appears in the product record. Not to be confused with reference                                                                                                                                                        |
| title           | String | Name of the product                                                                                                                                                                                                                      |
| info_notes      | String | Notes about your product                                                                                                                                                                                                                 |
| capacity        | Number | Maximum number of people for which the product can be used                                                                                                                                                                               |
| quantity        | String | The default number for this product when it is added to a project. It can either be a Number or one of these letters (`P` = Number of people in the project, `D` = Number of days in the project, `N` = Number of nights in the project) |
| currency        | String | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>)                        |
| vat_rate        | Number | Default % of the VAT on the product                                                                                                                                                                                                      |
| vat_regime      | String | Can be either `classic` (common law VAT), `margin` (VAT on the margin), `none` (Non applicable VAT)                                                                                                                                      |
| visual_url      | String | URL of the Google Slides visual linked to the product                                                                                                                                                                                    |
| commission      | JSON   | A JSON object containing `commission_mode` ("sales" or "purchase"), `commission_regime` ("percent" or "amount"), `value`                                                                                                                 |
| supplier        | JSON   | A JSON object containing `reference`, `company_name`                                                                                                                                                                                     |
| package         | JSON   | A JSON object containing `reference`, `title`                                                                                                                                                                                            |
| category        | JSON   | JSON object category ([Category](#nested-resources-category))                                                                                                                                                                            |
| destination     | JSON   | JSON object destination ([Destination](#nested-resources-destination))                                                                                                                                                                   |
| buget_form      | String | `Important`, `Normal`, `Low` represent how the product will be highlight on the budget By Default                                                                                                                                        |
| budget_text     | String | This is an empty string `""` if the product is not marked as an option in the budget, otherwise it is the custom label of the option to which the product is associated                                                                  |
| budget_variable | String | `Display`, `Do not Display`, this option tells if the product will be displayed or not in the budget                                                                                                                                     |
| medias          | JSON   | JSON object medias ([Medias](#nested-resources-medias))                                                                                                                                                                                  |
| tariffs         | Array  | Array of JSON tariffs ([Tariffs](#nested-resources-tariffs))                                                                                                                                                                             |
| langs           | Array  | Array of JSON langs ([Langs](#nested-resources-langs))                                                                                                                                                                                   |
| custom_fields   | Array  | Array of JSON custom fields ([Custom fields](#nested-resources-custom-fields))                                                                                                                                                           |
| tags            | Array  | Array of JSON tags ([Tags](#nested-resources-tags))                                                                                                                                                                                      |

## POST products-upsert

It updates a product record if the provided reference does match one of the product references in your account, otherwise it creates a new product record with the provided reference (or with a random one if no reference is provided).

```shell
curl --location 'https://api.ezus.app/products-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "reference": "product_reference",
    "info_number": "202306001-PR",
    "title": "2-bed room with breakfast",
    "info_notes": "The notes about the product",
    "capacity": "2",
    "quantity": "1",
    "currency": "USD",
    "purchase_price": "42",
    "sales_price": "84",
    "vat_rate": 20,
    "vat_regime": "none",
    "commission": {
        "commission_mode": "purchase",
        "commission_regime": "percent",
        "value": 10
    },
    "supplier_reference": "supplier_reference",
    "package_reference": "package_reference",
    "destination_reference": "destination_reference",
    "subdestination_reference": "subdestination_reference",
    "category_reference": "category_reference",
    "subcategory_reference": "subcategory_reference",
    "custom_fields": [
        {"name": "field_name", "value": "field_value"}
    ],
    "tags": ["tag_1", "tag_2", "tag_3"],
    "langs": [
    {
      "lang": "french",
      "name": "Mon produit",
      "short_description": "Une description courte en français",
      "long_description": "Une description longue en français"
    },
    {
      "lang": "american",
      "name": "My product",
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
  reference: "product_reference",
  info_number: "202306001-PR",
  title: "2-bed room with breakfast",
  info_notes: "Product's notes",
  capacity: 2,
  quantity: "1",
  currency: "USD",
  purchase_price: "42",
  sales_price: "84",
  vat_rate: "20",
  vat_regime: "none",
  commission: {
    commission_mode: "purchase",
    commission_regime: "percent",
    value: "10",
  },
  supplier_reference: "supplier_reference",
  package_reference: "package_reference",
  destination_reference: "destination_reference",
  subdestination_reference: "subdestination_reference",
  category_reference: "category_reference",
  subcategory_reference: "subcategory_reference",
  custom_fields: [{ name: "field_name", value: "field_value" }],
  tags: ["tag_1", "tag_2", "tag_3"],
  langs: [
    {
      lang: "french",
      name: "Mon produit",
      short_description: "Une description courte en français",
      long_description: "Une description longue en français",
    },
    {
      lang: "american",
      name: "My product",
      short_description: "Short American Description",
      long_description: "Long American Description",
    },
  ],
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/products-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Product successfully created",
  "reference": "product_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/products-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter                | Type   | Description                                                                                                                                                                                                                                                             |
|--------------------------|--------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| reference                | String | If provided, the unique reference associated to the product you want to update or create (in case the one you provided has never been used). If no reference is provided, a product will be created with a random one.                                                  |
| info_number              | String | File number that appears in the product record. Not to be confused with reference                                                                                                                                                                                       |
| title                    | String | Title of your product. This parameter is required if you create a new product                                                                                                                                                                                           |
| info_notes               | String | Notes about your product. This parameter is not required if you create or update a product                                                                                                                                                                              |
| capacity                 | Number | Maximum number of people for which the product can be used. Leave blank `''` if not relevant                                                                                                                                                                            |
| quantity                 | String | The default number for this product when it is added to a project. It can either be a Number or one of these letters (`P` = Number of people in the project, `D` = Number of days in the project, `N` = Number of nights in the project)                                |
| currency                 | String | The ISO 4217 code of the currency of this product (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to Doc</a>). If empty or not provided, your default account currency will be set |
| purchase_price           | Number | Purchase price as a number                                                                                                                                                                                                                                              |
| sales_price              | Number | Sales price as a number                                                                                                                                                                                                                                                 |
| vat_rate                 | Number | Default VAT rate. If empty or not provided, your default account VAT rate will be set                                                                                                                                                                                   |
| vat_regime               | String | Can be either `classic` (common law VAT), `margin` (VAT on the margin), `none` (Non applicable VAT). If empty or not provided, your default account VAT regime will be set                                                                                              |
| commission               | JSON   | A JSON object containing `commission_mode` ("sales" or "purchase"), `commission_regime` ("percent" or "amount"), `value`                                                                                                                                                |
| supplier_reference       | String | If you give an adequate supplier reference, the product will be added in this supplier. If you want to update the supplier's product to None, you must enter 0.                                                                                                         |
| package_reference        | String | If you give an adequate package reference, the product will be added in this package. If you want to update the package's product to None, you must enter 0.                                                                                                            |
| destination_reference    | String | Reference of the destination to link to the product. To reset the destination, you can put `'0'`.                                                                                                                                                                       |
| subdestination_reference | String | Reference of the sub-destination to link to the product. To reset the sub-destination, you can put `'0'`. If the `destination_reference` is not provided, the `subdestination_reference` will be ignored.                                                               |
| category_reference       | String | Reference of the category to link to the product. To reset the category, you can put `'0'`.                                                                                                                                                                             |
| subcategory_reference    | String | Reference of the sub-category to link to the product. To reset the sub-category, you can put `'0'`. If the `category_reference` is not provided, the `subcategory_reference` will be ignored.                                                                           |
| custom_fields            | Array  | Array of JSON custom fields ([Custom fields](#nested-resources-custom-fields))                                                                                                                                                                                          |
| tags                     | Array  | Array of strings representing tag technical names. If an empty array (`[]`) is provided, all existing product tags are removed. Otherwise, the provided tags fully replace the current ones.                                                                            |
| langs                    | Array  | Array of JSON langs representing the descriptions associated with this product. The specified language must be enabled for the given account ([Langs](#nested-resources-langs))                                                                                         |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                              |
| --------- | ------ | ---------------------------------------------------------------------------------------- |
| action    | String | Indicates type of product action was created                                             |
| reference | String | The `reference` for the product, which you should store for future updates or retrievals |

## POST product-seasons-upsert

Each update or insertion must reference an existing product via `product_reference`.
If the provided reference matches an existing seasonal tariff in your account, the record is updated; otherwise, a new seasonal tariff is created using the provided reference (or a randomly generated one if none is given).

```shell
curl --location 'https://api.ezus.app/product-seasons-upsert' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data '{
    "product_reference": "product_reference",
    "reference": "season_reference",
    "name": "January 2026",
    "purchase_price": 165.25,
    "sales_price": 200,
    "limit_start": "2026-01-01",
    "limit_end": "2026-01-31",
    "is_yearly": true
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  product_reference: "product_reference",
  reference: "season_reference",
  name: "January 2026",
  purchase_price: 165.25,
  sales_price: 200,
  limit_start: "2026-01-01",
  limit_end: "2026-01-31",
  is_yearly: true,
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/product-seasons-upsert", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Season successfully created",
  "reference": "season_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/product-seasons-upsert`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter         | Type    | Description                                                                                                                                                                                                          |
| ----------------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| product_reference | String  | <span class="label label-red float-right">Required</span>Reference of the product for which you want to create or update a season.                                                                                   |
| reference         | String  | If provided, the unique reference associated to the season you want to update or create (in case the one you provided has never been used). If no reference is provided, a season will be created with a random one. |
| name              | String  | Name of the seasonal tariff (100 characters max).                                                                                                                                                                    |
| purchase_price    | Number  | Purchase price (VAT included, in the product’s currency). Prices cannot be entered excluding VAT or in another currency.                                                                                             |
| sales_price       | Number  | Sales price (VAT included, in the product’s currency). Prices cannot be entered excluding VAT or in another currency.                                                                                                |
| limit_start       | String  | Start date of the season. "YYYY-MM-DD" format string                                                                                                                                                                 |
| limit_end         | String  | End date of the season "YYYY-MM-DD" format string                                                                                                                                                                    |
| is_yearly         | Boolean | Indicates if the seasonal tariff recurs every year                                                                                                                                                                   |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                                              |
| --------- | ------ | ---------------------------------------------------------------------------------------- |
| action    | String | Indicates type of product action was created                                             |
| reference | String | The `reference` for the product, which you should store for future updates or retrievals |
