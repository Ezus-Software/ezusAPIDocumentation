# Rate Limits

### Daily rate limit

For security reasons, the API allows you to make 10,000 calls per day period.
What does this "day period" mean? It means we limit to 10,000 requests per day from the first request made. This limit is called later "daily rate limit" and is reset once the day is over.

### Burst rate limit

Additionally, the API is protected by a burst rate limit. This means you can't make more than 100 requests per second.
