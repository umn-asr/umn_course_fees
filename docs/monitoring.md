# Monitoring

- [Logs](#Logs)
- [Splunk](#Splunk)
  - [Alerts](#Alerts)
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

This application caches responses using Rack Cache. See more about this in [our Splunk documentation](https://github.umn.edu/asrweb/knowledgebucket/tree/main/splunk#caching-and-splunk).

## Alerts

This application uses our [standard Splunk alerts](https://github.umn.edu/asrweb/knowledgebucket/tree/main/splunk).

- The 95th Percentile limit is 250ms
- The average response time limit is 200ms

## Checkly

See [our Checkly docs](https://github.umn.edu/asrweb/knowledgebucket/tree/main/checkly) for details on what Checkly is and why we use it.

This application caches responses using Rack Cache. See more about this in [our Checkly documentation](https://github.umn.edu/asrweb/knowledgebucket/tree/main/checkly#caching-and-checkly).

### Checks

This application uses our [standard Checkly API checks](https://github.umn.edu/asrweb/knowledgebucket/tree/main/checkly) to monitor

- https://course-fees.umn.edu/campuses/UMNTC
- https://course-fees.umn.edu/campuses/UMNTC/terms

Note: We do not currently monitor the most-used endpoint, `terms/:term_id/courses` because the `term_id` value changes over time.
Currently Checkly's API checks can't visit a series of endpoints, so we can't do something like

1. Visit the `/campuses/:campus_id/terms` route
2. Parse the JSON to get a valid term id
3. Visit the `/terms/:term_id/courses` route using the term id from step 2

Even though we don't check this endpoint directly, we do check it with a Browser Check that loads the One Stop Course Fees Page that ensures everything works.

#### Additional configuration

The test for `/UMNTC` checks that JSON Body `$.data.id` contains "UMNTC"

The test for `/UMNTC/terms` checks that JSON Body `$.data[0].attributes.strm` is not empty
