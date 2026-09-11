# Nested Resources

## Address

```json
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
```

| Property | Type   | Description                                                                                                                                                                                    |
| -------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| label    | String | Label of the address                                                                                                                                                                           |
| city     | String | Name of the city                                                                                                                                                                               |
| country  | String | Name of the country                                                                                                                                                                            |
| zip      | String | Post code                                                                                                                                                                                      |
| geo      | JSON   | Represents the geographical coordinates of the address or `null` if not geolocated. If provided, it consists of `x` (latitude) and `y` (longitude), both returning a `Number` with 6 decimals. |

## Alternatives

```json
"alternatives": [
  {
    "reference": "550e8400-e29b-41d4-a716-446655440000",
    "alternative_title": "Main Alternative",
    "lang": "fr-FR",
    "is_main": true,
    "trip_date_in": "2024-03-01",
    "trip_date_out": "2024-03-09",
    "trip_duration": 9,
    "trip_people": "15",
    "trip_destination_reference": "destination_reference",
    "trip_destination": "France",
    "trip_subdestination_reference ": "subdestination_reference",
    "trip_subdestination": "Paris",
    "trip_budget": 90000,
    "budget_actual": 88750,
    "budget_actual_excl_taxes ": 77950,
    "budget_margin_gross": 2500,
    "budget_margin_net": 1000,
    "budget_purchases": 74500,
    "financial_invoiced": 48000,
    "financial_collected": 48000,
    "financial_purchases": 72820,
    "financial_spendings": 12820,
    "destinations": {
      "size": 3,
      "data": [
        {
          "reference": "destination_reference",
          "name": "France",
          "subdestination_reference": "subdestination_reference",
          "subdestination_name": "Paris"
        },
        {
          "reference": "destination_reference",
          "name": "France",
          "subdestination_reference": "subdestination_reference1-2",
          "subdestination_name": "Lyon"
        },
        {
          "reference": "destination_reference2",
          "name": "Italy",
          "subdestination_reference": "subdestination_reference2-1",
          "subdestination_name": "Milan"
        }
      ]
    },
    "client": {
      "reference": "client_reference",
      "type": "enterprise",
      "company_name": "MOKE INTERNATIONAL LIMITED",
      "first_name": "Jane",
      "last_name": "Doe",
      "email": "contact@moke-international.com"
    },
    "client_space": {
      "is_live": true,
      "url": "https://custom-domain.com/your-space-slug",
      "description": "Description of the client space",
      "image_url": "https://image.jpg"
    },
    "brand": {
      "title": "INTERNATIONAL LIMITED",
      "company_name": "MOKE INTERNATIONAL LIMITED",
      "address": {
        "label": "58 Rue de Paradis",
        "city": "Paris",
        "country": "France",
        "zip": "75010"
      },
      "email": "travel-design@e-corp.com",
      "phone": "0101010101",
      "website": "www.moke_ltd.com",
      "vat_number": "GB 240-635-038",
      "company_number": "09728676"
    }
  }
]
```

| Property                      | Type    | Description                                                                                                                                                                                                |
|-------------------------------|---------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| reference                     | String  | Unique reference of this alternative: (distinct from the root project `reference` at the top level of the GET `project` response).                                                                         |
| alternative_title             | String  | Title of the alternative                                                                                                                                                                                   |
| lang                          | String  | Alternative locale code (e.g. fr-FR, en-GB)                                                                                                                                                                |
| is_main                       | Boolean | If the alternative is the main alternative                                                                                                                                                                 |
| trip_date_in                  | Date    | Date of the beginning of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates                                                                                        |
| trip_date_out                 | Date    | Date of the end of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates                                                                                              |
| trip_duration                 | Number  | Number of days this alternative lasts                                                                                                                                                                      |
| trip_people                   | String  | Number of people                                                                                                                                                                                           |
| trip_destination_reference    | String  | Destination reference of the alternative. Note: For multi-destination alternatives, only the primary destination is returned.                                                                              |
| trip_destination              | String  | Destination of the alternative. Note: For multi-destination alternatives, only the primary destination is returned.                                                                                        |
| trip_subdestination_reference | String  | Subdestination reference of the alternative. Note: For multi-destination alternatives, only the primary subdestination is returned.                                                                        |
| trip_subdestination           | String  | Subdestination of the alternative. Note: For multi-destination alternatives, only the primary subdestination is returned.                                                                                  |
| trip_budget                   | Number  | Forecasted budget for the alternative (the one that is entered manually not the actual one)                                                                                                                |
| budget_actual                 | Number  | Actual budget for the alternative, inclusive of taxes                                                                                                                                                      |
| budget_actual_excl_taxes      | Number  | Actual budget for the alternative, excluding taxes                                                                                                                                                         |
| budget_margin_gross           | Number  | Gross margin for the alternative                                                                                                                                                                           |
| budget_margin_net             | Number  | Net margin for the alternative                                                                                                                                                                             |
| budget_purchases              | Number  | Planned supplier purchases amount for the alternative (in project currency). This is a forecasted value, not actual spending                                                                               |
| financial_invoiced            | Number  | Total amount invoiced to clients for the alternative (in project currency). Draft invoices are not included in this calculation                                                                            |
| financial_collected           | Number  | Total amount collected from clients for the alternative (in project currency). Represents actual payments received                                                                                         |
| financial_purchases           | Number  | Actual supplier purchase costs for the alternative (in project currency). Corresponds to recorded supplier invoices                                                                                        |
| financial_spendings           | Number  | Actual spendings recorded for the alternative (in project currency). Includes all types of supplier payments (purchases, fees, etc.)                                                                       |
| destinations                  | JSON    | JSON including: `size`, Array of all destination (`reference` and `name`) and subdestination (`subdestination_reference` and `subdestination_name`) values                                                 |
| client                        | JSON    | JSON including: `reference`, `type` (enterprise or individual), `company_name`, `first_name`, `last_name` and `email`                                                                                      |
| client_space                  | JSON    | JSON including: `is_live` (Boolean), `url` (empty string when not live; uses slug when available, otherwise `?id=`; custom domain when configured, fallback to `docs.ezus.io`), `description`, `image_url` |
| brand                         | JSON    | JSON object representing the brand ([Brand](#nested-resources-brand)) associated with the alternative                                                                                                      |

## Brand

If no brand is associated with an alternative, the default values are taken from the user’s company settings.

```json
"brand": {
  "title": "INTERNATIONAL LIMITED",
  "company_name": "MOKE INTERNATIONAL LIMITED",
  "address": {
    "label": "58 Rue de Paradis",
    "city": "Paris",
    "country": "France",
    "zip": "75010"
  },
  "email": "travel-design@e-corp.com",
  "phone": "0101010101",
  "website": "www.moke_ltd.com",
  "vat_number": "GB 240-635-038",
  "company_number": "09728676"
}
```

| Property       | Type   | Description                                                                              |
|----------------|--------|------------------------------------------------------------------------------------------|
| title          | String | Title of the brand                                                                       |
| company_name   | String | Name of the brand company                                                                |
| address        | JSON   | JSON object representing the address ([Address](#nested-resources-address)) of the brand |
| email          | String | Email of the brand                                                                       |
| phone          | String | Phone of the brand                                                                       |
| website        | String | Website link of the brand                                                                |
| vat_number     | String | VAT number of the brand                                                                  |
| company_number | String | Company registration number of the brand                                                 |

## Contacts

Only the last 10 contacts are returned in this object. Note that for upsert endpoints, only one contact is required (equivalent to a single JSON element in the contacts.data Array below).

```json
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
}
```

| Property   | Type    | Description                                                                                       |
| ---------- | ------- | ------------------------------------------------------------------------------------------------- |
| reference  | String  | Reference of the contact                                                                          |
| email      | String  | Email of the contact                                                                              |
| first_name | String  | First name of the contact as a string                                                             |
| last_name  | String  | Last name of the contact as a string                                                              |
| title      | String  | Title of the contact as a string                                                                  |
| gender     | String  | `Mr`, `Ms` or `Undefined`                                                                         |
| phone      | String  | Phone number of the contact as a string                                                           |
| phone2     | String  | Second phone number of the contact as a string                                                    |
| birth_date | String  | Contact's date of birth in a "YYYY-MM-DD" format string (supplier contacts have no date of birth) |
| is_main    | Boolean | True if this contact is the primary contact for the parent resource                               |

## Custom Fields

```json
"custom_fields": [
  {
    "name": "Text",
    "value": "Value"
  },
  {
    "name": "Number",
    "value": "42"
  },
  {
    "name": "Text area",
    "value": "Value of the text Area"
  },
  {
    "name": "Date",
    "value": "2012-12-21"
  },
  {
    "name": "Time",
    "value": "2006-10-07T12:06:56.568+01:00"
  },
  {
    "name": "URL link",
    "value": "https://urllink.com"
  },
  {
    "name": "File",
    "value": "https://urllink.com/files/document.pdf"
  },
  {
    "name": "Checkbox",
    "value": "true"
  },
  {
    "name": "Dropdown",
    "value": "ExactOption"
  },
  {
    "name": "MultipleDropdown",
    "value": "ExactOption1/-/ExactOption2"
  }
]
```

<aside class="warning">
The name of custom fields refers to their technical name, not their display name.
</aside>
The technical name of a custom field can be found in the custom field edit modal

| Options           | Type   | Description                                                                                                                                                                                    |
| ----------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Text              | String | Simple string like Text Area                                                                                                                                                                   |
| Dropdown          | String | The option must be written exactly as in the parameters, respecting the case                                                                                                                   |
| Multiple Dropdown | String | The option must be written exactly as in the parameters, respecting the case, for Multiple Answer you should enter Option1/-/Option2/-/Option3 in a string, "/-/" should separate each options |
| Date              | String | The date must be in a "YYYY-MM-DD" format string                                                                                                                                               |
| Time              | String | The time must be in a "YYYY-MM-DDTHH:MM:SS+01:00" format string                                                                                                                                |
| Checkbox          | String | The checkbox must be a string: "true" (checked) OR "false" (unchecked)                                                                                                                         |
| Number            | String | Number type should be a Number without other character                                                                                                                                         |
| File              | String | File must be a valid URL, and supported file extensions include: .pdf, .jpg, .jpeg, .png, .bmp, .gif, .docx, .doc, .msg, .odt, .rtf, .txt, .ppt, .pptx, .pptm, .csv, .xlsx                     |

## Category

```json
"category": {
    "reference": "category_reference",
    "name": "Accommodation / Lodging",
    "subcategory_reference": "subcategory_reference",
    "subcategory_name": "Hotel Room"
}
```

| Property              | Type   | Description                       |
| --------------------- | ------ | --------------------------------- |
| reference             | String | The reference of the category     |
| name                  | String | Name of the category              |
| subcategory_reference | String | The reference of the sub-category |
| subcategory_name      | String | Name of the sub-category          |

## Categories

```json
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
```

Each object represents a category with its associated sub-categories

| Property      | Type   | Description                                                                                  |
| ------------- | ------ | -------------------------------------------------------------------------------------------- |
| reference     | String | The reference of the category                                                                |
| name          | String | Name of the category                                                                         |
| subcategories | Array  | An array of JSON objects, each representing a sub-category along with its name and reference |

## Destination

```json
"destination": {
  "reference": "destination_reference",
  "name": "France",
  "subdestination_reference": "subdestination_reference",
  "subdestination_name": "Paris"
}
```

| Property                 | Type   | Description                          |
| ------------------------ | ------ | ------------------------------------ |
| reference                | String | The reference of the destination     |
| name                     | String | Name of the destination              |
| subdestination_reference | String | The reference of the sub-destination |
| subdestination_name      | String | Name of the sub-destination          |

## Destinations

```json
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
  },
]
```

Each object represents a destination with its associated sub-destinations

| Property        | Type   | Description                                                                                     |
| --------------- | ------ | ----------------------------------------------------------------------------------------------- |
| reference       | String | The reference of the destination                                                                |
| name            | String | Name of the destination                                                                         |
| subdestinations | Array  | An array of JSON objects, each representing a sub-destination along with its name and reference |

## Invoices Amounts

```json
"forecast": {
  "is_automatic": true,
  "purchase": 0.0,
  "commission": 0.0,
  "vat_deducted": 0.0,
  "amount_ht": 1000.0
}
"actual": {
  "is_automatic": true,
  "purchase": null,
  "commission": null,
  "vat_deducted": null,
  "amount_ht": null
}
```

These objects provides insights into the invoice amounts, differentiating between actual figures and forecasts. Actual figures are available when the associated project is closed and the invoice is marked as `completed` or `paid`. Otherwise, `null` values are displayed.

| Property     | Type    | Description                                                                              |
| ------------ | ------- | ---------------------------------------------------------------------------------------- |
| is_automatic | Boolean | Automatically use the figures of the project to which this invoice/credit_note is linked |
| purchase     | Number  | Forecasted / Actual purchase                                                             |
| commission   | Number  | Forecasted / Actual commission                                                           |
| vat_deducted | Number  | Forecasted / Actual deductible VAT                                                       |
| amount_ht    | Number  | Forecasted / Actual amount excluding taxes                                               |

## Invoices Lines

```json
"lines": [
  {
    "title": "Private Suite at Hôtel Ritz Paris",
    "quantity": 1,
    "price": 1200,
    "price_excl_taxes": 1000,
    "description": "Luxury private suite accommodation at Hôtel Ritz Paris including premium amenities and concierge services.",
    "tax_rate": 20,
    "tax_regime": {
      "name": "classic",
      "category": "S",
      "comment": ""
    }
  }
]
```

These objects represent the individual invoice lines associated with the invoice or credit note.

| Property            | Type   | Description                                                                                                                                                                     |
| ------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| title               | String | Title or short label of the invoiced service or product. When present, the fee line is returned with the title "Main fee" and the discount line with the title "Main discount". |
| quantity            | Number | Quantity billed for this invoice line                                                                                                                                           |
| price               | Number | Total amount including taxes                                                                                                                                                    |
| price_excl_taxes    | Number | Total amount excluding taxes                                                                                                                                                    |
| description         | String | Detailed description of the invoiced service or product                                                                                                                         |
| tax_rate            | Number | Tax rate applied to the line item, expressed as a percentage.                                                                                                                   |
| tax_regime.name     | String | Tax profile applied to the invoice line. Possible values: `none`, `margin`, `classic`                                                                                           |
| tax_regime.category | String | Tax category code associated with the invoice line                                                                                                                              |
| tax_regime.comment  | String | Additional tax-related information or comment                                                                                                                                   |

## Items

```json
"items": [
  {
    "reference": "item_reference",
    "name": "item_title",
    "product_reference": "product_reference",
    "supplier_reference": "supplier_reference",
    "quantity": 2,
    "purchase_price": 150,
    "purchase_price_excl_taxes": 125,
    "sales_price": 200,
    "sales_price_excl_taxes": 166.67,
    "is_optional": false,
    "notes": "Notes about the item",
    "booked": false
  }
]
```

The items array represents a collection of items associated with a step.
The fields `purchase_price`, `purchase_price_excl_taxes`, `sales_price`, and `sales_price_excl_taxes` **represent the price per unit of the item**. To calculate the total cost or total sales value for an item, multiply the unit price by the quantity.

**All prices returned by this endpoint are expressed in the project’s currency**. If the items are in different currencies, conversion must be performed using the exchange rates available in the project’s currency library.

| Property                  | Type    | Description                                                                                                             |
| ------------------------- | ------- | ----------------------------------------------------------------------------------------------------------------------- |
| reference                 | String  | The reference of the item                                                                                               |
| name                      | String  | Name of the item                                                                                                        |
| product_reference         | String  | The product reference associated with the item                                                                          |
| supplier_reference        | String  | The supplier reference associated with the item                                                                         |
| quantity                  | Number  | Quantity of the item                                                                                                    |
| purchase_price            | Number  | The unit purchase price of the item (including taxes)                                                                   |
| purchase_price_excl_taxes | Number  | The unit purchase price of the item (excluding taxes)                                                                   |
| sales_price               | Number  | The unit sales price of the item (including taxes)                                                                      |
| sales_price_excl_taxes    | Number  | The unit sales price of the item (excluding taxes)                                                                      |
| is_optional               | Boolean | Indicates whether the item is optional. **If true, the item does not contribute to the final purchase or sales price.** |
| notes                     | String  | Notes about the item                                                                                                    |
| booked                    | Boolean | Indicates whether the item has been booked / reserved.                                                                  |

## Langs

```json
"langs": [
  {
    "lang": "american",
    "name": "My American product version",
    "short_description": "Short American Description",
    "long_description": "Long American Description"
  }
]
```

| Property          | Type   | Description                                                                                                                                       |
| ----------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| lang              | String | Language name in lower case. Possible lang property values are: french, english, american, spanish, italian, portuguese, german, dutch, norwegian |
| name              | String | Title of the object in this language                                                                                                              |
| short_description | String | Short description of the object in this language                                                                                                  |
| long_description  | String | Long description of the object in this language                                                                                                   |

## Medias

Only the last 10 medias are returned in this object.

```json
"medias": {
  "data": [
    {
      "media_name": "img.jpeg",
      "path_full": "https://link-img.jpeg"
    }
  ],
  "size": 1
}
```

| Property   | Type   | Description                                                       |
| ---------- | ------ | ----------------------------------------------------------------- |
| media_name | String | Title of the media                                                |
| path_full  | String | Media URL. This is a pre-signed URL that expires after 30 minutes |

## Products <a name="products-two"></a>

Only the last 10 products are returned in this object.

```json
"products": {
  "data": [
    {
      "reference": "product_reference",
      "title": "2-bed room with breakfast"
    }
  ],
  "size": 1
}
```

| Property  | Type   | Description                  |
| --------- | ------ | ---------------------------- |
| reference | String | The reference of the product |
| title     | String | The title of the product     |

## Steps

The steps are sorted by their creation date, with the most recently created appearing first.

```json
"steps": [
  {
    "reference": "activity_reference",
    "type": "activity",
    "name": "activityTitle",
    "category": "restaurant",
    "date_start": "2024-10-01 10:00:00",
    "date_end": "2024-10-01 12:00:00",
    "people": 4,
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
    "description": {
      "short": "Short description of the activity",
      "long": "Long description of the activity"
    },
    "items": [
      {
        "reference": "item_reference",
        "name": "item_title",
        "product_reference": "product_reference",
        "supplier_reference": "supplier_reference",
        "quantity": 2,
        "purchase_price": 150,
        "purchase_price_excl_taxes": 125,
        "sales_price": 200,
        "sales_price_excl_taxes": 166.67,
        "is_optional": false,
        "notes": "Notes about the item",
        "booked": false
      }
    ],
    "medias": ["https://image.jpg", "https://image2.jpg"],
    "custom_fields": [
      {
        "name": "CustomField",
        "value": "Value"
      }
    ]
  }
]
```

| Property      | Type   | Description                                                                                                                                                                                    |
|---------------|--------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| reference     | String | The reference of the activity                                                                                                                                                                  |
| type          | String | Type of the step `activity` `accommodation` `transport` or `extra`                                                                                                                             |
| name          | String | Name of the step                                                                                                                                                                               |
| category      | String | Category of the step                                                                                                                                                                           |
| date_start    | String | Date of the beginning of this step, in a "YYYY-MM-DD HH:MM:SS" format string. If it's empty, the step has no dates.                                                                            |
| date_end      | String | Date of the end of this step, in a "YYYY-MM-DD HH:MM:SS" format string. If it's empty, the step has no dates or no end.                                                                        |
| people        | Number | Number of people                                                                                                                                                                               |
| address       | JSON   | JSON object representing the address ([Address](#nested-resources-address)) of the step, including longitude and latitude. Note: Longitude and latitude are only returned by this step object. |
| description   | JSON   | JSON object representing the short and long description of the step                                                                                                                            |
| items         | Array  | Array of JSON items ([Items](#nested-resources-items))                                                                                                                                         |
| medias        | Array  | Array of strings representing the images URLs associated with the step                                                                                                                         |
| custom_fields | Array  | Array of JSON custom fields ([Custom fields](#nested-resources-custom-fields))                                                                                                                 |

## Supplements

The supplements of the project. Today only the main fee and main discount are returned by the API.

```json
"supplements": {
  "fees": [
    {
      "reference": "fee_reference",
      "label": "Main fee",
      "mode": "flat",
      "value": 2000,
      "amount": 2000,
      "amount_excl_taxes": 1666.67,
      "notes": "Some notes"
    }
  ],
  "discounts": [
    {
      "reference": "discount_reference",
      "label": "Main discount",
      "mode": "percentage",
      "value": 10,
      "amount": 1000,
      "amount_excl_taxes": 833.33,
      "notes": "Some notes"
    }
  ]
}
```

| Property          | Type   | Description                                                                                                                                                                                           |
| ----------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference         | String | The reference of the fee/discount. For the main one it is with this format: `alternative_reference-main_fee/main_discount`                                                                            |
| label             | String | The label of the fee/discount. For the main one it is with this format: `Main fee/Main discount`. If the project is in `global` calculation mode: the label will be `Global margin` for the main fee. |
| mode              | String | The mode of the fee/discount. It can be `flat` or `percentage`. If the project is in `global` calculation mode: the mode will be `flat` for the main fee.                                             |
| value             | Number | The value of the fee/discount. If the mode is `flat`, it represents a fixed amount. If the mode is `percentage`, it represents a percentage applied to the project sales price.                       |
| amount            | Number | The amount of the fee/discount. If the mode is `flat`, it is equal to the value. If the mode is `percentage`, it is calculated as `value`% of the project sales price.                                |
| amount_excl_taxes | Number | The amount of the fee/discount excluding taxes.                                                                                                                                                       |
| notes             | String | Additional notes or comments about the fee/discount.                                                                                                                                                  |

## Tags

```json
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
```

| Property  | Type   | Description                                                           |
| --------- | ------ | --------------------------------------------------------------------- |
| reference | String | The tag reference matches the technical name of the tag               |
| type      | String | Tag type. Possible values: `product`, `supplier`, `client`, `package` |
| name      | String | Display name of the tag                                               |

## Travellers

```json
"travellers": [
  {
    "email": "emily.johnson@example.com",
    "first_name": "Emily",
    "last_name": "Johnson",
    "phone": "+1-555-123-4567",
    "custom_field1": "value1.1",
    "custom_field2": "value2.1"
  },
  {
    "email": "michael.smith@example.com",
    "first_name": "Michael",
    "last_name": "Smith",
    "phone": "+1-555-987-6543",
    "custom_field1": "value1.2",
    "custom_field2": "value2.2"
  }
]
```

| Property      | Type   | Description                                                                     |
| ------------- | ------ | ------------------------------------------------------------------------------- |
| email         | String | The email of the traveller                                                      |
| first_name    | String | The first name of the traveller                                                 |
| last_name     | String | The last name of the traveller                                                  |
| phone         | String | The phone number of the traveller                                               |
| custom_fields | String | The custom fields and the assigned values. Varies with number of custom fields. |

## Suppliers

Only the last 10 suppliers are returned in this object.

```json
"suppliers": {
  "data": [
    {
      "reference": "supplier_reference",
      "company_name": "The best hotel"
    }
  ],
  "size": 1
}
```

| Property     | Type   | Description                      |
| ------------ | ------ | -------------------------------- |
| reference    | String | The reference of the supplier    |
| company_name | String | The company name of the supplier |

## Tariffs

```json
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
        "reference": "tariff_reference",
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
        "reference": "tariff_reference",
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
    "name": "tariff season",
    "purchase_price": "100",
    "margin_rate": "16.66",
    "sales_price": "120",
    "limit_start": "2026-05-01",
    "limit_end": "2026-08-31",
    "is_yearly": true,
    "children": [
      {
        "reference": "tariff_reference",
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
        "reference": "tariff_reference",
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
]
```

| Property       | Type    | Description                                                                                                                                                                                                                   |
| -------------- | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------ |
| reference      | String  | A unique reference of this tariff                                                                                                                                                                                             |
| type           | String  | A tariff can be `default`, `custom` OR `season`.                                                                                                                                                                              |
| name           | String  | Name of the tariff (only seasonal tariffs have a name)                                                                                                                                                                        |
| purchase_price | String  | Purchase price including taxes                                                                                                                                                                                                |
| margin_rate    | String  | The margin rate is based on the sales price                                                                                                                                                                                   |
| sales_price    | String  | Sales price including taxes                                                                                                                                                                                                   |
| limit_start    | String  | Indicates the starting point of a tariff rule either the start date of a seasonal tariff or the lower bound of a level for a custom tariff.                                                                                   |
| limit_end      | String  | Indicates the end point of a tariff rule either the end date of a seasonal tariff or the upper bound of a level for a custom tariff. When set to Infinity, it designates the final level of a flat-rate or open-ended tariff. |
| is_yearly      | Boolean | Indicates if the seasonal tariff recurs every year . This field is only applicable when `type` is `season`, For `default` or `custom` tariffs, this field is always `false`.                                                  | Is it recurring from one year to the next? |
| children       | Array   | Children are sub-tariffs contained by this tariff. They may be seasonal tariff or default tariff when they are flat rate tariff.                                                                                              |

## User

One of the following options: `None`, `Everyone`, `User Group` or the following JSON object corresponding to an active Ezus user of this account.

```json
"user": {
  "email": "tommy@e-corp.com",
  "first_name": "Tommy",
  "last_name": "Atkins",
  "agency": "Paris Agency"
}
```

| Property   | Type   | Description              |
| ---------- | ------ | ------------------------ |
| email      | String | Email of the user        |
| first_name | String | First name of the user   |
| last_name  | String | Last name of the user    |
| agency     | String | User's affiliated agency |

## Webhooks

```json
"webhooks": [
  {
    "reference": "webhook_reference",
    "endpoint": "webhook_endpoint",
    "events_types": "projects.created,clients.created",
    "is_active": "true",
    "last_called_at": "2023-01-01 01:01:01"
  }
]
```

| Property       | Type   | Description                                                           |
| -------------- | ------ | --------------------------------------------------------------------- |
| reference      | String | The reference of the webhook                                          |
| endpoint       | String | The endpoint URL of the webhook                                       |
| events_types   | String | The list of events for this endpoint ([Events](#events))              |
| is_active      | String | The status of the webhook `true` or `false`                           |
| last_called_at | String | The webhook last called date in a "YYYY-MM-DD hh:mm:ss" format string |
