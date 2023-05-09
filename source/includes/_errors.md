# Errors

<aside class="notice">
If the API Return a Success Code 200 with erreur=true, Error messages Explained Here
</aside>

| Route           | Error Message                                | Meaning                                                                        |
| --------------- | -------------------------------------------- | ------------------------------------------------------------------------------ |
| clients_upsert  | You need at least contact username and email | These two params are needed to create a Contact (firstname, email)             |
| ALL             | Your Identification Token is Incorrect       | Your Token is not Valid Anymore Please Authenticate you to the API             |
| projects_upsert | reference is mandatory                       | The Ezus Reference is mandatory, the API use it to update or create a new user |

<!--
<aside class="notice">
Classics Error codes
</aside>
The Ezus API uses the following error codes:

| Error Code | Meaning                                                                                   |
| ---------- | ----------------------------------------------------------------------------------------- |
| 400        | Bad Request -- Your request is invalid.                                                   |
| 401        | Unauthorized -- Your API key is wrong.                                                    |
| 403        | Forbidden -- The kitten requested is hidden for administrators only.                      |
| 404        | Not Found -- The specified kitten could not be found.                                     |
| 405        | Method Not Allowed -- You tried to access a kitten with an invalid method.                |
| 406        | Not Acceptable -- You requested a format that isn't json.                                 |
| 410        | Gone -- The kitten requested has been removed from our servers.                           |
| 418        | I'm a teapot.                                                                             |
| 429        | Too Many Requests -- You're requesting too many kittens! Slow down!                       |
| 500        | Internal Server Error -- We had a problem with our server. Try again later.               |
| 503        | Service Unavailable -- We're temporarily offline for maintenance. Please try again later. | -->
