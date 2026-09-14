# Date Format

All dates in our API follow the `YYYY-MM-DD` format. Our database stores dates in Central European Time (CET/CEST - UTC+1/UTC+2).

### Date format specifications

- The API returns dates without specific time information
- Dates are stored and processed in Paris local time
- Date conversions automatically account for daylight saving time changes
- A date like `2024-12-01` represents the full day in Central European Time
  - `2024-11-30 23:30:00 UTC+0` will be considered as `2024-12-01` for instance

### Date filters

Date filters allow you to retrieve objects based on specific dates or date ranges.

**Single date filter**:

- Retrieves all objects for a specific date
- Format: `"YYYY-MM-DD"` (Year-Month-Day)
- Example: `"2024-12-01"` will return all objects dated December 1st, 2024

**Date range filter**:

- Retrieves objects within a specified date range
- Includes both start and end dates
- Format: `"start_date,end_date"`
- Example: `"2024-12-01,2024-12-31"` returns all objects from December 1st to December 31st, 2024
