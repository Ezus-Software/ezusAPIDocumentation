# Deposits

## POST deposits-create

It creates a client deposit in the specified project.

```shell
curl --location 'https://api.ezus.app/deposits-create' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
    "project_reference": "project_reference",
    "alternative_order": "0",
    "type": "deposit",
    "notes": "Up-front payment 2023-05-25",
    "date": "2023-05-25",
    "amount": 6855,
    "payment_method": "card"
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  project_reference: "project_reference",
  alternative_order: "0",
  type: "deposit",
  notes: "Up-front payment 2023-05-25",
  date: "2023-05-25",
  amount: 6855,
  payment_method: "card",
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/deposits-create", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Deposit successfully created"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/deposits-create`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter         | Type    | Description                                                                                                                                        |
| ----------------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| project_reference | String  | <span class="label label-red float-right">Required</span> The reference is mandatory and refers to the project to which the payment will be added. |
| alternative_order | String  | Alternative number, if not entered, the payment will be added to the project's main alternative.                                                   |
| type              | String  | Type can be `deposit`, `payment`, `final_payment`, `extra_paid`. By default the deposits will be a `deposit`                                       |
| notes             | String  | Note attributed to the payment, this note is limited to 100 characters, all additional characters will not be saved.                               |
| date              | String  | The date must be a string in "YYYY-MM-DD" format. If it is not filled in or is invalid, the payment will be assigned to the current date.          |
| amount            | Integer | <span class="label label-red float-right">Required</span> The deposit amount in cents.                                                             |
| payment_method    | String  | Technical name of the payment method, you can find it in Settings - Custom fields                                                                  |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property | Type   | Description                                  |
| -------- | ------ | -------------------------------------------- |
| action   | String | Indicates type of deposit action was created |
