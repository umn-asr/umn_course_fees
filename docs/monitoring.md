# Monitoring

- [Logs](#Logs)
- [Splunk](#Splunk)
- [Alerts](#Alerts)
  - [Exceeding Average SLA](#exceeding-average-sla)
  - [Exceeding Max SLA](#exceeding-max-sla)

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

## Alerts

### Exceeding Average SLA

On average, the service should respond to requests in under 200ms.

The search for this alert is

```
host="asr-coursefees*" 
sourcetype=ruby_on_rails source="*production*"  
status=200 |
timechart span=1m avg(duration) as average | 
search average > 200
```

| Field | Value |
| -- | -- |
| Title | Course Fees - Production - Average Response Time exceeds SLA |
| Description | On average, the service should respond to requests in under 200ms. |
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

### Exceeding Max SLA

We should not have response times greater than 400ms

The search for this alert is

```
host="asr-coursefees*" 
sourcetype=ruby_on_rails 
source="*production*" 
duration > 400
```

| Field | Value |
| -- | -- |
| Title | Course Fees - Production - Max Time exceeds SLA |
| Description | We should not have response times greater than 400ms |
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
