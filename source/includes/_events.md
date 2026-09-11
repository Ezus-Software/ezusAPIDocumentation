# Events

## Basic event information

This section provides an overview of the fundamental details related to a webhook event, including its unique identifier, type, creation timestamp, trigger source, and whether it's a duplication.

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

| Property          | Type    | Description                                                                                                                                                                    |
| ----------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| id                | String  | Unique identifier for the event                                                                                                                                                |
| object            | String  | The object of the event. The event's target object is currently limited to `event` but in the future, webhooks will become capable of being triggered by various other events. |
| type              | String  | The type of the event                                                                                                                                                          |
| field             | String  | This is only displayed if the event is an update. The name of the field that was updated.                                                                                      |
| old_value         | String  | This is only displayed if the event is an update. The previous value of the updated field.                                                                                     |
| new_value         | String  | This is only displayed if the event is an update. The updated field's new value.                                                                                               |
| created           | Number  | Time at which the object was created. Measured in seconds since the Unix epoch.                                                                                                |
| trigger_reference | String  | The trigger of the event. Indicates the source or origin from which the event was initiated.                                                                                   |
| is_duplication    | Boolean | Indicates whether the event originates from a duplication                                                                                                                      |
| data              | String  | Detailed information about the event. For more in-depth details, please refer to the sections below.                                                                           |

## projects.created

This event is triggered whenever a project is either created or duplicated.

```json
{
  "data": {
    "reference": "project_reference",
    "info_number": "202306001-P",
    "info_title": "Paris fashion week 2024",
    "trip_date_in": "2024-03-01",
    "trip_date_out": "2024-03-09",
    "trip_duration": "9",
    "trip_budget": "90000",
    "trip_people": "15"
  }
}
```

| Property      | Type   | Description                                                                                                          |
| ------------- | ------ | -------------------------------------------------------------------------------------------------------------------- |
| reference     | String | The reference of the project                                                                                         |
| info_number   | String | File number that appears in the project record. Not to be confused with reference                                    |
| info_title    | String | The title of the project                                                                                             |
| trip_date_in  | String | Date of the beginning of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates. |
| trip_date_out | String | Date of the end of this alternative, in a "YYYY-MM-DD" format string. If it's empty, the project has no dates.       |
| trip_duration | String | Number of days this project lasts                                                                                    |
| trip_budget   | String | Forecasted budget for the alternative (the one that is entered manually not the actual one)                          |
| trip_people   | String | Number of people                                                                                                     |

## projects.updated

This event is triggered whenever a project is updated. This event is triggered only by specific fields within projects, including: `info_title`, `info_stage`, `info_notes`, `info_number`, `currency`, `sales_manager`, and `projects_manager`.

```json
{
  "data": {
    "reference": "project_reference",
    "info_number": "202306001-P",
    "info_title": "Paris fashion week 2024"
  }
}
```

| Property    | Type   | Description                                                                       |
| ----------- | ------ | --------------------------------------------------------------------------------- |
| reference   | String | The reference of the project                                                      |
| info_number | String | File number that appears in the project record. Not to be confused with reference |
| info_title  | String | The title of the project                                                          |

## clients.created

This event is triggered whenever a client is created.

```json
{
  "data": {
    "reference": "client_reference",
    "info_number": "202306001-C",
    "type": "enterprise",
    "company_name": "MOKE INTERNATIONAL LIMITED",
    "email": "contact@moke-international.com",
    "first_name": "Jane",
    "last_name": "Doe",
    "gender": "Ms",
    "phone": "0101010101",
    "birth_date": "1986-09-17"
  }
}
```

| Property     | Type   | Description                                                                      |
| ------------ | ------ | -------------------------------------------------------------------------------- |
| reference    | String | The reference of the client                                                      |
| info_number  | String | File number that appears in the client record. Not to be confused with reference |
| type         | String | The type of the client can be either "enterprise" or "individual"                |
| company_name | String | Name of the company of the client                                                |
| email        | String | Email of the main contact of the client                                          |
| first_name   | String | First name of the main contact of the client                                     |
| last_name    | String | Last name of the main contact of the client                                      |
| gender       | String | `Mr`, `Ms` or `Undefined`                                                        |
| phone        | String | Phone number of the contact as a string                                          |
| birth_date   | String | Contact's date of birth in a "YYYY-MM-DD" format string                          |

## clients.updated

This event is triggered whenever a client is updated. This event is triggered only by specific fields within clients, including: `company_name`, `website`, `vat_number`, `company_number`, `info_notes`, `info_number` and `user`.

```json
{
  "data": {
    "reference": "client_reference",
    "info_number": "202306001-C",
    "company_name": "MOKE INTERNATIONAL LIMITED"
  }
}
```

| Property     | Type   | Description                                                                      |
| ------------ | ------ | -------------------------------------------------------------------------------- |
| reference    | String | The reference of the client                                                      |
| info_number  | String | File number that appears in the client record. Not to be confused with reference |
| company_name | String | Name of the client's company                                                     |

## invoices.finalized

This event is triggered whenever an invoice is finalized (its stage goes from `draft` to `completed`).

```json
{
  "data": {
    "reference": "invoice_reference",
    "info_number": "2023_101010",
    "type": "credit_note",
    "origin_reference": "origin_reference",
    "origin_info_number": "2023_101009",
    "stage": "completed",
    "created_date": "2023-10-10",
    "send_date": "2023-10-10",
    "due_date": "2023-10-10",
    "currency": "EUR",
    "amount_ttc": 1200.0,
    "amount_ht": 1000.0,
    "vat": 200.0,
    "project_reference": "project_reference",
    "url": "https://ezus.io/2023_101010.pdf",
    "alternative": {
      "sort_order": "0",
      "title": "Main Alternative"
    }
  }
}
```

| Property           | Type   | Description                                                                                                                                                                                                       |
| ------------------ | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference          | String | The reference of the invoice                                                                                                                                                                                      |
| info_number        | String | Title of the invoice                                                                                                                                                                                              |
| type               | String | Type of the invoice `invoice` or `credit_note`                                                                                                                                                                    |
| origin_reference   | String | This is only displayed if the type of the invoice is a `credit_note`. The reference of the origin invoice.                                                                                                        |
| origin_info_number | String | This is only displayed if the type of the invoice is a `credit_note`. Title of the origin invoice.                                                                                                                |
| stage              | String | Stage of the invoice `draft` `completed` or `paid`                                                                                                                                                                |
| created_date       | String | Date of the creation of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                    |
| send_date          | String | Sent date of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                               |
| due_date           | String | Due date of this invoice, in a "YYYY-MM-DD" format                                                                                                                                                                |
| currency           | String | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>) |
| amount_ttc         | Number | Amount of the invoice including taxes                                                                                                                                                                             |
| amount_ht          | Number | Amount of the invoice excluding taxes                                                                                                                                                                             |
| vat                | Number | VAT amount of the invoice                                                                                                                                                                                         |
| project_reference  | String | The reference of the project linked to this invoice                                                                                                                                                               |
| url                | String | URL of the invoice `.pdf` file                                                                                                                                                                                    |
| alternative        | JSON   | JSON including: `sort_order` and `title`                                                                                                                                                                          |

## invoices_suppliers.attached

This event is triggered whenever a file is added to a supplier invoice.

```json
{
  "data": {
    "reference": "invoice_supplier_reference",
    "has_attachement": true,
    "filename": "2023_101010.pdf",
    "url": "https://ezus.io/2023_101010.pdf",
    "created_date": "2023-10-10",
    "due_date": "2023-10-20",
    "send_date": "2023-10-15",
    "currency": "EUR",
    "amount_ttc": 1200.0,
    "amount_ht": 1000.0,
    "vat": 200.0,
    "supplier_reference": "supplier_reference",
    "project_reference": "project_reference",
    "alternative": {
      "sort_order": "0",
      "title": "Main Alternative"
    }
  }
}
```

| Property           | Type    | Description                                                                                                                                                                                                       |
| ------------------ | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference          | String  | The reference of the supplier invoice                                                                                                                                                                             |
| has_attachement    | Boolean | true if a file is attached (filename and url are both set), false otherwise                                                                                                                                       |
| filename           | String  | Filename of the supplier invoice                                                                                                                                                                                  |
| url                | String  | URL of the supplier invoice file                                                                                                                                                                                  |
| created_date       | String  | Date of the creation of this supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                           |
| due_date           | String  | Due date of this supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                                       |
| send_date          | String  | Sent date of this supplier invoice, in a "YYYY-MM-DD" format                                                                                                                                                      |
| currency           | String  | The ISO 4217 currency code representing the currency you utilize (<a href="https://docs.google.com/spreadsheets/d/1b7BNOwKyN1hMOouve6xhFZ2R2zrH4Sj1L-646j755fU/edit?usp=sharing" target="_blank">Link to doc</a>) |
| amount_ttc         | Number  | Amount of the supplier invoice including taxes                                                                                                                                                                    |
| amount_ht          | Number  | Amount of the supplier invoice excluding taxes                                                                                                                                                                    |
| vat                | Number  | VAT amount of the supplier invoice                                                                                                                                                                                |
| supplier_reference | String  | The reference of the supplier linked to this supplier invoice                                                                                                                                                     |
| project_reference  | String  | The reference of the project linked to this supplier invoice                                                                                                                                                      |
| alternative        | JSON    | JSON including: `sort_order` and `title`                                                                                                                                                                          |
