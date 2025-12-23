# Errors

<aside class="notice">
Classic Error codes
</aside>
The Ezus API uses the following error codes:

| Error Code | Meaning                                                                                    |
| ---------- | ------------------------------------------------------------------------------------------ |
| 200        | error="true" error message explained in the "message" string                               |
| 400        | Bad Request -- Your request is invalid.                                                    |
| 403        | Forbidden -- The request was blocked by our firewall, or an API key is missing or invalid. |
| 500        | Internal Server Error -- We had a problem with our server. Try again later.                |

<aside class="notice">
Classic Error messages
</aside>
The Ezus API uses the following error messages:

| Error Message                    | Meaning                                                                                    |
| -------------------------------- | ------------------------------------------------------------------------------------------ |
| This <'OBJECT'> has been deleted | The object you try to access has been deleted                                              |
| Forbidden                        | Your request was rejected due to missing or invalid API key, or blocked by security rules. |
