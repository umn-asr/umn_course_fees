# Monitoring

- [Logs](#Logs)
- [Splunk](#Splunk)
  - [Caching and Splunk](#caching-and-splunk)
  - [Alerts](#Alerts)
    - 95% Under 250ms
    - Average Under 150ms
    - 5XX HTTP Status
- [Checkly](#Checkly)
  - [Caching and Checkly](#caching-and-checkly)
  - [Checks](#Checks)

## Logs
This application writes JSON-formatted Rails logs to disk. These logs are also ingested in to Splunk.

## Splunk

Splunk is the preferred way to see what the application is doing, set alerts and research historical activity.

- Connect to [Splunk](https://search.splunk.umn.edu/)
- Start your search with

```
host="asr-coursefees*" sourcetype=ruby_on_rails source="*production*"
```

and refine as needed.

### Examples


`...` stands in for any other search parameters you're using

#### See the average duration of page requests

```
... eval average_duration=avg(duration) |table average_duration
```

Note. This is in `ms`, so and average of 66 equals 66 milliseconds or `0.066` seconds.

## Caching and Splunk

To improve response speed, this application uses [Rack Cache](https://github.umn.edu/asrweb/umn_course_fees/pull/73). Requests that are served by the cache do not reach Rails and thus are not logged. You will see fewer requests in Splunk than you may expect; and Splunk alerts can only tell you details about un-cached requests.

## Alerts

### Process 95% of requests in under 250ms

Over a day-long span, the server should process 95% of requests in 250ms or less.

The search for this alert is

```
host="asr-coursefees*"
sourcetype=ruby_on_rails 
source="*production*"
status < 400 |
timechart span=1d p95(duration) as ninety_five |
search ninety_five > 250
```

| Field | Value |
| -- | -- |
| Title | Course Fees - Production - Process 95% of requests in under 250ms |
| Description | Over a day-long span, the server should process 95% of requests in 250ms or less. |
| Permissions | Shared In App |
| Alert Type | Scheduled |
| Schedule | Run every day |
| Expires | 24 hours |
| Trigger alert when | Number of results is greater than 0 |
| Trigger | Once |
| Throttle | Yes, for 1 day |

Configure Actions to 
- Email `asrweb@umn.edu`
- Add to triggered alerts, Medium
- Post to Slack in `#fixinstuff`
  - Set webhook URL to `lpass show 5516254219152436639`

### Average response time under 150ms

Over a day-long span, the server should process requests in an average of 200ms or less.

The search for this alert is

```
host="asr-coursefees*"
sourcetype=ruby_on_rails 
source="*production*"
status < 400 |
timechart span=1d avg(duration) as average |
search average > 200
```

| Field | Value |
| -- | -- |
| Title | Course Fees - Production - Average response time under 200ms |
| Description | Over a day-long span, the server should process requests in an average of 200ms or less. |
| Permissions | Shared In App |
| Alert Type | Scheduled |
| Schedule | Run every day |
| Expires | 24 hours |
| Trigger alert when | Number of results is greater than 0 |
| Trigger | Once |
| Throttle | Yes, for 1 day |

Configure Actions to 
- Email `asrweb@umn.edu`
- Add to triggered alerts, Medium
- Post to Slack in `#fixinstuff`
  - Set webhook URL to `lpass show 5516254219152436639`

### 5xx HTTP Status

We should not have 5xx Status Responses

The search for this alert is

```
host="asr-coursefees*" 
sourcetype=ruby_on_rails 
source="*production*" 
status=5**
```

| Field | Value |
| -- | -- |
| Title | Course Fees - Production - 5xx Status |
| Description | Course Fees service is emitting 5xx http status |
| Permissions | Shared In App |
| Alert Type | Scheduled |
| Schedule | Run on cron schedule, Last 15 minutes, `*/15 * * * *` |
| Expires | 24 hours |
| Trigger alert when | Number of results is greater than 0 |
| Trigger | Once |
| Throttle | Yes, for 1 day |

Configure Actions to 
- Email `asrweb@umn.edu`
- Add to triggered alerts, Medium
- Post to Slack in `#fixinstuff`
  - Set webhook URL to `lpass show 5516254219152436639`

## Checkly

See [our Checkly docs](https://github.umn.edu/asrweb/knowledgebucket/tree/main/checkly) for details on what Checkly is and why we use it.

### Caching and Checkly

Most of Checkly's requests will be retrieving cached responses. You may see blips where individual responses are slow. These represent times where Checkly made a request that was not cached.

### Checks

We use Checkly to monitor 2 endpoints of course-fees.umn.edu.

- https://course-fees.umn.edu/campuses/UMNTC
- https://course-fees.umn.edu/campuses/UMNTC/terms

Note: We do not currently monitor the most-used endpoint, `terms/:term_id/courses` because the `term_id` value changes over time.
Currently Checkly's API checks can't visit a series of endpoints, so we can't do something like

1. Visit the `/campuses/:campus_id/terms` route
2. Parse the JSON to get a valid term id
3. Visit the `/terms/:term_id/courses` route using the term id from step 2

Even though we don't check this endpoint directly, we do check it with a Browser Check that loads the One Stop Course Fees Page that ensures everything works.

Use the following configuration for the endpoints we monitor

#### Type
  - API Check
#### Name
  - Course Fees - Production - [PATH]
    - Ex: `Course Fees - Production - /campuses/umntc`
#### Request
  - `GET` request to one of the endpoints
#### Assertion & Limits
  - Status Code < 400
  - Response Time < 800ms
  - For `/UMNTC` check that JSON Body `$.data.id` contains "UMNTC"
  - For `/UMNTC/terms` check that JSON Body `$.data[0].attributes.strm` is not empty
#### Scheduling and Locations
  - Run every minute
  - Run from locations
    - Ohio
    - Oregon
#### Alerting
  - Double check on failure
  - Use global account notification settings
#### Setup & Teardown
  - N/A
#### CI/CD
  - N/A
