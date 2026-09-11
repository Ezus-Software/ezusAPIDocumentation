# Media

## POST media-create

It creates a media (image) from a given image URL and adds it to your media library. The media can optionally be attached to a `supplier`, a `product`, a `package` or a `subdestination`: it is then always added in the last position of the object's media list.

```shell
curl --location 'https://api.ezus.app/media-create' \
--header 'x-api-key: <YOUR_API_KEY>' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer <YOUR_TOKEN>' \
--data-raw '{
    "reference": "media_reference",
    "media_name": "Hotel pool",
    "path_full": "https://example.com/images/hotel-pool.jpg",
    "object_type": "supplier",
    "object_reference": "supplier_reference"
}'
```

```javascript
const axios = require("axios");
const baseUrl = "https://api.ezus.app";

const body = {
  reference: "media_reference",
  media_name: "Hotel pool",
  path_full: "https://example.com/images/hotel-pool.jpg",
  object_type: "supplier",
  object_reference: "supplier_reference",
};
const headers = {
  "x-api-key": "<YOUR_API_KEY>",
  Authorization: "Bearer <YOUR_TOKEN>",
};

axios.post(baseUrl + "/media-create", body, headers);
```

> This request returns a structured JSON object:

```json
{
  "error": "false",
  "message": "ok",
  "action": "Media successfully created",
  "reference": "media_reference"
}
```

### HTTP Endpoint

`POST https://api.ezus.app/media-create`

### Header Parameters

| Parameter     | Type   | Description                                                                 |
| ------------- | ------ | --------------------------------------------------------------------------- |
| x-api-key     | String | <span class="label label-red float-right">Required</span> Your Ezus API key |
| Authorization | String | <span class="label label-red float-right">Required</span> Your Bearer token |

### Body Parameters (application/json)

| Parameter        | Type   | Description                                                                                                                                                                                                                                   |
| ---------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| reference        | String | Unique identifier of the media, it must be less than 36 characters long and unique among your non-deleted media. If not provided, a reference is generated and returned in the response. This endpoint only works in creation mode.           |
| media_name       | String | <span class="label label-red float-right">Required</span> The name of the media, limited to 300 characters.                                                                                                                                   |
| path_full        | String | <span class="label label-red float-right">Required</span> The URL of the image to download, limited to 500 characters. Supported formats are `jpg`, `jpeg`, `png`, `gif` and `jfif`, with a maximum size of 20 MB.                            |
| object_type      | String | The type of object to link the media to. It must be one of: `supplier`, `product`, `package`, `subdestination`. It is mandatory when `object_reference` is provided. If no object is provided, the media is only added to your media library. |
| object_reference | String | The reference of the object to link the media to. It is mandatory when `object_type` is provided. The media is added in last position of the object's media.                                                                                  |

### Response

A JSON object indicating whether an error occurred during the process, along with the associated message.

| Property  | Type   | Description                                                |
| --------- | ------ | ---------------------------------------------------------- |
| action    | String | If the media has been created                              |
| reference | String | The reference of the created media (provided or generated) |
